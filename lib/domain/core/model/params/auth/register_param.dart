class RegisterParam {
  const RegisterParam({
    required this.nama,
    required this.gender,
    required this.email,
    required this.password,
    this.kodeReferall,
    required this.phone,
    required this.birthDate,
    this.fcmToken,
  });

  final String nama;
  final String gender;
  final String phone;
  final String birthDate;
  final String email;
  final String password;
  final String? kodeReferall;
  final String? fcmToken;

  Map<String, dynamic> toMap() => {
        'name': nama,
        'gender': gender,
        'phone': phone,
        'birth_date': birthDate,
        'email': email,
        'password': password,
        'referral': kodeReferall,
        'fcm_token': fcmToken,
      };
}
