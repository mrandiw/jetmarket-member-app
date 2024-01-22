class CheckExisting {
  const CheckExisting(
      {required this.fromId,
      required this.toId,
      required this.fromRole,
      required this.toRole});

  final int fromId;
  final int toId;
  final String fromRole;
  final String toRole;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'from_id': fromId,
      'to_id': toId,
      'from_role': fromRole,
      'to_role': toRole
    };
    map.removeWhere((key, value) =>
        value == null || value == '' || value == 0.0 || value == 0);

    return map;
  }
}
