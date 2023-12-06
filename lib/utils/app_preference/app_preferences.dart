import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/core/model/model_data/user_model.dart';

class AppPreference {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  final String _authTokenKey = 'auth_token';
  final String _userDataKey = 'user_data';
  final String _authRegisterKey = 'auth_register';
  final String _onboarding = 'intro';
  final String _isRegistered = 'registered';
  final String _isVerify = 'verify';
  final String _isPaid = 'paid';

  Future<void> saveAccessToken({int? status, String? token}) async {
    if (status == 200) {
      await _prefs?.setString(_authTokenKey, token!);
    }
  }

  Future<void> saveUserData({int? status, Map<String, dynamic>? data}) async {
    if (status == 200 && data != null) {
      String userDataJson = json.encode(data);
      await _prefs?.setString(_userDataKey, userDataJson);
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

  Future<void> removeUserData() async {
    await _prefs?.remove(_userDataKey);
  }

  Future<void> saveAccessRegister(String? token) async {
    await _prefs?.setString(_authRegisterKey, token ?? '');
  }

  Future<void> registerSuccess() async {
    await _prefs?.setBool(_isRegistered, true);
  }

  Future<void> verifySuccess() async {
    await _prefs?.setBool(_isVerify, true);
  }

  Future<void> paidSuccess() async {
    await _prefs?.setBool(_isPaid, true);
  }

  String? getAccessToken() {
    return _prefs?.getString(_authTokenKey);
  }

  String? getRegisterToken() {
    return _prefs?.getString(_authRegisterKey);
  }

  Future<void> skipOnboarding(bool onboarding) async {
    await _prefs?.setBool(_onboarding, onboarding);
  }

  bool? cekSkipOnboarding() {
    return _prefs?.getBool(_onboarding);
  }

  bool? cekRegistered() {
    return _prefs?.getBool(_isRegistered);
  }

  bool? cekVerify() {
    return _prefs?.getBool(_isVerify);
  }

  bool? cekPaid() {
    return _prefs?.getBool(_isPaid);
  }

  Future<void> clearAccessToken() async {
    await _prefs?.remove(_authTokenKey);
  }
}
