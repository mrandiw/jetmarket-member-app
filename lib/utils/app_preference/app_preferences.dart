import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/core/model/model_data/address_model.dart';
import '../../domain/core/model/model_data/user_model.dart';
import '../../domain/core/model/model_data/user_profile.dart';

class AppPreference {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  final String _authTokenKey = 'auth_token';
  final String _userDataKey = 'user_data';
  final String _userProfile = 'user_profile';
  final String _onboarding = 'intro';
  final String _isRegistered = 'registered';
  final String _isVerified = 'is_verified';
  final String _isActivated = 'activated_at';
  final String _isPaid = 'paid';
  final String _isReferal = 'referal';
  final String _phoneNumber = 'phone';
  final String _email = 'email';
  final String _countDown = 'count_down';
  final String _countDownPaymentSaving = 'count_down_payment_saving';
  final String _countDownPaymentTopupWallet = 'count_down_payment_topup_wallet';
  final String _countDownPaylaterPayment = 'count_down_paylater_payment';
  final String _countDownOrder = 'count_down_order';
  final String _trxId = 'trx_id';
  final String _address = 'address';
  final String _registerComplite = 'register_complite';
  final String _currentPage = 'current-page';
  // final String _paymentRegisterSuccess = 'payment_register_success';

  Future<void> setCurrentPage(String? page) async {
    await _prefs?.setString(_currentPage, page ?? 'no-define');
  }

  Future<void> saveEmail(String? email) async {
    await _prefs?.setString(_email, email ?? '');
  }

  Future<void> savePaymentRegisterSuccess(String? email) async {
    await _prefs?.setString(_email, email ?? '');
  }

  String? getCurrentPage() {
    return _prefs?.getString(_currentPage);
  }

  String? getEmail() {
    return _prefs?.getString(_email);
  }

  Future<void> saveCountDown(int countDown) async {
    int startTime = DateTime.now().millisecondsSinceEpoch;
    await _prefs?.setInt(_countDown, startTime);
  }

  Future<void> saveCountDownOrder(int countDown, int id) async {
    int startTime = DateTime.now().millisecondsSinceEpoch;
    String? countDownData = _prefs?.getString(_countDownOrder);

    Map<String, dynamic> countDownMap = {};

    if (countDownData != null) {
      countDownMap = json.decode(countDownData);
    }
    countDownMap[id.toString()] = startTime;
    await _prefs?.setString(_countDownOrder, json.encode(countDownMap));
  }

  Future<void> saveCountDownSavingPayment(int countDown, String id) async {
    int startTime = DateTime.now().millisecondsSinceEpoch;
    String? countDownData = _prefs?.getString(_countDownPaymentSaving);

    Map<String, dynamic> countDownMap = {};

    if (countDownData != null) {
      countDownMap = json.decode(countDownData);
    }
    countDownMap[id] = startTime;
    await _prefs?.setString(_countDownPaymentSaving, json.encode(countDownMap));
  }

  Future<void> saveCountDownPaymentTopupWallet(int countDown, String id) async {
    int startTime = DateTime.now().millisecondsSinceEpoch;
    String? countDownData = _prefs?.getString(_countDownPaymentTopupWallet);

    Map<String, dynamic> countDownMap = {};

    if (countDownData != null) {
      countDownMap = json.decode(countDownData);
    }
    countDownMap[id] = startTime;
    await _prefs?.setString(
        _countDownPaymentTopupWallet, json.encode(countDownMap));
  }

  Future<void> saveCountDownPaymentPaylater(int countDown, String id) async {
    int startTime = DateTime.now().millisecondsSinceEpoch;
    String? countDownData = _prefs?.getString(_countDownPaylaterPayment);

    Map<String, dynamic> countDownMap = {};

    if (countDownData != null) {
      countDownMap = json.decode(countDownData);
    }
    countDownMap[id] = startTime;
    await _prefs?.setString(
        _countDownPaylaterPayment, json.encode(countDownMap));
  }

  int? getCountDownOrder(int id) {
    String? countDownData = _prefs?.getString(_countDownOrder);

    if (countDownData != null) {
      Map<String, dynamic> countDownMap = json.decode(countDownData);
      if (countDownMap.containsKey(id.toString())) {
        return countDownMap[id.toString()];
      }
    }

    return null;
  }

  int? getCountDownSavingPayment(String id) {
    String? countDownData = _prefs?.getString(_countDownPaymentSaving);

    if (countDownData != null) {
      Map<String, dynamic> countDownMap = json.decode(countDownData);
      if (countDownMap.containsKey(id)) {
        return countDownMap[id.toString()];
      }
    }

    return null;
  }

  int? getCountDownPaymentTopupWallet(String id) {
    String? countDownData = _prefs?.getString(_countDownPaymentTopupWallet);

    if (countDownData != null) {
      Map<String, dynamic> countDownMap = json.decode(countDownData);
      if (countDownMap.containsKey(id)) {
        return countDownMap[id.toString()];
      }
    }

    return null;
  }

  int? getCountDownPaymentPaylater(String id) {
    String? countDownData = _prefs?.getString(_countDownPaylaterPayment);

    if (countDownData != null) {
      Map<String, dynamic> countDownMap = json.decode(countDownData);
      if (countDownMap.containsKey(id)) {
        return countDownMap[id.toString()];
      }
    }

    return null;
  }

  Future<void> registerComplite() async {
    await _prefs?.setBool(_registerComplite, true);
  }

  int? getCountDown() {
    return _prefs?.getInt(_countDown);
  }

  Future<void> deleteCountDown() async {
    await _prefs?.remove(_countDown);
  }

  Future<void> savePhoneNumber(String phoneNumber) async {
    await _prefs?.setString(_phoneNumber, phoneNumber);
  }

