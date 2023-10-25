import 'dart:convert';

class ProfileRequestModel {
  final String name;
  final String email;
  final String phone;
  final String bio;
  ProfileRequestModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.bio,
  });

  ProfileRequestModel copyWith({
    String? name,
    String? email,
    String? phone,
    String? bio,
  }) {
    return ProfileRequestModel(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      bio: bio ?? this.bio,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'phone': phone,
      'bio': bio,
    };
  }

  factory ProfileRequestModel.fromMap(Map<String, dynamic> map) {
    return ProfileRequestModel(
      name: map['name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      bio: map['bio'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileRequestModel.fromJson(String source) =>
      ProfileRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProfileRequestModel(name: $name, email: $email, phone: $phone, bio: $bio)';
  }

  @override
  bool operator ==(covariant ProfileRequestModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.email == email &&
        other.phone == phone &&
        other.bio == bio;
  }

  @override
  int get hashCode {
    return name.hashCode ^ email.hashCode ^ phone.hashCode ^ bio.hashCode;
  }
}
