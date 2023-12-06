class LocationParam {
  const LocationParam({required this.input, required this.key});

  final String input;
  final String key;

  Map<String, dynamic> toMap() => {
        'input': input,
        'key': key,
      };
}
