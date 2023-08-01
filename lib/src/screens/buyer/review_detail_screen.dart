import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/widgets/my_app_bar.dart';

class ReviewDetailScreen extends StatelessWidget {
  const ReviewDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        appBarType: AppBarType.backAppBar,
        title: '가로등 빛 받은 나뭇잎 컵',
        onTapLeadingIcon: () {
          Get.back();
        },
      ),
      body:
    );
  }
}
