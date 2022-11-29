class Api {
  static String get = 'https://sekolahkunihh.my.id/api/get';
  static String create = 'https://sekolahkunihh.my.id/api/create';
  static String edit = 'https://sekolahkunihh.my.id/api/update/';
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
  final String absen_status;
  final String tgl_absen;
  final String waktu_absen;
  final String img_absen;

  Absensi(
      {required this.id,
      required this.absen_status,
      required this.tgl_absen,
      required this.waktu_absen,
      required this.img_absen});

  factory Absensi.formJson(Map<String, dynamic> json) {
    return new Absensi(
      id: json['id'],
      absen_status: json['absen_status'],
      tgl_absen: json['tgl_absen'],
      waktu_absen: json['waktu_absen'],
      img_absen: json['img_absen'],
    );
  }
}
