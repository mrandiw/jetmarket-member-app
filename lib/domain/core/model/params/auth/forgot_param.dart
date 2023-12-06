class ForgotParam {
  const ForgotParam({required this.email});

  final String email;

  Map<String, dynamic> toMap() => {'email': email};
}
