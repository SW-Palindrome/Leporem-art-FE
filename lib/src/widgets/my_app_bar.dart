import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            './assets/icons/search.svg',
            color: Color(0xffADB3BE),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            './assets/icons/notice.svg',
            color: Color(0xffADB3BE),
          ),
        ),
      ],
    );
  }
}
