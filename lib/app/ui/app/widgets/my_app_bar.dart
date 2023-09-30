import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../controller/buyer/home/buyer_home_controller.dart';
import '../../../controller/buyer/search/buyer_search_controller.dart';
import '../../../controller/seller/home/seller_home_controller.dart';
import '../../../controller/seller/search/seller_search_controller.dart';
import '../../../utils/log_analytics.dart';
import '../../theme/app_theme.dart';

enum AppBarType {
  mainPageAppBar,
  buyerSearchAppBar,
  buyerItemDetailAppBar,
  sellerSearchAppBar,
  sellerItemDetailAppBar,
  backAppBar,
  noticeAppBar,
  none,
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    super.key,
    required this.appBarType,
    this.isWhite = false,
    this.title,
    this.onTapLeadingIcon,
    this.onTapFirstActionIcon,
    this.onTapSecondActionIcon,
  });

  final AppBarType appBarType;
  final bool isWhite;
  final String? title;
  final Function()? onTapLeadingIcon;
  final Function()? onTapFirstActionIcon;
  final Function()? onTapSecondActionIcon;

  @override
  Size get preferredSize => AppBar().preferredSize;

  @override
  Widget build(BuildContext context) {
    switch (appBarType) {
      case AppBarType.mainPageAppBar:
        return _buyerMainPageAppBar();
      case AppBarType.buyerSearchAppBar:
        return _buyerSearchAppBar();
      case AppBarType.buyerItemDetailAppBar:
        return _buyerItemDetailAppBar();
      case AppBarType.sellerSearchAppBar:
        return _sellerSearchAppBar();
      case AppBarType.sellerItemDetailAppBar:
        return _sellerItemDetailAppBar();
      case AppBarType.backAppBar:
        return _backAppBar();
      case AppBarType.none:
        return _noneAppBar();
      // case AppBarType.backAppBar:
      //   return _backAppBar();
      case AppBarType.noticeAppBar:
        return _noticeAppBar();
      // case AppBarType.none:
      //   return _noneAppBar();
      default:
        return _buyerMainPageAppBar();
    }
  }

  _buyerMainPageAppBar() {
    return AppBar(
      backgroundColor: isWhite ? ColorPalette.white : ColorPalette.grey_1,
      elevation: 0,
      actions: [
        IconButton(
          onPressed: onTapFirstActionIcon,
          icon: SvgPicture.asset(
            './assets/icons/search.svg',
            colorFilter: ColorFilter.mode(ColorPalette.grey_5, BlendMode.srcIn),
          ),
        ),
        // IconButton(
        //   onPressed: onTapSecondActionIcon,
        //   icon: SvgPicture.asset(
        //     './assets/icons/notice.svg',
        //     colorFilter: ColorFilter.mode(ColorPalette.grey_5, BlendMode.srcIn),
        //   ),
        // ),
      ],
    );
  }

  _buyerItemDetailAppBar() {
    return AppBar(
      backgroundColor: isWhite ? ColorPalette.white : ColorPalette.grey_1,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset(
          'assets/icons/arrow_left.svg',
          colorFilter: ColorFilter.mode(ColorPalette.black, BlendMode.srcIn),
          width: 24,
        ),
        onPressed: onTapLeadingIcon,
      ),
      actions: [
        IconButton(
          onPressed: onTapFirstActionIcon,
          icon: SvgPicture.asset(
            'assets/icons/notice.svg',
            colorFilter: ColorFilter.mode(ColorPalette.grey_5, BlendMode.srcIn),
            width: 24,
          ),
        ),
        // IconButton(
        //   onPressed: onTapSecondActionIcon,
        //   icon: SvgPicture.asset(
        //     'assets/icons/share.svg',
        //     colorFilter: ColorFilter.mode(ColorPalette.grey_5, BlendMode.srcIn),
        //     width: 24,
        //   ),
        // ),
      ],
    );
  }

  _backAppBar() {
    return AppBar(
      backgroundColor: isWhite ? ColorPalette.white : ColorPalette.grey_1,
      elevation: 0,
      title: Text(
        title ?? '',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: ColorPalette.black,
        ),
      ),
      leading: IconButton(
        icon: SvgPicture.asset(
          'assets/icons/arrow_left.svg',
          width: 24,
        ),
        onPressed: onTapLeadingIcon,
      ),
    );
  }

  _noneAppBar() {
    return AppBar(
      backgroundColor: isWhite ? ColorPalette.white : ColorPalette.grey_1,
      elevation: 0,
      title: Text(
        title ?? '',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: ColorPalette.black,
        ),
      ),
    );
  }

  _buyerSearchAppBar() {
    return AppBar(
      backgroundColor: isWhite ? ColorPalette.white : ColorPalette.grey_1,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset(
          'assets/icons/arrow_left.svg',
          width: 24,
        ),
        onPressed: onTapLeadingIcon,
      ),
      title: Container(
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: ColorPalette.grey_2,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: TextField(
            controller: Get.find<BuyerSearchController>().searchController,
            onSubmitted: (value) async {
              logAnalytics(
                  name: "buyer_search",
                  parameters: {"action": "search", "keyword": value});
              Get.find<BuyerSearchController>().addRecentSearch(value);
              Get.find<BuyerSearchController>().isSearching.value = true;
              await Get.find<BuyerHomeController>().pageReset();
              Get.back();
            },
            decoration: InputDecoration.collapsed(
              hintText: '작품명 또는 작가명을 검색해주세요.',
              hintStyle: TextStyle(
                color: ColorPalette.grey_4,
              ),
            ),
            style: TextStyle(
              color: ColorPalette.black,
            ),
          ),
        ),
      ),
    );
  }

  _sellerItemDetailAppBar() {
    return AppBar(
      backgroundColor: isWhite ? ColorPalette.white : ColorPalette.grey_1,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset(
          'assets/icons/arrow_left.svg',
          colorFilter: ColorFilter.mode(ColorPalette.black, BlendMode.srcIn),
          width: 24,
        ),
        onPressed: onTapLeadingIcon,
      ),
      actions: [
        // IconButton(
        //   onPressed: onTapFirstActionIcon,
        //   icon: SvgPicture.asset(
        //     'assets/icons/list.svg',
        //     colorFilter: ColorFilter.mode(ColorPalette.grey_5, BlendMode.srcIn),
        //     width: 24,
        //   ),
        // ),
        IconButton(
          onPressed: onTapSecondActionIcon,
          icon: SvgPicture.asset(
            'assets/icons/edit.svg',
            colorFilter: ColorFilter.mode(ColorPalette.grey_5, BlendMode.srcIn),
            width: 24,
          ),
        ),
      ],
    );
  }

  _sellerSearchAppBar() {
    return AppBar(
      backgroundColor: isWhite ? ColorPalette.white : ColorPalette.grey_1,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset(
          'assets/icons/arrow_left.svg',
          width: 24,
        ),
        onPressed: onTapLeadingIcon,
      ),
      title: Container(
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: ColorPalette.grey_2,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: TextField(
            controller: Get.find<SellerSearchController>().searchController,
            onSubmitted: (value) async {
              logAnalytics(
                  name: "seller_search",
                  parameters: {"action": "search", "keyword": value});
              Get.find<SellerSearchController>().addRecentSearch(value);
              Get.find<SellerSearchController>().isSearching.value = true;
              await Get.find<SellerHomeController>().pageReset();
              Get.back();
            },
            decoration: InputDecoration.collapsed(
              hintText: '작품명을 검색해주세요.',
              hintStyle: TextStyle(
                color: ColorPalette.grey_4,
              ),
            ),
            style: TextStyle(
              color: ColorPalette.black,
            ),
          ),
        ),
      ),
    );
  }

  _noticeAppBar() {
    return AppBar(
      backgroundColor: isWhite ? ColorPalette.white : ColorPalette.grey_1,
      elevation: 0,
      actions: [
        IconButton(
          onPressed: onTapSecondActionIcon,
          icon: SvgPicture.asset(
            './assets/icons/notice.svg',
            colorFilter: ColorFilter.mode(ColorPalette.grey_5, BlendMode.srcIn),
          ),
        ),
      ],
    );
  }
}
