import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../configs/login_config.dart';
import '../../controller/account/agreement/agreement_controller.dart';
import '../../controller/buyer/home/buyer_home_controller.dart';
import '../../controller/buyer/item_creator/item_creator_controller.dart';
import '../../controller/buyer/profile/buyer_profile_controller.dart';
import '../../controller/common/user_global_info/user_global_info_controller.dart';
import '../../controller/seller/home/seller_home_controller.dart';
import '../../controller/seller/profile/seller_profile_controller.dart';
import '../../ui/app/account/login/login_screen.dart';
import '../../ui/app/buyer/review_complete/review_complete_screen.dart';
import '../models/item.dart';
import '../models/item_detail.dart';
import '../models/message.dart';
import '../models/order.dart';
import '../models/profile.dart';
import 'api.dart';

class DioClient implements ApiClient {
  late Dio _dioInstance;
  Logger logger = Logger(printer: PrettyPrinter());
  static final DioClient _instance = DioClient._internal();

  factory DioClient() => _instance;

  DioClient._internal() {
    _dioInstance = Dio();
    _dioInstance!.options.baseUrl = dotenv.get("BASE_URL");
    _dioInstance!.options.validateStatus = (status) {
      return status! < 500;
    };
    _dioInstance!.interceptors.add(
      InterceptorsWrapper(
        onResponse: (response, handler) async {
          if (response.statusCode == 401) {
            Exception('401: Unauthorized $response');
          } else if (response.statusCode == 403) {
            if (response.data['code'] == 'JWT_403_EXPIRED_ACCESSTOKEN') {
              final prefs = await SharedPreferences.getInstance();
              final refreshResponse = await _dioInstance.post('/users/refresh',
                  data: {'refresh_token': prefs.getString('refresh_token')});
              prefs.setString(
                  'access_token', refreshResponse.data['data']['access_token']);
              prefs.setString('refresh_token',
                  refreshResponse.data['data']['refresh_token']);
              response.requestOptions.headers['Authorization'] =
                  'Bearer ${prefs.getString('access_token')}';

              // 원래의 요청을 다시 실행
              try {
                print(
                    '재발급 후 원래의 요청을 다시 실행합니다. ${response.realUri}에서 오류 $response');
                return handler.next(await _dioInstance!.request(
                  response.requestOptions.path,
                  options: Options(
                    method: response.requestOptions.method,
                    headers: response.requestOptions.headers,
                    receiveTimeout: response.requestOptions.receiveTimeout,
                    sendTimeout: response.requestOptions.sendTimeout,
                    responseType: response.requestOptions.responseType,
                    extra: response.requestOptions.extra,
                    validateStatus: response.requestOptions.validateStatus,
                  ),
                ));
              } catch (e) {
                throw Exception('재발급 후 원래의 요청을 다시 실행하는데 실패했습니다. $e');
              }
            }
          }
          return handler.next(response);
        },
        onError: (error, handler) {
          print('에러경로: ${error.response!.realUri}');
          return handler.next(error);
        },
      ),
    );
  }

