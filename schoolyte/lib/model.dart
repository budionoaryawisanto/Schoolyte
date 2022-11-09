class Users {
  final int id;
  final String name;
  final String username;
  final String email;
  final String image_url;

  Users(
      {required this.id,
      required this.name,
      required this.username,
      required this.email,
      required this.image_url});

  factory Users.formJson(Map<String, dynamic> json) {
    return new Users(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      image_url: json['image_url'],
    );
  }
}

class Test {
  final int id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String website;

  Test(
      {required this.id,
      required this.name,
      required this.username,
      required this.email,
      required this.phone,
      required this.website});

  factory Test.formJson(Map<String, dynamic> json) {
    return new Test(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      website: json['website'],
    );
  }
}
