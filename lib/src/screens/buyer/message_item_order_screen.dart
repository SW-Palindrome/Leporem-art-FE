import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leporemart/src/controllers/buyer_message_controller.dart';
import 'package:leporemart/src/controllers/message_item_order_controller.dart';
import 'package:leporemart/src/theme/app_theme.dart';
import 'package:leporemart/src/widgets/my_app_bar.dart';
import 'package:leporemart/src/widgets/next_button.dart';

import '../../utils/currency_formatter.dart';

class MessageItemOrderScreen extends GetView<MessageItemOrderController> {
  const MessageItemOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        appBarType: AppBarType.backAppBar,
        title:
            '${Get.find<BuyerMessageController>().getChatRoom(Get.arguments['chatRoomUuid']).opponentNickname}님의 작품',
        onTapLeadingIcon: () {
          Get.back();
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                _searchField(),
                SizedBox(height: 16),
                _itemList(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _bottomButton(),
    );
  }

  _searchField() {
    return Container(
      margin: EdgeInsets.only(top: 8),
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: ColorPalette.grey_3,
        ),
        color: ColorPalette.grey_2,
      ),
      child: Center(
        child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: '작품명을 입력해주세요.',
              hintStyle: TextStyle(
                fontSize: 16,
                color: ColorPalette.grey_5,
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
            ),
            onSubmitted: (value) {
              controller.keyword = value;
              controller.search();
            }),
      ),
    );
  }

  _itemList() {
    return Obx(
      () => Column(
        children: [
          for (int i = 0; i < controller.displayItems.length; i++)
            _itemWidget(i)
        ],
      ),
    );
  }

  _itemWidget(int index) {
    return GestureDetector(
      onTap: () {
        controller.select(controller.displayItems[index].id);
      },
      child: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: controller.isSelected(controller.displayItems[index].id)
                ? ColorPalette.purple
                : Colors.transparent,
          ),
          color: ColorPalette.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                controller.displayItems[index].thumbnailImage,
                height: Get.width * 0.23,
                width: Get.width * 0.23,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        controller.displayItems[index].nickname,
                        style: TextStyle(
                          color: ColorPalette.grey_4,
                          fontWeight: FontWeight.bold,
                          fontFamily: "PretendardVariable",
                          fontStyle: FontStyle.normal,
                          fontSize: 10,
                        ),
                      ),
                      Text(
                        '잔여 ${controller.displayItems[index].currentAmount}점',
                        style: TextStyle(
                          color: ColorPalette.purple,
                          fontWeight: FontWeight.w600,
                          fontFamily: FontPalette.pretenderd,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    controller.displayItems[index].title,
                    style: TextStyle(
                      color: ColorPalette.black,
                      fontWeight: FontWeight.w500,
                      fontFamily: "PretendardVariable",
                      fontStyle: FontStyle.normal,
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '${CurrencyFormatter().numberToCurrency(controller.displayItems[index].price)}원',
                    style: TextStyle(
                      color: ColorPalette.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: "PretendardVariable",
                      fontStyle: FontStyle.normal,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _bottomButton() {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 30,
        top: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '주문을 원하는 작품을 선택해주세요.',
            style: TextStyle(
              color: ColorPalette.grey_5,
              fontFamily: FontPalette.pretenderd,
              fontSize: 12,
            ),
          ),
          SizedBox(height: 16),
          Obx(
            () => NextButton(
              text: '주문하기',
              value: controller.isSelect.value,
              onTap: () {
                controller.order();
              },
            ),
          ),
        ],
      ),
    );
  }
}
