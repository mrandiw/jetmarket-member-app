import '../../../../../utils/path/environment.dart';

class Endpoint {
  // Auth
  static String login = 'auth/customer/login';
  static String otpVerify = 'auth/otp/verify';
  static String otpSend = 'auth/otp/send';
  static String otpForgotVerify = 'auth/otp-forgot/verify';
  static String otpForgotSend = 'auth/otp-forgot/send';
  static String logout = 'auth/logout';
  static String register = 'auth/customer/register';
  static String reset = 'auth/customer/change_password';
  static String paymentMethode = 'payment/method';
  static String paymentCustomerRegister = 'payment/customer_register';

  // Google Maps Api
  static String placeAutocomplete = 'place/autocomplete/json';
  static String placeDatail = 'place/details/json';
  static String placeNearbysearch = 'place/nearbysearch/json';
}
