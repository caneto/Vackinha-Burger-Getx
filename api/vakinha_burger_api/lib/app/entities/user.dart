import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class User {
  final int? id;
  final String name;
  final String email;
  final String password;
  
  const User({
    this.id,
    required this.name,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': name,
      'email': email,
      'password': password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: (map["name"] ?? '') as String,
      email: (map["email"] ?? '') as String,
      password: (map["password"] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, password: $password)';
  }
}
