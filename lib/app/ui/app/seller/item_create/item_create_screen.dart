// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
//
// import '../../../theme/app_theme.dart';
// import '../../widgets/my_app_bar.dart';
// import '../item_create_detail/item_create_detail_screen.dart';
//
// class ItemCreateScreen extends StatelessWidget {
//   const ItemCreateScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: MyAppBar(
//         isWhite: false,
//         appBarType: AppBarType.backAppBar,
//         title: '작품 등록',
//         onTapLeadingIcon: () {
//           Get.back();
//         },
//       ),
//       body: Container(
//         color: ColorPalette.grey_1,
//         padding: EdgeInsets.all(20),
//         child: Column(
//           children: [
//             _itemCreateIconButton(
//                 Image.asset(
//                   'assets/icons/instagram.png',
//                   width: 24,
//                 ),
//                 '인스타그램에서 가져오기',
//                 Scaffold(),
//                 false),
//             _itemCreateIconButton(
//                 SvgPicture.asset(
//                   'assets/icons/edit.svg',
//                   width: 24,
//                 ),
//                 '직접 작성하기',
//                 ItemCreateDetailScreen(),
//                 true),
//           ],
//         ),
//       ),
//     );
//   }
//
//   _itemCreateIconButton(
//       Widget icon, String text, Widget nextWidget, bool isSellersItems) {
//     return GestureDetector(
//       onTap: () {
//         Get.to(nextWidget);
//
//         if (isSellersItems) Get.put(ItemCreateDetailController());
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//           color: ColorPalette.white,
//         ),
//         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
//         margin: EdgeInsets.only(bottom: 20),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               children: [
//                 icon,
//                 SizedBox(width: 20),
//                 Text(
//                   text,
//                   style: TextStyle(
//                     color: ColorPalette.black,
//                     fontWeight: FontWeight.w600,
//                     fontFamily: "PretendardVariable",
//                     fontStyle: FontStyle.normal,
//                     fontSize: 16.0,
//                   ),
//                 ),
//               ],
//             ),
//             SvgPicture.asset(
//               'assets/icons/arrow_right.svg',
//               colorFilter:
//                   ColorFilter.mode(ColorPalette.grey_4, BlendMode.srcIn),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
