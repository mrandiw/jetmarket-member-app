class Endpoint {
  // Auth
  static String login = 'auth/customer/login';
  static String otpVerify = 'auth/otp/verify';
  static String otpSend = 'auth/otp/send';
  static String otpForgotVerify = 'auth/otp-forgot/verify';
  static String otpForgotSend = 'auth/otp-forgot/send';
  static String logout = 'auth/customer/logout';
  static String register = 'auth/customer/register';
  static String reset = 'auth/customer/change_password';
  static String paymentMethode = 'payment/method';
  static String paymentCustomerRegister = 'payment/customer_register';
  static String claimReferral = 'referral/claim';
  static String deleteAccount = 'auth/customer/soft_delete';

  // Profile
  static String profile = 'profile/customer';
  static String fileImage = 'file/images';

  // Product
  static String categoryProduct = 'product_category/list';
  static String categoryProductBySeller = 'product_category/by_seller';
  static String product = 'product/customer';
  static String banner = 'banner/customer';
  static String productBySeller = 'product/customer_by_seller';
  static String productReview = 'product_review/customer';
  static String shop = 'shop';

  // Cart

  static String cart = 'cart/customer';
  static String cartQty = 'cart/customer/qty';
  static String cartNote = 'cart/customer/note';
  static String cartBulkDelete = 'cart/customer/bulk_delete';

  // Voucher
  static String voucher = 'voucher/customer';
  static String claimVoucher = '/voucher/customer/claim';

  // Notification
  static String notification = 'notification/user';
  static String notificationUnreadCount = 'notification/unread_count';

  // Google Maps Api
  static String placeAutocomplete = 'place/autocomplete/json';
  static String placeDatail = 'place/details/json';
  static String placeNearbysearch = 'place/nearbysearch/json';

  // Address
  static String address = 'address/customer';
}
