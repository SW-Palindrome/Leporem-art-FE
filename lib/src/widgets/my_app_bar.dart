import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leporemart/src/theme/app_theme.dart';

enum AppBarType {
  mainPageAppBar,
  backAppBar,
  searchAppBar,
  none,
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    super.key,
    required this.appBarType,
    this.title,
    this.firstActionIcon,
    this.secondActionIcon,
    this.onTapFirstActionIcon,
    this.onTapSecondActionIcon,
  });

  final AppBarType appBarType;
  final String? title;
  final Widget? firstActionIcon;
  final Widget? secondActionIcon;
  final Function()? onTapFirstActionIcon;
  final Function()? onTapSecondActionIcon;

  @override
  Size get preferredSize => Size.fromHeight(40);

  @override
  Widget build(BuildContext context) {
    switch (appBarType) {
      case AppBarType.mainPageAppBar:
        return _mainPageAppBar();
      // case AppBarType.backAppBar:
      //   return _backAppBar();
      // case AppBarType.searchAppBar:
      //   return _searchAppBar();
      // case AppBarType.none:
      //   return _noneAppBar();
      default:
        return _mainPageAppBar();
    }
  }

  Widget _mainPageAppBar() {
    return AppBar(
      elevation: 0,
      actions: [
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            './assets/icons/search.svg',
            colorFilter: ColorFilter.mode(ColorPalette.grey_4, BlendMode.srcIn),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 24),
          child: IconButton(
            onPressed: () {},
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

  Widget _backAppBar() {
    return AppBar(
      elevation: 0,
      actions: [
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            './assets/icons/search.svg',
            colorFilter: ColorFilter.mode(ColorPalette.grey_4, BlendMode.srcIn),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 24),
          child: IconButton(
            onPressed: () {},
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
}
