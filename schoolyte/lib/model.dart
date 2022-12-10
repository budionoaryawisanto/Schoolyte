class Api {
  static String getSiswa = 'https://sekolahkunihh.my.id/api/siswa';
  static String createSiswa = 'https://sekolahkunihh.my.id/api/siswa/create';
  static String getAbsen = 'https://sekolahkunihh.my.id/api/absensiswa';
  static String createAbsen =
      'https://sekolahkunihh.my.id/api/absensiswa/create';
  static String editAbsen = 'https://sekolahkunihh.my.id/api/update/';
  static String image = 'https://sekolahkunihh.my.id/';
  static String getBook = 'https://sekolahkunihh.my.id/api/buku';
  static String createBook = 'https://sekolahkunihh.my.id/api/buku/create';
}

class Siswa {
  final int id;
  final String kelas_id;
  final String username;
  final String email_siswa;
  final String pass_siswa;
  final String nama_siswa;
  final String no_absen;
  final String alamat;
  final String tlpn_siswa;
  final String no_induk;
  final String jenis_kelamin;
  final String tempat_lahir;
  final String tgl_lahir;
  final String agama;
  final String saldo;
  final String semester;
  final String status;
  final String image;
  final Absensi absensiswas;

  Siswa(
      {required this.id,
      required this.kelas_id,
      required this.username,
      required this.email_siswa,
      required this.pass_siswa,
      required this.nama_siswa,
      required this.no_absen,
      required this.alamat,
      required this.tlpn_siswa,
      required this.no_induk,
      required this.jenis_kelamin,
      required this.tempat_lahir,
      required this.tgl_lahir,
      required this.agama,
      required this.saldo,
      required this.semester,
      required this.status,
      required this.image,
      required this.absensiswas});

  factory Siswa.formJson(Map<String, dynamic> json) {
    return new Siswa(
      id: json['id'],
      kelas_id: json['kelas_id'],
      username: json['username'],
      email_siswa: json['email_siswa'],
      pass_siswa: json['pass_siswa'],
      nama_siswa: json['nama_siswa'],
      no_absen: json['no_absen'],
      alamat: json['alamat'],
      tlpn_siswa: json['tlpn_siswa'],
      no_induk: json['no_induk'],
      jenis_kelamin: json['jenis_kelamin'],
      tempat_lahir: json['tempat_lahir'],
      tgl_lahir: json['tgl_lahir'],
      agama: json['agama'],
      saldo: json['saldo'],
      semester: json['semester'],
      status: json['status'],
      image: json['image'],
      absensiswas: Absensi.formJson(json['absensiswas']),
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



class Test {
  final int id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String website;

  Test({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.website,
  });

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


class Book {
  final int id;
  final String nama_buku;
  final String tahun_terbit;
  final String nama_penulis;
  final String rincian_buku;
  final String jumlah_buku;
  final String image;
  final String kategori_buku;

  Book({
    required this.id,
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
      id: json['id'],
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
