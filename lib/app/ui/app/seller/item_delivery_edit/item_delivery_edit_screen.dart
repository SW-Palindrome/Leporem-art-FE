import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../../../controller/seller/item_delivery_edit/item_delivery_edit_controller.dart';
import '../../../theme/app_theme.dart';

class SellerItemDeliveryEditScreen extends GetView<SellerItemDeliveryEditController> {
  const SellerItemDeliveryEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          '배송 정보 입력',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: ColorPalette.black,
          ),
        ),
        actions: [
          GestureDetector(
              onTap: () async {
                await controller.updateDeliveryInfo();
                Get.back();
                Get.snackbar('배송 정보 입력', '배송 정보가 입력되었습니다.');
              },
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Text(
                    '완료',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: ColorPalette.purple
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              _deliveryCompanyEdit(),
              SizedBox(height: 30),
              _invoiceNumberEdit(),
            ],
          ),
        ),
      ),
    );
  }

  _deliveryCompanyEdit() {
    return Column(
      children: [
        Row(
          children: [
            Text(
              '택배사명',
              style: TextStyle(
                color: ColorPalette.black,
                fontWeight: FontWeight.w500,
                fontFamily: "PretendardVariable",
                fontStyle: FontStyle.normal,
                fontSize: 14.0,
              ),
            ),
            Spacer(),
          ],
        ),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: ColorPalette.grey_4,
            ),
          ),
          child: Obx(() {
            return DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                value: controller.deliveryCompany.value,
                items: controller.deliveryCompanyList.map<
                    DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: TextStyle(
                      color: ColorPalette.black,
                      fontSize: 18,
                      height: 1,
                    )),
                  );
                }).toList(),
                onChanged: (String? value) {
                  controller.deliveryCompany.value = value!;
                },
                buttonStyleData: const ButtonStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                ),
                dropdownStyleData: const DropdownStyleData(
                  isOverButton: false,
                  maxHeight: 300,
                  offset: Offset(0, -5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  )
                ),
                isExpanded: true,
              ),
            );
          }),
        ),
    ]);
  }

  _invoiceNumberEdit() {
    return Column(
        children: [
          Row(
            children: [
              Text(
                '운송장 번호',
                style: TextStyle(
                  color: ColorPalette.black,
                  fontWeight: FontWeight.w500,
                  fontFamily: "PretendardVariable",
                  fontStyle: FontStyle.normal,
                  fontSize: 14.0,
                ),
              ),
              Spacer(),
            ],
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: controller.invoiceNumber,
            maxLength: 14,
            style: TextStyle(
              color: ColorPalette.black,
              fontSize: 18,
              height: 1,
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: ColorPalette.grey_4,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: ColorPalette.purple,
                ),
              ),
            ),
          ),
        ]);
  }
}