class UserModel {
  final String? id;
  final String? name;
  final String? email;
  final String? password;
  final String? createdAt;
  final String? profilePicture;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.password,
    this.createdAt,
    this.profilePicture,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      createdAt: json['createdAt'] ?? '',
      profilePicture: json['profilePicture'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'docId': id,
      'name': name,
      'email': email,
      'password': password,
      'createdAt': createdAt,
      'profilePicture': profilePicture,
    };
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? createdAt,
    String? profilePicture,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      createdAt: createdAt ?? this.createdAt,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }
}
