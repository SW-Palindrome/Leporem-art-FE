import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';
import 'widgets/exhibition_list_widget.dart';

class ExhibitionScreen extends StatelessWidget {
  const ExhibitionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '기획전',
              style: TextStyle(
                color: ColorPalette.black,
                fontFamily: FontPalette.pretenderd,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            SizedBox(height: 24),
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return exhibitionListWidget();
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 24);
              },
              itemCount: 10,
            ),
          ],
        ),
      ),
    );
  }
}
