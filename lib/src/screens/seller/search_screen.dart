import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/controllers/seller_search_controller.dart';
import 'package:leporemart/src/theme/app_theme.dart';
import 'package:leporemart/src/widgets/my_app_bar.dart';

class SellerSearchScreen extends GetView<SellerSearchController> {
  const SellerSearchScreen({super.key});

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
        child: _recentSearchView(),
      ),
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
                onTap: () => controller.clearRecentSearches(),
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
                  onTap: () => controller
                      .removeRecentSearch(controller.recentSearches[i]),
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
                        SvgPicture.asset(
                          'assets/icons/cancle.svg',
                          colorFilter: ColorFilter.mode(
                            ColorPalette.grey_4,
                            BlendMode.srcIn,
                          ),
                          width: 12,
                          height: 12,
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
