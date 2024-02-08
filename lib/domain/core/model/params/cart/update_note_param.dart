class UpdateNoteParam {
  const UpdateNoteParam({
    required this.id,
    required this.note,
  });

  final int id;
  final String note;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {'id': id, 'note': note};
    return map;
  }
}
