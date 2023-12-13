class ForgotVerifyOtpParam {
  const ForgotVerifyOtpParam({
    required this.email,
    required this.otp,
  });

  final String email;
  final String otp;

  Map<String, dynamic> toMap() =>
      {'email': email, 'otp': otp, 'role': 'customer'};
}
