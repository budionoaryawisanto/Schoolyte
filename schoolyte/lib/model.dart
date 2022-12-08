class Api {
  static String getAbsen = 'https://sekolahkunihh.my.id/api/absensiswa';
  static String createAbsen =
      'https://sekolahkunihh.my.id/api/absensiswa/create';
  static String editAbsen = 'https://sekolahkunihh.my.id/api/update/';
  static String image = 'https://sekolahkunihh.my.id/';
  static String getBook = 'https://sekolahkunihh.my.id/api/buku';
  static String createBook = 'https://sekolahkunihh.my.id/api/buku/create';
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
  final String siswa_id;
  final String kelas_id;
  final String status_absen;
  final String image;
  final String tgl_absen;
  final String wkt_absen;

  Absensi(
      {required this.id,
      required this.siswa_id,
      required this.kelas_id,
      required this.status_absen,
      required this.image,
      required this.tgl_absen,
      required this.wkt_absen});

  factory Absensi.formJson(Map<String, dynamic> json) {
    return new Absensi(
      id: json['id'],
      siswa_id: json['siswa_id'],
      kelas_id: json['kelas_id'],
      status_absen: json['status_absen'],
      image: json['image'],
      tgl_absen: json['tgl_absen'],
      wkt_absen: json['wkt_absen'],
    );
  }
}


class Book {
  final String buku_id;
  final String nama_buku;
  final String tahun_terbit;
  final String nama_penulis;
  final String rincian_buku;
  final String jumlah_buku;
  final String image;
  final String kategori_buku;

  Book({
    required this.buku_id,
    required this.nama_buku,
    required this.tahun_terbit,
    required this.nama_penulis,
    required this.rincian_buku,
    required this.jumlah_buku,
    required this.image,
    required this.kategori_buku,
  });

  factory Book.formJson(Map<String, dynamic> json) {
    return new Book(
      buku_id: json['buku_id'],
      nama_buku: json['nama_buku'],
      tahun_terbit: json['tahun_terbit'],
      nama_penulis: json['nama_penulis'],
      rincian_buku: json['rincian_buku'],
      jumlah_buku: json['jumlah_buku'],
      image: json['image'],
      kategori_buku: json['kategori_buku'],
    );
  }
}
