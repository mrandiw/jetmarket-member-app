class LoginParam {
  const LoginParam({
    required this.email,
    required this.password,
    this.fcmToken,
  });

  final String email;
  final String password;
  final String? fcmToken;

  Map<String, dynamic> toMap() => {
        'email': email,
        'password': password,
        'fcm_token': fcmToken,
      };
}
