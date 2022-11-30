class Api {
  static String get = 'https://sekolahkunihh.my.id/api';
  static String create = 'https://sekolahkunihh.my.id/api/create';
  static String edit = 'https://sekolahkunihh.my.id/api/update/';
  static String image = 'https://sekolahkunihh.my.id/';
}

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

class Absensi {
  final int id;
  final String statAbsen;
  final String image;
  final String tglAbsen;
  final String wktAbsen;

  Absensi(
      {required this.id,
      required this.statAbsen,
      required this.image,
      required this.tglAbsen,
      required this.wktAbsen});

  factory Absensi.formJson(Map<String, dynamic> json) {
    return new Absensi(
      id: json['id'],
      statAbsen: json['statAbsen'],
      image: json['image'],
      tglAbsen: json['tglAbsen'],
      wktAbsen: json['wktAbsen'],
    );
  }
}
