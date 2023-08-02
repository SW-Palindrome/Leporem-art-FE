import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/configs/login_config.dart';
import 'package:leporemart/src/screens/buyer/review_compelete_screen.dart';
import 'package:leporemart/src/utils/dio_singleton.dart';

class ReviewController extends GetxController {
  Rx<String> description = Rx<String>('');
  Rx<int> star = 0.obs;

  TextEditingController descriptionController = TextEditingController();

  Future<void> createReview() async {
    try {
      final response = await DioSingleton.dio.post(
        '/orders/review',
        data: {
          'order_id': Get.arguments['order'].id,
          'rating': star.value,
          'comment': description.value,
        },
        options: Options(
          headers: {
            "Authorization":
                "Palindrome ${await getOAuthToken().then((value) => value!.idToken)}"
          },
        ),
      );
      if (response.statusCode != 201) {
        Get.snackbar("서버 오류", "요청중 오류가 발생했습니다. 다시시도해주세요.");
        throw ('{response.statusCode} / ${response.realUri} / ${response.data['message']}');
      }
      Get.until((route) => Get.currentRoute == '/BuyerOrderListScreen');
      Get.to(ReviewCompeleteScreen());
    } catch (e) {
      print('Error creating review: $e');
    }
  }
}
