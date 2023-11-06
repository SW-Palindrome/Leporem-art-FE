import 'package:daum_postcode_search/daum_postcode_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../theme/app_theme.dart';


class MessageItemOrderAddressScreen extends StatelessWidget {
  bool _isError = false;
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    DaumPostcodeSearch daumPostcodeSearch = DaumPostcodeSearch(
      onLoadError: (controller, uri, errorCode, message) => () {
        _isError = true;
        errorMessage = message;
      },
      onLoadHttpError: (controller, uri, statusCode, message) => () {
        _isError = true;
        errorMessage = message;
      },
    );

    return Scaffold(
      backgroundColor: ColorPalette.white,
      appBar: AppBar(
        backgroundColor: ColorPalette.white,
        elevation: 0,
        leading: IconButton(
            icon: SvgPicture.asset(
              'assets/icons/arrow_left.svg',
              width: 24,
            ),
            onPressed: () {
              Get.back();
            }),
        title: Text(
          '주소 검색',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: ColorPalette.black,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: daumPostcodeSearch,
          ),
          Visibility(
            visible: _isError,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(errorMessage ?? ""),
                ElevatedButton(
                  child: Text("Refresh"),
                  onPressed: () {
                    daumPostcodeSearch.controller?.reload();
                  },
                ),
              ],
            ),
          ),
        ],
      )
    );
  }

}