import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leporemart/src/theme/app_theme.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(40);

  @override
  Widget build(BuildContext context) {
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
