class ResetParam {
  const ResetParam({
    required this.newPassword,
    required this.confirmPassword,
  });

  final String newPassword;
  final String confirmPassword;

  Map<String, dynamic> toMap() => {
        'new_password': newPassword,
        'confirm_password': confirmPassword,
      };
}
