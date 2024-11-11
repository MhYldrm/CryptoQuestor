class User {
  String name;
  String email;
  String password;

  User({
    required this.name,
    required this.email,
    required this.password,
  });

  // User'ı modelden JSON'a dönüştürmek için
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }

  // JSON'dan User'a dönüşüm
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      password: json['password'],
    );
  }
}
