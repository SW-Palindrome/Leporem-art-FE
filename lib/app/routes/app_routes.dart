part of './app_pages.dart';

abstract class Routes {
  static const INITIAL = '/';
  static const ACCOUNT_TYPE = '/account/account-type';
  static const AGREEMENT = '/account/agreement';
  static const EMAIL = '/account/email';
  static const LOGIN = '/account/login';
  static const NICKNAME = '/account/nickname';
  static const MESSAGE = '/message';
  static const MESSAGE_ORDER = '/message/order';
  static const MESSAGE_SHARE = '/message/share';
  static const BUYER_APP = '/buyer';
  static const BUYER_SEARCH = '/buyer/search';
  static const BUYER_ITEM_DETAIL = '/buyer/item';
  static const BUYER_ITEM_CREATOR = '/buyer/creator';
  static const BUYER_FLOP = '/buyer/flop';
  static const BUYER_AUCTION = '/buyer/auction';
  static const BUYER_PROFILE = '/buyer/profile';
  static const BUYER_PROFILE_EDIT = '/buyer/profile/edit';
  static const BUYER_ORDER = '/buyer/profile/order';
  static const BUYER_RECENT_ITEM = '/buyer/profile/recent';
  static const BUYER_REVIEW_STAR = '/buyer/profile/order/review-star';
  static const BUYER_REVIEW_DETAIL = '/buyer/profile/order/review-detail';
  static const BUYER_REVIEW_COMPLETE = '/buyer/profile/order/review-complete';
  static const SELLER_APP = '/seller';
  static const SELLER_SEARCH = '/seller/search';
  static const SELLER_ITEM_DETAIL = '/seller/item';
  static const SELLER_ITEM_CREATE = '/seller/item/create';
  static const SELLER_ITEM_CREATE_DETAIL = '/seller/item/create/detail';
  static const SELLER_ITEM_EDIT = '/seller/item/edit';
  static const SELLER_PROFILE = '/seller/profile';
  static const SELLER_PROFILE_EDIT = '/seller/profile/edit';
  static const SELLER_ITEM_MANAGEMENT = '/seller/profile/item-management';
}