  @override
  Future<void> sendEmail(String emailAddress) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');
      final response = await _dioInstance.post(
        "/sellers/register",
        data: {
          "email": emailAddress,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
          },
        ),
      );
      if (response.statusCode == 200) {
        print("이메일 전송 성공");
      }
      if (response.statusCode == 400) {
        print("이메일 전송 실패");
      }
    } catch (e) {
      print("이메일 전송 실패");
    }
  }

  @override
  Future<bool> checkCode(String emailCode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');
      final response = await _dioInstance.post(
        "/sellers/verify",
        data: {
          "verify_code": emailCode,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
          },
        ),
      );
      if (response.statusCode == 200) {
        if (response.data["message"] == "success") {
          logger.d("코드 확인 성공");
          return false;
        } else {
          logger.e("코드 확인 실패");
          return true;
        }
      }
      if (response.statusCode == 400) {
        logger.e("코드 확인 실패400");
        return true;
      } else {
        logger.e("코드 확인 실패");
        return true;
      }
    } catch (e) {
      logger.e("코드 확인 실패 에러");
      return true;
    }
  }

  @override
  Future<bool> isDuplicate(String nickname) async {
    try {
      final response =
          await _dioInstance.get("/users/validate/nickname/$nickname");
      if (response.statusCode == 200) {
        return false;
      }
      return true;
    } catch (e) {
      return true;
    }
  }

  @override
  Future<bool> signupWithKakao(String nickname) async {
    try {
      String? idToken = await getOAuthToken().then((value) => value!.idToken);
      final response = await _dioInstance.post("/users/signup/kakao", data: {
        "id_token": idToken,
        "nickname": nickname,
        "is_agree_privacy": true,
        "is_agree_terms": true,
        "is_agree_ads": Get.find<AgreementController>().agreedList[2],
      });
      if (response.statusCode == 201) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(
            'access_token', response.data['data']['access_token']);
        await prefs.setString(
            'refresh_token', response.data['data']['refresh_token']);
        return true;
      }
      if (response.statusCode == 400) {
        Get.snackbar("회원가입 실패", "잘못된 요청입니다. 다시시도해주세요.");
      }
      return false;
    } catch (e) {
      Get.snackbar("서버 오류", "요청중 오류가 발생했습니다. 다시시도해주세요.");
      return false;
    }
  }

  @override
  Future<bool> signupWithApple(String userIdentifier, String nickname) async {
    try {
      final response = await _dioInstance.post("/users/signup/apple", data: {
        "user_data": userIdentifier,
        "nickname": nickname,
        "is_agree_privacy": true,
        "is_agree_terms": true,
        "is_agree_ads": Get.find<AgreementController>().agreedList[2],
      });
      if (response.statusCode == 201) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(
            'access_token', response.data['data']['access_token']);
        await prefs.setString(
            'refresh_token', response.data['data']['refresh_token']);
        return true;
      }
      if (response.statusCode == 400) {
        Get.snackbar("회원가입 실패", "잘못된 요청입니다. 다시시도해주세요.");
      }
      return false;
    } catch (e) {
      Get.snackbar("서버 오류", "요청중 오류가 발생했습니다. 다시시도해주세요.");
      return false;
    }
  }

  @override
  Future<void> registerFcmDevice() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    final response = await _dioInstance.post(
      '/notifications/register',
      data: {
        'fcm_token': fcmToken,
      },
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to register fcm device');
    }
  }

  @override
  Future<void> like(int itemId) async {
    try {
      // API 요청
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');
      final response = await _dioInstance.post('/items/like',
          data: {'item_id': itemId},
          options: Options(
            headers: {
              "Authorization": "Bearer $accessToken",
            },
          ));
      // 200이 아니라면 오류
      if (response.statusCode != 200) {
        logger
            .e('Status Code: ${response.statusCode} / Body: ${response.data}');
      }
    } catch (e) {
      // 에러 처리
      logger.e('Error fetching like $itemId in home $e');
    }
  }

  @override
  Future<void> unlike(int itemId) async {
    try {
      // API 요청
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');
      final response = await _dioInstance.delete(
        '/items/like',
        data: {'item_id': itemId},
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
          },
        ),
      );
      // 200이 아니라면 오류
      if (response.statusCode != 200) {
        logger
            .e('Status Code: ${response.statusCode} / Body: ${response.data}');
      }
    } catch (e) {
      logger.e('Error fetching like $itemId in home $e');
    }
  }

  @override
  Future<void> view(int itemId) async {
    try {
      // API 요청
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');

      if (Get.find<UserGlobalInfoController>().userType == UserType.member) {
        final response = await _dioInstance.post(
          '/items/viewed',
          data: {'item_id': itemId},
          options: Options(
            headers: {
              "Authorization": "Bearer $accessToken",
            },
          ),
        );
        if (response.statusCode != 201) {
          logger.e(
              'Status Code: ${response.statusCode} / Body: ${response.data}');
        }
      }
    } catch (e) {
      // 에러 처리
      logger.e('Error fetching viewed $itemId in home $e');
    }
  }

  @override
  Future<bool> deleteRecentItem(int itemId) async {
    try {
      // API 요청
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');
      final response = await _dioInstance.delete(
        '/items/viewed',
        data: {'item_id': itemId},
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
          },
        ),
      );
      // 200이 아니라면 오류
      if (response.statusCode != 200) {
        logger
            .e('Status Code: ${response.statusCode} / Body: ${response.data}');
        return false;
      }
      return true;
    } catch (e) {
      // 에러 처리
      logger.e('Error delete $itemId in home $e');
      return false;
    }
  }

  @override
  Future<void> editBuyerProfile(bool isNicknameChanged,
      bool isProfileImageChanged, String nickname, File profileImage) async {
    try {
      if (isNicknameChanged) {
        try {
          final prefs = await SharedPreferences.getInstance();
          final accessToken = prefs.getString('access_token');
          final response = await _dioInstance.patch(
            "/users/nickname",
            data: {
              "nickname": nickname,
            },
            options: Options(
              headers: {
                "Authorization": "Bearer $accessToken",
              },
            ),
          );

          if (response.statusCode != 200) {
            throw Exception('Status code: ${response.statusCode}');
          }
        } catch (e) {
          throw ('Error editing nickname: $e');
        }
      }
      if (isProfileImageChanged) {
        try {
          final formData = FormData.fromMap({
            "profile_image": await MultipartFile.fromFile(
              profileImage.path,
              filename: profileImage.path.split('/').last,
            ),
          });
          final prefs = await SharedPreferences.getInstance();
          final accessToken = prefs.getString('access_token');
          final response = await _dioInstance.patch(
            "/users/profile-image",
            data: formData,
            options: Options(
              headers: {
                "Authorization": "Bearer $accessToken",
              },
            ),
          );

          if (response.statusCode != 200) {
            logger.e('Status code: ${response.statusCode}');
          }
        } catch (e) {
          logger.e('Error editing profile image: $e');
        }
      }
      Get.back();
      Get.snackbar('프로필 수정', '프로필이 수정되었습니다.');
      Get.find<BuyerProfileController>().fetch();
      Get.find<BuyerProfileController>().fetch();
    } catch (e) {
      logger.e('Error editing profile: $e');
    }
  }

  @override
  Future<void> editSellerProfile(
      bool isNicknameChanged,
      bool isProfileImageChanged,
      bool isDescriptionChanged,
      String nickname,
      File profileImage,
      String description) async {
    try {
      if (isNicknameChanged) {
        try {
          final prefs = await SharedPreferences.getInstance();
          final accessToken = prefs.getString('access_token');
          final response = await _dioInstance.patch(
            "/users/nickname",
            data: {
              "nickname": nickname,
            },
            options: Options(
              headers: {
                "Authorization": "Bearer $accessToken",
              },
            ),
          );

          if (response.statusCode != 200) {
            throw Exception('Status code: ${response.statusCode}');
          } else {
            Get.find<UserGlobalInfoController>().nickname = nickname;
          }
        } catch (e) {
          logger.e('Error editing nickname: $e');
          return;
        }
      }
      if (isProfileImageChanged) {
        try {
          final formData = FormData.fromMap({
            "profile_image": await MultipartFile.fromFile(
              profileImage.path,
              filename: profileImage.path.split('/').last,
            ),
          });
          final prefs = await SharedPreferences.getInstance();
          final accessToken = prefs.getString('access_token');
          final response = await _dioInstance.patch(
            "/users/profile-image",
            data: formData,
            options: Options(
              headers: {
                "Authorization": "Bearer $accessToken",
              },
            ),
          );

          if (response.statusCode != 200) {
            logger.e('Status code: ${response.statusCode}');
            return;
          }
        } catch (e) {
          logger.e('Error editing profile image: $e');
        }
      }
      if (isDescriptionChanged) {
        try {
          final prefs = await SharedPreferences.getInstance();
          final accessToken = prefs.getString('access_token');
          final response = await _dioInstance.patch(
            "/sellers/descriptions",
            data: {
              "description": description,
            },
            options: Options(
              headers: {
                "Authorization": "Bearer $accessToken",
              },
            ),
          );

          if (response.statusCode != 200) {
            logger.e('Status code: ${response.statusCode}');
            return;
          }
        } catch (e) {
          logger.e('Error editing description: $e');
          return;
        }
      }
      Get.back();
      Get.snackbar('프로필 수정', '프로필이 수정되었습니다.');
      Get.find<SellerProfileController>().fetch();
      Get.find<SellerProfileController>().fetch();
    } catch (e) {
      logger.e('Error editing profile: $e');
    }
  }

  @override
  Future<void> inactive() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');
    final response = await _dioInstance.post(
      "/users/inactive",
      options: Options(
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ),
    );

    if (response.statusCode != 200) {
      logger.e(
          'Status code: ${response.statusCode}, Response Data: ${response.data}');
      return;
    }
    prefs.setString('access_token', '');
    Get.offAll(LoginScreen());
  }

  @override
  Future<void> createReview(int orderId, int star, String description) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');
      final response = await _dioInstance.post(
        '/orders/review',
        data: {
          'order_id': Get.arguments['order'].id,
          'rating': star,
          'comment': description,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
          },
        ),
      );
      if (response.statusCode != 201) {
        Get.snackbar("서버 오류", "요청중 오류가 발생했습니다. 다시시도해주세요.");
        logger.e(
            '{response.statusCode} / ${response.realUri} / ${response.data['message']}');
        return;
      }
      Get.until((route) => Get.currentRoute == '/BuyerOrderListScreen');
      Get.to(ReviewCompleteScreen());
    } catch (e) {
      logger.e('Error creating review: $e');
    }
  }

  @override
  Future<dynamic> getPreSignedUrl(String extension) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');
    final response = await _dioInstance.get(
      '/sellers/shorts/upload-url',
      queryParameters: {'extension': extension},
      options: Options(
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ),
    );
    return response;
  }

  @override
  Future<dynamic> createItem(FormData formData) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');
    final response = await _dioInstance.post(
      '/sellers/items',
      data: formData,
      options: Options(
        contentType: 'multipart/form-data',
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ),
    );
    return response;
  }

  @override
  Future<dynamic> editItem(int itemId, FormData formData) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');
    final response = await _dioInstance.patch(
      '/sellers/items/$itemId',
      data: formData,
      options: Options(
        contentType: 'multipart/form-data',
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ),
    );
    return response;
  }

  @override
  Future<dynamic> increaseAmount(int itemId) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');
    final response = await _dioInstance.patch(
      '/sellers/current-amount',
      data: {
        'item_id': Get.arguments['item_id'],
        'action': 1,
      },
      options: Options(
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ),
    );
    return response;
  }

  @override
  Future<dynamic> decreaseAmount(int itemId) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');
    final response = await _dioInstance.patch(
      '/sellers/current-amount',
      data: {
        'item_id': Get.arguments['item_id'],
        'action': -1,
      },
      options: Options(
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ),
    );
    return response;
  }

  @override
  Future<List<BuyerHomeItem>> fetchBuyerHomeItems(
    int page, {
    String? keyword,
    String? ordering,
    String? category,
    String? price,
    isPagination = false,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');
      final response = await _dioInstance.get('/items/filter',
          queryParameters: {
            'page': page,
            'search': keyword,
            'ordering': ordering,
            'category': category,
            'price': price,
          },
          options: Options(
            headers: {
              "Authorization": "Bearer $accessToken",
            },
          ));
      //rseponse의 message가 EmptyPage라면 데이터가 없는 것이므로 빈 리스트를 반환, 또한 pagination용 요청이면 currentPage를 1 감소시킴
      if (response.data['message'] == 'EmptyPage') {
        if (isPagination) Get.find<BuyerHomeController>().currentPage--;
        return [];
      }
      final data = response.data;
      //items를 리스트에 넣고 파싱
      final List<dynamic> itemsData = data['items'];
      // 아이템 데이터를 변환하여 리스트로 생성
      final List<BuyerHomeItem> items =
          itemsData.map((json) => BuyerHomeItem.fromJson(json)).toList();
      return items;
    } catch (e) {
      // 에러 처리
      logger.e('Error fetching buyer home items in repository: $e');
      return [];
    }
  }

  @override
  Future<List<BuyerHomeItem>> fetchGuestHomeItems(
    int page, {
    String? keyword,
    String? ordering,
    String? category,
    String? price,
    isPagination = false,
  }) async {
    try {
      final response = await _dioInstance.get(
        '/items/guest',
        queryParameters: {
          'page': page,
          'search': keyword,
          'ordering': ordering,
          'category': category,
          'price': price,
        },
      );
      //rseponse의 message가 EmptyPage라면 데이터가 없는 것이므로 빈 리스트를 반환, 또한 pagination용 요청이면 currentPage를 1 감소시킴
      if (response.data['message'] == 'EmptyPage') {
        if (isPagination) Get.find<BuyerHomeController>().currentPage--;
        return [];
      }
      final data = response.data;
      //items를 리스트에 넣고 파싱
      final List<dynamic> itemsData = data['items'];
      // 아이템 데이터를 변환하여 리스트로 생성
      final List<BuyerHomeItem> items =
          itemsData.map((json) => BuyerHomeItem.fromJson(json)).toList();
      return items;
    } catch (e) {
      // 에러 처리
      logger.e('Error fetching buyer home items in repository: $e');
      return [];
    }
  }

  @override
  Future<List<BuyerHomeItem>> fetchBuyerCreatorItems(
    int page, {
    String? nickname,
    isPagination = false,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');
      final response = await _dioInstance.get(
        '/items/filter',
        queryParameters: {
          'page': page,
          'nickname': nickname,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
          },
        ),
      );
      if (response.data['message'] == 'EmptyPage') {
        if (isPagination) Get.find<ItemCreatorController>().currentPage--;
        return [];
      }
      final data = response.data;
      //items를 리스트에 넣고 파싱
      final List<dynamic> itemsData = data['list']['items'];
      // 아이템 데이터를 변환하여 리스트로 생성
      final List<BuyerHomeItem> items =
          itemsData.map((json) => BuyerHomeItem.fromJson(json)).toList();
      return items;
    } catch (e) {
      // 에러 처리
      logger.e('Error fetching item creators in repository: $e');
      return [];
    }
  }

  @override
  Future<List<SellerHomeItem>> fetchSellerHomeItems(
    int page, {
    String? nickname,
    String? ordering,
    String? keyword,
    isPagination = false,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');
      final response = await _dioInstance.get(
        '/items/filter',
        queryParameters: {
          'page': page,
          'nickname': nickname,
          'ordering': ordering,
          'search': keyword,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
          },
        ),
      );
      final data = response.data;
      //items를 리스트에 넣고 파싱
      final List<dynamic> itemsData = data['list']['items'];
      Get.find<SellerHomeController>().totalCount.value =
          data['list']['total_count'];

      // 아이템 데이터를 변환하여 리스트로 생성
      final List<SellerHomeItem> items =
          itemsData.map((json) => SellerHomeItem.fromJson(json)).toList();
      return items;
    } catch (e) {
      // 에러 처리
      logger.e('Error fetching seller home items in repository: $e');
      return [];
    }
  }

  @override
  Future<BuyerItemDetail?> fetchBuyerItemDetail(int itemID) async {
    try {
      // API 요청
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');
      if (Get.find<UserGlobalInfoController>().userType == UserType.member) {
        final response = await _dioInstance.get(
          '/items/detail/buyer',
          queryParameters: {'item_id': itemID},
          options: Options(
            headers: {
              "Authorization": "Bearer $accessToken",
            },
          ),
        );
        final data = response.data['detail'];
        // API 응답을 Item 모델로 변환
        final BuyerItemDetail itemDetail = BuyerItemDetail.fromJson(data);

        return itemDetail;
      } else {
        final response = await _dioInstance.get(
          '/items/detail/guest',
          queryParameters: {'item_id': itemID},
        );
        final data = response.data['detail'];
        // API 응답을 Item 모델로 변환
        final BuyerItemDetail itemDetail = BuyerItemDetail.fromJson(data);

        return itemDetail;
      }
    } catch (e) {
      // 에러 처리
      logger.e('Error fetching item detail in repository: $e');
    }
  }

  @override
  Future<SellerItemDetail?> fetchSellerItemDetail(int itemID) async {
    try {
      // API 요청
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');
      final response = await _dioInstance.get(
        '/items/detail/seller',
        queryParameters: {'item_id': itemID},
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
          },
        ),
      );
      final data = response.data['detail'];
      // API 응답을 Item 모델로 변환
      final SellerItemDetail itemDetail = SellerItemDetail.fromJson(data);

      return itemDetail;
    } catch (e) {
      // 에러 처리
      logger.d('Error fetching item detail in repository: $e');
    }
  }

  @override
  Future<List<MessageItem>> fetchShareMessageItem(int page,
      {String? nickname}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');
      final response = await _dioInstance.get(
        '/items/filter',
        queryParameters: {
          'nickname': nickname,
          'page': page,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
          },
        ),
      );
      final data = response.data;
      //items를 리스트에 넣고 파싱
      final List<dynamic> itemsData = data['list']['items'];

      // 아이템 데이터를 변환하여 리스트로 생성
      final List<MessageItem> items =
          itemsData.map((json) => MessageItem.fromJson(json)).toList();
      return items;
    } catch (e) {
      // 에러 처리
      logger.e('Error fetching chat item share in repository: $e');
      return [];
    }
  }

  @override
  Future<List<MessageItem>> fetchOrderMessageItem(int page,
      {String? nickname}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');
      final response = await _dioInstance.get(
        '/items/filter',
        queryParameters: {
          'nickname': nickname,
          'page': page,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
          },
        ),
      );
      final data = response.data;
      //items를 리스트에 넣고 파싱
      final List<dynamic> itemsData = data['list']['items'];

      // 아이템 데이터를 변환하여 리스트로 생성 remainAmount가 0이면 추가하지 않음
      List<MessageItem> items = [];
      for (var i = 0; i < itemsData.length; i++) {
        if (itemsData[i]['current_amount'] != 0) {
          items.add(MessageItem.fromJson(itemsData[i]));
        }
      }
      return items;
    } catch (e) {
      // 에러 처리
      logger.e('Error fetching chat item share in repository: $e');
      return [];
    }
  }

  @override
  Future<int?> orderItem(int itemId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');
      final response = await _dioInstance.post(
        '/orders/register',
        data: {
          'item_id': itemId,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
          },
        ),
      );
      if (response.statusCode == 400) {
        if (response.data['message'] == '재고가 없습니다.') {
          throw ('재고가 없습니다.');
        } else if (response.data['meessage'] == '자신의 상품은 주문할 수 없습니다.') {
          throw ('자신의 상품은 주문할 수 없습니다.');
        }
      }
      if (response.statusCode == 201) {
        return response.data['order_id'];
      }
      throw ('response: ${response.statusCode} / ${response.realUri}');
    } catch (e) {
      // 에러 처리
      logger.e('Error fetching chat item share in repository: $e');
    }
  }

  @override
  Future<List<ChatRoom>> fetchBuyerChatRooms() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');
      final response = await _dioInstance.get(
        '/chats/buyer',
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
          },
        ),
        queryParameters: {
          'only_last_message': true,
        },
      );
      final data = response.data;
      List<ChatRoom> chatRoomList = [];
      for (var i = 0; i < data.length; i++) {
        ChatRoom chatRoom = ChatRoom.fromJson(data[i]);
        chatRoom.isBuyerRoom = true;
        chatRoomList.add(chatRoom);
      }
      return chatRoomList;
    } catch (e) {
      // 에러 처리
      logger.e('Error fetching chat rooms in repository: $e');
      return [];
    }
  }

  @override
  Future<List<ChatRoom>> fetchSellerChatRooms() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');
      final response = await _dioInstance.get(
        '/chats/seller',
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
          },
        ),
        queryParameters: {
          'only_last_message': true,
        },
      );
      if (response.statusCode == 403) {
        return [];
      }
      final data = response.data;
      List<ChatRoom> chatRoomList = [];
      for (var i = 0; i < data.length; i++) {
        ChatRoom chatRoom = ChatRoom.fromJson(data[i]);
        chatRoom.isBuyerRoom = false;
        chatRoomList.add(chatRoom);
      }
      return chatRoomList;
    } catch (e) {
      // 에러 처리
      logger.e('Error fetching chat rooms in repository: $e');
      return [];
    }
  }

  @override
  Future<List<Message>> fetchChatRoomMessages(
      String chatRoomUuid, String? messageUuid) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');
    final response = await _dioInstance.get(
      '/chats/chat-rooms/$chatRoomUuid/messages',
      queryParameters: {'message_uuid': messageUuid},
      options: Options(
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ),
    );
    final data = response.data['results'];
    List<Message> messageList = [];
    for (var i = 0; i < data.length; i++) {
      Message message = Message.fromJson(data[i]);
      messageList.add(message);
    }
    return messageList.reversed.toList();
  }

  @override
  Future<void> readChatRoomMessages(ChatRoom chatRoom, Message message) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');
    final response = await _dioInstance.patch(
      '/chats/messages/read',
      data: {
        'chat_room_uuid': chatRoom.chatRoomUuid,
        'message_uuid': message.messageUuid,
      },
      options: Options(
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ),
    );
    if (response.statusCode != 204) {
      logger.e('Error reading chat room messages in repository: $response');
    }
  }

  @override
  Future<List<BuyerOrder>> fetchBuyerOrders() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');
      final response = await _dioInstance.get(
        '/buyers/orders/my',
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
          },
        ),
      );
      // 데이터를 변환하여 리스트로 생성

      // List<dynamic>형태인 response.data를 각각 인덱스로 접근해 Order.fromJson으로 변환
      final List<BuyerOrder> orders = List<BuyerOrder>.from(
          response.data.map((json) => BuyerOrder.fromJson(json)));
      return orders;
    } catch (e) {
      // 에러 처리
      logger.e('Error fetching buyer order list in repository: $e');
      return [];
    }
  }

  @override
  Future<List<SellerOrder>> fetchSellerOrders() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');
      final response = await _dioInstance.get(
        '/sellers/orders/my',
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
          },
        ),
      );
      // 데이터를 변환하여 리스트로 생성

      // List<dynamic>형태인 response.data를 각각 인덱스로 접근해 Order.fromJson으로 변환
      final List<SellerOrder> orders = List<SellerOrder>.from(
          response.data.map((json) => SellerOrder.fromJson(json)));
      return orders;
    } catch (e) {
      // 에러 처리
      logger.e('Error fetching buyer order list in repository: $e');
      return [];
    }
  }

  @override
  Future<void> deliveryStartOrder(int orderId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');
      final response = await _dioInstance.post(
        '/orders/$orderId/delivery-start',
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
          },
        ),
      );
      print('response: ${response.statusCode} / ${response.realUri}');
    } catch (e) {
      // 에러 처리
      logger.e('Error fetching delivery start list in repository: $e');
    }
  }

  @override
  Future<void> deliveryCompleteOrder(int orderId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');
      final response = await _dioInstance.post(
        '/orders/$orderId/delivery-complete',
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
          },
        ),
      );
      print('response: ${response.statusCode} / ${response.realUri}');
    } catch (e) {
      // 에러 처리
      logger.e('Error fetching delivery complete in repository: $e');
    }
  }

  @override
  Future<void> cancelOrder(int orderId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');
      final response = await _dioInstance.post(
        '/orders/$orderId/cancel',
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
          },
        ),
      );
      print('response: ${response.statusCode} / ${response.realUri}');
    } catch (e) {
      // 에러 처리
      logger.e('Error fetching cancel order list in repository: $e');
    }
  }

  @override
  Future<OrderInfo> fetchOrder(int orderId) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');
    final response = await _dioInstance.get(
      '/orders/$orderId',
      options: Options(
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ),
    );
    return OrderInfo.fromJson(response.data);
  }

  @override
  Future<DeliveryInfo> fetchDeliveryInfo(int orderId) async {
    final response = await Dio().get(
      'http://info.sweettracker.co.kr/api/v1/trackingInfo',
      queryParameters: {
        't_key': 'uAyk561vd8r79J6rtdqj7Q',
        't_code': '05',
        't_invoice': '454121749896',
      }
    );
    return DeliveryInfo.fromJson(response.data);
  }

  @override
  Future<BuyerProfile?> fetchBuyerProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');
      final response = await _dioInstance.get(
        '/buyers/info',
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
          },
        ),
      );
      final data = response.data;
      final BuyerProfile buyerProfile = BuyerProfile.fromJson(data);
      return buyerProfile;
    } catch (e) {
      // 에러 처리
      logger.e('Error fetching buyer profile in repository: $e');
    }
  }

  @override
  Future<SellerProfile?> fetchSellerProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');
      final response = await _dioInstance.get(
        '/sellers/info',
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
          },
        ),
      );
      final data = response.data;
      final SellerProfile sellerProfile = SellerProfile.fromJson(data);
      return sellerProfile;
    } catch (e) {
      // 에러 처리
      logger.e('Error fetching seller profile in repository: $e');
    }
  }

  @override
  Future<SellerProfile?> fetchCreatorProfile(String nickname) async {
    try {
      final response = await _dioInstance.get(
        '/sellers/info/$nickname',
      );
      final data = response.data;
      final SellerProfile sellerProfile = SellerProfile.fromJson(data);
      return sellerProfile;
    } catch (e) {
      // 에러 처리
      logger.e('Error fetching creator profile in repository: $e');
    }
  }

  @override
  Future<List<RecentItem>> fetchRecentItems() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');
      final response = await _dioInstance.get(
        '/items/viewed',
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
          },
        ),
      );
      final data = response.data;
      final List<dynamic> itemsData = data['items'];
      final List<RecentItem> items =
          itemsData.map((json) => RecentItem.fromJson(json)).toList();
      return items;
    } catch (e) {
      logger.e('Error fetching recent items in repository: $e');
      return [];
    }
  }

  @override
  Future<dynamic> getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');
    final response = await _dioInstance.get(
      '/users/info/my',
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
    return response;
  }
}
