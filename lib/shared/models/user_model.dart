import 'dart:convert';

class UserModel {
  final String name;
  final String? photoURL;
  final String email;

  UserModel({
    required this.name,
    this.photoURL,
    required this.email,
  });

  UserModel copyWith({
    String? name,
    String? photoURL,
    String? email,
  }) {
    return UserModel(
      name: name ?? this.name,
      photoURL: photoURL ?? this.photoURL,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'photoURL': photoURL,
      'email': email,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
      photoURL: map['photoURL'],
      email: map['email'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'UserModel(name: $name, photoURL: $photoURL, email: $email)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.name == name &&
        other.photoURL == photoURL &&
        other.email == email;
  }

  @override
  int get hashCode => name.hashCode ^ photoURL.hashCode ^ email.hashCode;
}
