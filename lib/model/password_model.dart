class PasswordModel {
  final String? id;
  final String? title;
  final String? username;
  final String? email;
  final String? password;
  final String? website;
  final String? category;
  final String? createdAt;
  final String? updatedAt;

  PasswordModel({
    this.id,
    this.title,
    this.username,
    this.email,
    this.password,
    this.website,
    this.category,
    this.createdAt,
    this.updatedAt,
  });

  factory PasswordModel.fromJson(Map<String, dynamic> json) {
    return PasswordModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      website: json['website'] ?? '',
      category: json['category'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'username': username,
      'email': email,
      'password': password,
      'website': website,
      'category': category,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  PasswordModel copyWith({
    String? id,
    String? title,
    String? username,
    String? email,
    String? password,
    String? website,
    String? category,
    String? createdAt,
    String? updatedAt,
  }) {
    return PasswordModel(
      id: id ?? this.id,
      title: title ?? this.title,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      website: website ?? this.website,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
