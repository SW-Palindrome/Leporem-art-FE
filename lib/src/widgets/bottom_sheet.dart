import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyBottomSheet extends StatelessWidget {
  const MyBottomSheet({
    super.key,
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24, left: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: const Color(0xff191f28),
                  fontWeight: FontWeight.w600,
                  fontFamily: "PretendardVariable",
                  fontStyle: FontStyle.normal,
                  fontSize: 18,
                ),
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Get.back(); // bottomSheet 닫기
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 24, right: 24),
          child: Text(description,
              style: const TextStyle(
                  color: const Color(0xff191f28),
                  fontWeight: FontWeight.w400,
                  fontFamily: "PretendardVariable",
                  fontStyle: FontStyle.normal,
                  fontSize: 13),
              textAlign: TextAlign.left),
        ),
      ],
    );
  }
}
