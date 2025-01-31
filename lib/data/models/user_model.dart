class UserModel {
  final int id;
  final String email;
  final String name;
  final String avatarUrl;
  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.avatarUrl,
  });

  @override
  String toString() {
    return 'UserModel{id: $id, email: $email, name: $name, avatarUrl: $avatarUrl}';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'avatar_url': avatarUrl,
    };
  }

  factory UserModel.fromJon(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      email: map['email'],
      name: map['name'],
      avatarUrl: map['avatar_url'],
    );
  }
}
