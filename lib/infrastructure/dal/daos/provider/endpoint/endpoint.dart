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
  static String claimVoucher = 'voucher/customer/claim';

  // Delivery
  static String checkOngkir = 'delivery/customer/check_ongkir';
  static String deliverySetRefund = 'delivery/customer/set_refund';

  // Order Customer
  static String orderCustomer = 'order/customer';
  static String orderWaitingCustomer = 'order/waiting_payment/customer';
  static String payletterPayment = 'payment/paylater';
  static String orderWaitingProductCustomer =
      'order/waiting_payment/product/customer';
  static String orderRefundStatus = 'order/customer/refund_status';
  static String orderRefundTracking = 'order/customer/refund/tracking';
  static String orderTracking = 'order/tracking';

  // Notification
  static String notification = 'notification/user';
  static String notificationUnreadCount = 'notification/unread_count';

  // Google Maps Api
  static String placeAutocomplete = 'place/autocomplete/json';
  static String placeDatail = 'place/details/json';
  static String placeNearbysearch = 'place/nearbysearch/json';

  // Address
  static String address = 'address/customer';

  // Saving
  static String saving = 'saving';
  static String savingTotal = 'saving/total';
  static String savingHistory = 'saving/history';
  static String savingInstallment = 'saving/installment';
  static String savingDirect = 'saving/direct';
  static String savingPaymentMethode = 'saving/payment_method';
  static String savingWaitingPayment = 'saving/waiting_payment';

  // Loan
  static String loanEntry = 'loan/entry';
  static String loanPropose = 'loan/propose';
  static String loanBill = 'loan/bill';

  // Chat
  static String chat = 'chat';
  static String chatCheckExisting = 'chat/check_existing';
  static String chatUnreadChat = '/chat/unread_chat';

  // E-Wallet
  static String eWalletBalance = 'ewallet/balance';
  static String eWalletBalanceHistory = '/ewallet/balance/history';
  static String eWalletWithdrawPaymentMethod =
      'ewallet/withdraw/payment_method';
  static String eWalletWithdraw = 'ewallet/withdraw';
  static String eWalletWithdrawApproval = '/ewallet/withdraw/approval';
  static String ewalletTopup = '/ewallet/topup';
}
