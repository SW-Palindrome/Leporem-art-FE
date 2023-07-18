import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leporemart/src/theme/app_theme.dart';

enum AppBarType {
  buyerMainPageAppBar,
  buyerItemDetailAppBar,
  sellerMainPageAppBar,
  sellerItemDetailAppBar,
  backAppBar,
  searchAppBar,
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
      case AppBarType.buyerMainPageAppBar:
        return _buyerMainPageAppBar();
      case AppBarType.buyerItemDetailAppBar:
        return _buyerItemDetailAppBar();
      case AppBarType.backAppBar:
        return _backAppBar();
      case AppBarType.none:
        return _noneAppBar();
      // case AppBarType.backAppBar:
      //   return _backAppBar();
      case AppBarType.searchAppBar:
        return _searchAppBar();
      // case AppBarType.none:
      //   return _noneAppBar();
      default:
        return _buyerMainPageAppBar();
    }
  }

  Widget _buyerMainPageAppBar() {
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

  Widget _buyerItemDetailAppBar() {
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
        IconButton(
          onPressed: onTapSecondActionIcon,
          icon: SvgPicture.asset(
            'assets/icons/share.svg',
            colorFilter: ColorFilter.mode(ColorPalette.grey_5, BlendMode.srcIn),
            width: 24,
          ),
        ),
      ],
    );
  }

  Widget _backAppBar() {
    return AppBar(
      backgroundColor: isWhite ? ColorPalette.white : ColorPalette.grey_1,
      elevation: 0,
      title: Text(
        title ?? '',
        style: TextStyle(
          fontSize: 20,
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

  Widget _noneAppBar() {
    return AppBar(
      backgroundColor: isWhite ? ColorPalette.white : ColorPalette.grey_1,
      elevation: 0,
      title: Text(
        title ?? '',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: ColorPalette.black,
        ),
      ),
    );
  }

  Widget _searchAppBar() {
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
}
