import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
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
    this.title,
    this.onTapLeadingIcon,
    this.onTapFirstActionIcon,
    this.onTapSecondActionIcon,
  });

  final AppBarType appBarType;
  final String? title;
  final Function()? onTapLeadingIcon;
  final Function()? onTapFirstActionIcon;
  final Function()? onTapSecondActionIcon;

  @override
  Size get preferredSize => Size.fromHeight(40);

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
      // case AppBarType.searchAppBar:
      //   return _searchAppBar();
      // case AppBarType.none:
      //   return _noneAppBar();
      default:
        return _buyerMainPageAppBar();
    }
  }

  Widget _buyerMainPageAppBar() {
    return AppBar(
      elevation: 0,
      actions: [
        IconButton(
          onPressed: onTapFirstActionIcon,
          icon: SvgPicture.asset(
            './assets/icons/search.svg',
            colorFilter: ColorFilter.mode(ColorPalette.grey_4, BlendMode.srcIn),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 24),
          child: IconButton(
            onPressed: onTapSecondActionIcon,
            icon: SvgPicture.asset(
              './assets/icons/notice.svg',
              colorFilter:
                  ColorFilter.mode(ColorPalette.grey_4, BlendMode.srcIn),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buyerItemDetailAppBar() {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset(
          'assets/icons/arrow_left.svg',
          width: 24,
        ),
        onPressed: onTapLeadingIcon,
      ),
      actions: [
        IconButton(
          onPressed: onTapFirstActionIcon,
          icon: SvgPicture.asset(
            'assets/icons/notice.svg',
            width: 24,
          ),
        ),
        IconButton(
          onPressed: onTapSecondActionIcon,
          icon: SvgPicture.asset(
            'assets/icons/share.svg',
            width: 24,
          ),
        ),
      ],
    );
  }

  Widget _backAppBar() {
    return AppBar(
      elevation: 0,
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
      elevation: 0,
      title: Text(
        title!,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: ColorPalette.black,
        ),
      ),
    );
  }
}
