class Users {
  final int id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String website;

  Users(
      {required this.id,
      required this.name,
      required this.username,
      required this.email,
      required this.phone,
      required this.website});

  factory Users.formJson(Map<String, dynamic> json) {
    return new Users(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      website: json['website'],
    );
  }
}
