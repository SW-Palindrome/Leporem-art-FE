import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:leporemart/app/ui/app/buyer/delivery_info_webview/delivery_info_webview_screen.dart';
import 'package:leporemart/app/ui/app/buyer/order_info/order_info_screen.dart';
import 'package:leporemart/app/ui/app/common/message_item_order_info/message_item_order_info_screen.dart';

import '../bindings/account/account_type_binding.dart';
import '../bindings/account/agreement_binding.dart';
import '../bindings/account/email_binding.dart';
import '../bindings/account/login_binding.dart';
import '../bindings/account/nickname_binding.dart';
import '../bindings/buyer/buyer_app_binding.dart';
import '../bindings/buyer/buyer_item_detail_binding.dart';
import '../bindings/buyer/buyer_profile_edit_binding.dart';
import '../bindings/buyer/delivery_info_webview_binding.dart';
import '../bindings/buyer/item_creator_binding.dart';
import '../bindings/buyer/order_list_binding.dart';
import '../bindings/buyer/recent_item_binding.dart';
import '../bindings/buyer/review_binding.dart';
import '../bindings/common/message_item_order_binding.dart';
import '../bindings/common/message_item_order_info_binding.dart';
import '../bindings/common/message_item_share_binding.dart';
import '../bindings/seller/item_create_detail_binding.dart';
import '../bindings/seller/item_delivery_edit_binding.dart';
import '../bindings/seller/item_edit_binding.dart';
import '../bindings/seller/item_management_binding.dart';
import '../bindings/seller/seller_app_binding.dart';
import '../bindings/seller/seller_item_detail_binding.dart';
import '../bindings/seller/seller_profile_edit_binding.dart';
import '../ui/app/account/account_type/account_type_screen.dart';
import '../ui/app/account/agreement/agreement_screen.dart';
import '../ui/app/account/email/email_screen.dart';
import '../ui/app/account/login/login_screen.dart';
import '../ui/app/account/nickname/nickname_screen.dart';
import '../ui/app/buyer/buyer_app.dart';
import '../ui/app/buyer/item_creator/item_creator_screen.dart';
import '../ui/app/buyer/item_detail/item_detail_screen.dart';
import '../ui/app/buyer/order_list/order_list_screen.dart';
import '../ui/app/buyer/profile_edit/profile_edit_screen.dart';
import '../ui/app/buyer/recent_item/recent_item_screen.dart';
import '../ui/app/buyer/review_star/review_star_screen.dart';
import '../ui/app/buyer/search/search_screen.dart';
import '../ui/app/common/message_detail/message_detail_screen.dart';
import '../ui/app/common/message_item_order/message_item_order_screen.dart';
import '../ui/app/common/message_item_share/message_item_share_screen.dart';
import '../ui/app/seller/exhibition_create_exhibition/exhibition_create_exhibition_screen.dart';
import '../ui/app/seller/exhibition_create_exhibition_complete/exhibition_create_exhibition_complete_screen.dart';
import '../ui/app/seller/exhibition_create_item/exhibition_create_item_screen.dart';
import '../ui/app/seller/exhibition_create_item_complete/exhibition_create_item_complete_screen.dart';
import '../ui/app/seller/exhibition_create_item_example/exhibition_create_item_example_screen.dart';
import '../ui/app/seller/exhibition_create_item_template/exhibition_create_item_template_screen.dart';
import '../ui/app/seller/exhibition_create_seller/exhibition_create_seller_screen.dart';
import '../ui/app/seller/exhibition_create_seller_complete/exhibition_create_seller_complete_screen.dart';
import '../ui/app/seller/exhibition_create_seller_example/exhibition_create_seller_example_screen.dart';
import '../ui/app/seller/exhibition_create_seller_template/exhibition_create_seller_template_screen.dart';
import '../ui/app/seller/exhibition_create_start/exhibition_create_start_screen.dart';
import '../ui/app/seller/item_create/item_create_screen.dart';
import '../ui/app/seller/item_delivery_edit/item_delivery_edit_screen.dart';
import '../ui/app/seller/item_detail/item_detail_screen.dart';
import '../ui/app/seller/item_edit/item_edit_screen.dart';
import '../ui/app/seller/item_management/item_management_screen.dart';
import '../ui/app/seller/item_order_info/item_order_info_screen.dart';
import '../ui/app/seller/profile_edit/profile_edit_screen.dart';
import '../ui/app/seller/search/search_screen.dart';
import '../ui/app/seller/seller_app.dart';
part './app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.ACCOUNT_TYPE,
      page: () => AccountTypeScreen(),
      binding: AccountTypeBinding(),
    ),
    GetPage(
      name: Routes.AGREEMENT,
      page: () => AgreementScreen(),
      binding: AgreementBinding(),
    ),
    GetPage(
      name: Routes.NICKNAME,
      page: () => NicknameScreen(),
      binding: NicknameBinding(),
    ),
    GetPage(
      name: Routes.EMAIL,
      page: () => EmailScreen(),
      binding: EmailBinding(),
    ),
    GetPage(
      name: Routes.ACCOUNT_TYPE,
      page: () => AccountTypeScreen(),
      binding: AccountTypeBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.ACCOUNT_TYPE,
      page: () => AccountTypeScreen(),
      binding: AccountTypeBinding(),
    ),
    GetPage(
      name: Routes.MESSAGE,
      page: () => MessageDetailScreen(),
    ),
    GetPage(
      name: Routes.MESSAGE_ORDER,
      page: () => MessageItemOrderScreen(),
      binding: MessageItemOrderBinding(),
    ),
    GetPage(
      name: Routes.MESSAGE_SHARE,
      page: () => MessageItemShareScreen(),
      binding: MessageItemShareBinding(),
    ),
    GetPage(
      name: Routes.BUYER_APP,
      page: () => BuyerApp(),
      binding: BuyerAppBinding(),
    ),
    GetPage(
      name: Routes.BUYER_SEARCH,
      page: () => BuyerSearchScreen(),
    ),
    GetPage(
      name: Routes.BUYER_ITEM_CREATOR,
      page: () => ItemCreatorScreen(),
      binding: ItemCreatorBinding(),
    ),
    GetPage(
      name: Routes.BUYER_ITEM_DETAIL,
      page: () => BuyerItemDetailScreen(),
      binding: BuyerItemDetailBinding(),
    ),
    GetPage(
      name: Routes.BUYER_ORDER,
      page: () => OrderListScreen(),
      binding: OrderListBinding(),
    ),
    GetPage(
      name: Routes.BUYER_ORDER_INFO,
      page: () => MessageItemOrderInfoScreen(),
      binding: MessageItemOrderInfoBinding(),
    ),
    GetPage(
      name: Routes.BUYER_ORDER_INFO_EDIT,
      page: () => BuyerItemOrderInfoScreen(),
      binding: OrderListBinding(),
    ),
    GetPage(
      name: Routes.BUYER_PROFILE_EDIT,
      page: () => BuyerProfileEditScreen(),
      binding: BuyerProfileEditBinding(),
    ),
    GetPage(
      name: Routes.BUYER_RECENT_ITEM,
      page: () => RecentItemScreen(),
      binding: RecentItemBinding(),
    ),
    GetPage(
      name: Routes.BUYER_REVIEW_STAR,
      page: () => ReviewStarScreen(),
      binding: ReviewBinding(),
    ),
    GetPage(
      name: Routes.BUYER_DELIVERY_INFO_WEBVIEW,
      page: () => DeliveryInfoWebViewScreen(),
      binding: DeliveryInfoWebViewBinding(),
    ),
    GetPage(
      name: Routes.SELLER_APP,
      page: () => SellerApp(),
      binding: SellerAppBinding(),
    ),
    GetPage(
      name: Routes.SELLER_SEARCH,
      page: () => SellerSearchScreen(),
    ),
    GetPage(
      name: Routes.SELLER_ITEM_CREATE,
      page: () => ItemCreateScreen(),
      binding: ItemCreateDetailBinding(),
    ),
    GetPage(
      name: Routes.SELLER_ITEM_EDIT,
      page: () => ItemEditScreen(),
      binding: ItemEditBinding(),
    ),
    GetPage(
      name: Routes.SELLER_ITEM_DETAIL,
      page: () => SellerItemDetailScreen(),
      binding: SellerItemDetailBinding(),
    ),
    GetPage(
      name: Routes.SELLER_ITEM_MANAGEMENT,
      page: () => ItemManagementScreen(),
      binding: ItemManagementBinding(),
    ),
    GetPage(
      name: Routes.SELLER_PROFILE_EDIT,
      page: () => SellerProfileEditScreen(),
      binding: SellerProfileEditBinding(),
    ),
    GetPage(
      name: Routes.SELLER_ITEM_DELIVERY_EDIT,
      page: () => SellerItemDeliveryEditScreen(),
      binding: SellerItemDeliverEditBinding(),
    ),
    GetPage(
      name: Routes.SELLER_ITEM_ORDER_INFO,
      page: () => SellerItemOrderInfoScreen(),
      binding: ItemManagementBinding(),
    ),
    GetPage(
      name: Routes.SELLER_EXHIBITION_CREATE_START,
      page: () => ExhibitionCreateStartScreen(),
    ),
    GetPage(
      name: Routes.SELLER_EXHIBITION_CREATE_EXHIBITION,
      page: () => ExhibitionCreateExhibitionScreen(),
    ),
    GetPage(
      name: Routes.SELLER_EXHIBITION_CREATE_EXHIBITION_COMPLETE,
      page: () => ExhibitionCreateExhibitionCompleteScreen(),
    ),
    GetPage(
      name: Routes.SELLER_EXHIBITION_CREATE_SELLER,
      page: () => ExhibitionCreateSellerScreen(),
    ),
    GetPage(
      name: Routes.SELLER_EXHIBITION_CREATE_SELLER_EXAMPLE,
      page: () => ExhibitionCreateSellerExampleScreen(),
    ),
    GetPage(
      name: Routes.SELLER_EXHIBITION_CREATE_SELLER_TEMPLATE,
      page: () => ExhibitionCreateSellerTemplateScreen(),
    ),
    GetPage(
      name: Routes.SELLER_EXHIBITION_CREATE_SELLER_COMPLETE,
      page: () => ExhibitionCreateSellerCompleteScreen(),
    ),
    GetPage(
      name: Routes.SELLER_EXHIBITION_CREATE_ITEM,
      page: () => ExhibitionCreateItemScreen(),
    ),
    GetPage(
      name: Routes.SELLER_EXHIBITION_CREATE_START,
      page: () => ExhibitionCreateStartScreen(),
    ),
    GetPage(
      name: Routes.SELLER_EXHIBITION_CREATE_EXHIBITION,
      page: () => ExhibitionCreateExhibitionScreen(),
    ),
    GetPage(
      name: Routes.SELLER_EXHIBITION_CREATE_EXHIBITION_COMPLETE,
      page: () => ExhibitionCreateExhibitionCompleteScreen(),
    ),
    GetPage(
      name: Routes.SELLER_EXHIBITION_CREATE_SELLER,
      page: () => ExhibitionCreateSellerScreen(),
    ),
    GetPage(
      name: Routes.SELLER_EXHIBITION_CREATE_SELLER_EXAMPLE,
      page: () => ExhibitionCreateSellerExampleScreen(),
    ),
    GetPage(
      name: Routes.SELLER_EXHIBITION_CREATE_SELLER_TEMPLATE,
      page: () => ExhibitionCreateSellerTemplateScreen(),
    ),
    GetPage(
      name: Routes.SELLER_EXHIBITION_CREATE_SELLER_COMPLETE,
      page: () => ExhibitionCreateSellerCompleteScreen(),
    ),
    GetPage(
      name: Routes.SELLER_EXHIBITION_CREATE_ITEM,
      page: () => ExhibitionCreateItemScreen(),
    ),
    GetPage(
      name: Routes.SELLER_EXHIBITION_CREATE_ITEM_EXAMPLE,
      page: () => ExhibitionCreateItemExampleScreen(),
    ),
    GetPage(
      name: Routes.SELLER_EXHIBITION_CREATE_ITEM_TEMPLATE,
      page: () => ExhibitionCreateItemTemplateScreen(),
    ),
    GetPage(
      name: Routes.SELLER_EXHIBITION_CREATE_ITEM_COMPLETE,
      page: () => ExhibitionCreateItemCompleteScreen(),
    ),
    GetPage(
      name: Routes.SELLER_EXHIBITION_CREATE_START,
      page: () => ExhibitionCreateStartScreen(),
    ),
    GetPage(
      name: Routes.SELLER_EXHIBITION_CREATE_EXHIBITION,
      page: () => ExhibitionCreateExhibitionScreen(),
    ),
    GetPage(
      name: Routes.SELLER_EXHIBITION_CREATE_EXHIBITION_COMPLETE,
      page: () => ExhibitionCreateExhibitionCompleteScreen(),
    ),
    GetPage(
      name: Routes.SELLER_EXHIBITION_CREATE_SELLER,
      page: () => ExhibitionCreateSellerScreen(),
    ),
    GetPage(
      name: Routes.SELLER_EXHIBITION_CREATE_SELLER_EXAMPLE,
      page: () => ExhibitionCreateSellerExampleScreen(),
    ),
    GetPage(
      name: Routes.SELLER_EXHIBITION_CREATE_SELLER_TEMPLATE,
      page: () => ExhibitionCreateSellerTemplateScreen(),
    ),
    GetPage(
      name: Routes.SELLER_EXHIBITION_CREATE_SELLER_COMPLETE,
      page: () => ExhibitionCreateSellerCompleteScreen(),
    ),
    GetPage(
      name: Routes.SELLER_EXHIBITION_CREATE_ITEM,
      page: () => ExhibitionCreateItemScreen(),
    ),
    GetPage(
      name: Routes.SELLER_EXHIBITION_CREATE_ITEM_EXAMPLE,
      page: () => ExhibitionCreateItemExampleScreen(),
    ),
    GetPage(
      name: Routes.SELLER_EXHIBITION_CREATE_ITEM_TEMPLATE,
      page: () => ExhibitionCreateItemTemplateScreen(),
    ),
    GetPage(
      name: Routes.SELLER_EXHIBITION_CREATE_ITEM_COMPLETE,
      page: () => ExhibitionCreateItemCompleteScreen(),
    ),
    GetPage(
      name: Routes.SELLER_ITEM_DELIVERY_EDIT,
      page: () => SellerItemDeliveryEditScreen(),
      binding: SellerItemDeliverEditBinding(),
    ),
  ];
}
