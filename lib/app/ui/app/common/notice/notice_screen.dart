import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leporemart/app/ui/app/common/notice/widgets/notice_widget.dart';
import 'package:leporemart/app/ui/app/widgets/my_app_bar.dart';

class NoticeScreen extends StatelessWidget {
  const NoticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        appBarType: AppBarType.backAppBar,
        title: '알림',
        onTapLeadingIcon: () => Get.back,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 20, 16, 0),
          child: ListView.separated(
              itemBuilder: (context, index) {
                return noticeWidget('2023/06/06', '버전 1.2.0이 업데이트 되었습니다.',
                    '''2023년 6월 7일 수요일 00:00부터 09:00까지 점검을 완료하였습니다.
                    버전 1.2.0이 업데이트 되었습니다.

                    주문제작 기능
                    검색태그 자동생성
                    인스타그램 연동

                    위의 기능이 추가가 되었습니다.

                    플레이스토어, 앱스토어에서 업데이트 해주시기 바랍니다.

                    감사합니다.''');
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 16);
              },
              itemCount: 10),
        ),
      ),
    );
  }
}