  Future<void> saveAccessToken({int? status, String? token}) async {
    if (status == 200) {
      await _prefs?.setString(_authTokenKey, token!);
    }
  }

  Future<void> saveUserData({int? status, Map<String, dynamic>? data}) async {
    if (status == 200 && data != null) {
      String userDataJson = json.encode(data);
      await _prefs?.setString(_userDataKey, userDataJson);
      if (data['trx_id'] != null) {
        saveTrxId(data['trx_id']);
      }
    }
  }

  Future<void> saveUserProfile(
      {int? status, Map<String, dynamic>? data}) async {
    if (status == 200 && data != null) {
      String userDataJson = json.encode(data);
      await _prefs?.setString(_userProfile, userDataJson);
    }
  }

  UserModel? getUserData() {
    String? userDataJson = _prefs?.getString(_userDataKey);

    if (userDataJson != null) {
      Map<String, dynamic> userDataMap = json.decode(userDataJson);
      return UserModel.fromJson(userDataMap);
    } else {
      return null;
    }
  }

  UserProfile? getUserProfile() {
    String? userDataJson = _prefs?.getString(_userProfile);

    if (userDataJson != null) {
      Map<String, dynamic> userDataMap = json.decode(userDataJson);
      return UserProfile.fromJson(userDataMap);
    } else {
      return null;
    }
  }

  void updateUserData(UserModel newUserData) {
    String? existingUserDataJson = _prefs?.getString(_userDataKey);

    if (existingUserDataJson != null) {
      Map<String, dynamic> existingUserDataMap =
          json.decode(existingUserDataJson);
      existingUserDataMap.forEach((key, value) {
        if (newUserData.toJson().containsKey(key)) {
          existingUserDataMap[key] = newUserData.toJson()[key];
        }
      });
      String updatedUserDataJson = json.encode(existingUserDataMap);
      _prefs?.setString(_userDataKey, updatedUserDataJson);
    }
  }

  void updateUserProfile(UserProfile newUserData) {
    String? existingUserDataJson = _prefs?.getString(_userProfile);

    if (existingUserDataJson != null) {
      Map<String, dynamic> existingUserDataMap =
          json.decode(existingUserDataJson);
      existingUserDataMap.forEach((key, value) {
        if (newUserData.toJson().containsKey(key)) {
          existingUserDataMap[key] = newUserData.toJson()[key];
        }
      });
      String updatedUserDataJson = json.encode(existingUserDataMap);
      _prefs?.setString(_userProfile, updatedUserDataJson);
    }
  }

  Future<void> removeUserData() async {
    await _prefs?.remove(_userDataKey);
  }

  Future<void> referalSuccess() async {
    await _prefs?.setBool(_isReferal, true);
  }

  bool? cekReferal() {
    return _prefs?.getBool(_isReferal);
  }

  bool? registerCompleted() {
    return _prefs?.getBool(_registerComplite);
  }

  String? getPhoneNumber() {
    return _prefs?.getString(_phoneNumber);
  }

  Future<void> registerSuccess() async {
    await _prefs?.setBool(_isRegistered, true);
  }

  Future<void> verifySuccess() async {
    await _prefs?.setBool(_isVerified, true);
  }

  Future<void> activatedAt() async {
    await _prefs?.setBool(_isActivated, true);
  }

  bool? cekActivated() {
    return _prefs?.getBool(_isActivated);
  }

  Future<void> paidSuccess() async {
    await _prefs?.setBool(_isPaid, true);
  }

  String? getAccessToken() {
    return _prefs?.getString(_authTokenKey);
  }

  Future<void> skipOnboarding(bool onboarding) async {
    await _prefs?.setBool(_onboarding, true);
  }

  bool? cekSkipOnboarding() {
    return _prefs?.getBool(_onboarding);
  }

  bool? cekRegistered() {
    return _prefs?.getBool(_isRegistered);
  }

  bool? cekVerify() {
    return _prefs?.getBool(_isVerified);
  }

  bool? cekPaid() {
    return _prefs?.getBool(_isPaid);
  }

  Future<void> saveTrxId(int trxId) async {
    await _prefs?.setInt(_trxId, trxId);
  }

  int? getTrxId() {
    return _prefs?.getInt(_trxId);
  }

  Future<void> saveAddress(AddressModel address) async {
    String addressJson = json.encode(address);
    await _prefs?.setString(_address, addressJson);
  }

  AddressModel? getAddress() {
    String? addressJson = _prefs?.getString(_address);
    if (addressJson != null) {
      Map<String, dynamic> addressMap = json.decode(addressJson);
      return AddressModel.fromJson(addressMap);
    } else {
      return null;
    }
  }

  Future<void> clearAccessToken() async {
    await _prefs?.remove(_authTokenKey);
  }

  Future<void> cleanCurrentPage() async {
    await _prefs?.remove(_currentPage);
  }

  Future<void> removetrxId() async {
    await _prefs?.remove(_trxId);
  }

  Future<void> clearOnLogout() async {
    await _prefs?.remove(_authTokenKey);
    await _prefs?.remove(_userDataKey);
    await _prefs?.remove(_isPaid);
    await _prefs?.remove(_isReferal);
    await _prefs?.remove(_isRegistered);
    await _prefs?.remove(_isVerified);
    await _prefs?.remove(_phoneNumber);
    await _prefs?.remove(_trxId);
  }

  Future<void> clearOnSuccessPayment() async {
    await _prefs?.remove(_isPaid);
    await _prefs?.remove(_isReferal);
    await _prefs?.remove(_isRegistered);
    await _prefs?.remove(_isVerified);
    await _prefs?.remove(_phoneNumber);
    await _prefs?.remove(_trxId);
    await _prefs?.remove(_countDown);
  }
}
