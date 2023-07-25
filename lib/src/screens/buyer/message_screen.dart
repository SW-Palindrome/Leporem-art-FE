import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/theme/app_theme.dart';
import 'package:leporemart/src/widgets/my_app_bar.dart';

import '../../widgets/my_bottom_navigationbar.dart';

class MessageScreen extends StatelessWidget {
  MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _emptyItemListWidget();
  }

  _emptyItemListWidget() {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 144),
          Image.asset(
            'assets/images/rabbit.png',
            height: 200,
          ),
          SizedBox(height: 24),
          Text(
            '아직 채팅 내역이 없어요.',
            style: TextStyle(
              fontSize: 16,
              color: ColorPalette.grey_5,
              fontFamily: "PretendardVariable",
            )
          ),
        ],
      ),
    );
  }
}
