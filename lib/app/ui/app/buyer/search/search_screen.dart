import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../controller/buyer/home/buyer_home_controller.dart';
import '../../../../controller/buyer/search/buyer_search_controller.dart';
import '../../../../utils/log_analytics.dart';
import '../../../theme/app_theme.dart';
import '../../widgets/my_app_bar.dart';

class BuyerSearchScreen extends GetView<BuyerSearchController> {
  const BuyerSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        appBarType: AppBarType.buyerSearchAppBar,
        onTapLeadingIcon: () {
          Get.back();
        },
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        color: ColorPalette.grey_1,
        child: Column(
          children: [
            // _otherSearchView(),
            // SizedBox(height: 20),
            _recentSearchView(),
          ],
        ),
      ),
    );
  }

  _otherSearchView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 15),
          child: Row(
            children: [
              Text(
                '많이 찾고 있어요!',
                style: TextStyle(
                  color: ColorPalette.black,
                  fontWeight: FontWeight.w600,
                  fontFamily: "PretendardVariable",
                  fontStyle: FontStyle.normal,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for (int i = 0; i < 10; i++)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    color: ColorPalette.grey_3,
                  ),
                ),
                child: Text(
                  "물잔",
                  style: TextStyle(
                    color: ColorPalette.black,
                    fontFamily: "PretendardVariable",
                    fontStyle: FontStyle.normal,
                    fontSize: 14.0,
                  ),
                ),
              )
          ],
        )
      ],
    );
  }

  _recentSearchView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '최근 검색어',
                style: TextStyle(
                  color: ColorPalette.black,
                  fontWeight: FontWeight.w600,
                  fontFamily: "PretendardVariable",
                  fontStyle: FontStyle.normal,
                  fontSize: 16.0,
                ),
              ),
              GestureDetector(
                onTap: () {
                  logAnalytics(
                      name: "buyer_search",
                      parameters: {"action": "delete_all_recent_searches"});
                  controller.clearRecentSearches();
                },
                child: Text(
                  '전체 삭제',
                  style: TextStyle(
                    color: ColorPalette.grey_5,
                    fontWeight: FontWeight.w600,
                    fontFamily: "PretendardVariable",
                    fontStyle: FontStyle.normal,
                    fontSize: 12.0,
                  ),
                ),
              ),
            ],
          ),
        ),
        Obx(
          () => Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              for (int i = 0; i < controller.recentSearches.length; i++)
                GestureDetector(
                  onTap: () async {
                    logAnalytics(name: "buyer_search", parameters: {
                      "action": "recent_search",
                      "keyword": controller.recentSearches[i]
                    });
                    controller.searchController.text =
                        controller.recentSearches[i];
                    controller.isSearching.value = true;
                    await Get.find<BuyerHomeController>().pageReset();
                    Get.back();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        color: ColorPalette.grey_3,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          controller.recentSearches[i],
                          style: TextStyle(
                            color: ColorPalette.black,
                            fontFamily: "PretendardVariable",
                            fontStyle: FontStyle.normal,
                            fontSize: 14.0,
                          ),
                        ),
                        SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            logAnalytics(name: "buyer_search", parameters: {
                              "action": "delete_recent_search",
                              "keyword": controller.recentSearches[i]
                            });
                            controller.removeRecentSearch(
                                controller.recentSearches[i]);
                          },
                          child: SvgPicture.asset(
                            'assets/icons/cancel.svg',
                            colorFilter: ColorFilter.mode(
                              ColorPalette.grey_4,
                              BlendMode.srcIn,
                            ),
                            width: 12,
                            height: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
            ],
          ),
        )
      ],
    );
  }
}
