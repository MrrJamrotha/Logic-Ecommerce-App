class CountryModel {
  final String name;
  final String dialCode;
  final String emoji;
  final String code;

  CountryModel({
    required this.name,
    required this.dialCode,
    required this.emoji,
    required this.code,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      name: json['name'],
      dialCode: json['dial_code'],
      emoji: json['emoji'],
      code: json['code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'dial_code': dialCode,
      'emoji': emoji,
      'code': code,
    };
  }
}
