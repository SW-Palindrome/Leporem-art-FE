import 'package:flutter/material.dart';

import 'widgets/exhibition_widget.dart';
import 'widgets/item_widget.dart';
import 'widgets/seller_widget.dart';

class ExhibitionDetailScreen extends StatelessWidget {
  const ExhibitionDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            exhibitionWidget(),
            sellerWidget(),
            itemWidget(),
          ],
        ),
      ),
    );
  }
}
