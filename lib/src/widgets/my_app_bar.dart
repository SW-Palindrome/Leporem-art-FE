import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
            color: Color(0xffADB3BE),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 24),
          child: IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              './assets/icons/notice.svg',
              color: Color(0xffADB3BE),
            ),
          ),
        ),
      ],
    );
  }
}
