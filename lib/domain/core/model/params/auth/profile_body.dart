class ProfileBody {
  const ProfileBody({
    this.name,
    this.gender,
    this.birthDate,
    this.phone,
    this.email,
    this.image,
  });

  final String? name;
  final String? gender;
  final String? birthDate;
  final String? phone;
  final String? email;
  final String? image;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'name': name,
      'gender': gender,
      'birth_date': birthDate,
      'phone': phone,
      'email': email,
      'image': image,
    };
    map.removeWhere((key, value) => value == null || value == '');

    return map;
  }
}
