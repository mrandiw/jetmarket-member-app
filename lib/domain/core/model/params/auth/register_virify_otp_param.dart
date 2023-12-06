class RegisterVerifyOtpParam {
  const RegisterVerifyOtpParam({
    required this.email,
    required this.otp,
  });

  final String email;
  final String otp;

  Map<String, dynamic> toMap() => {'email': email, 'otp': otp};
}
