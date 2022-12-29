class Api {
  static String getSiswa = 'https://schoolyte.my.id/api/siswa';
  static String getGuru = 'https://schoolyte.my.id/api/guru';
  static String getAdmin = 'https://schoolyte.my.id/api/admin';
  static String createSiswa = 'https://schoolyte.my.id/api/siswa/create';
  static String getAbsen = 'https://schoolyte.my.id/api/absensiswa';
  static String createAbsen = 'https://schoolyte.my.id/api/absensiswa';
  static String editAbsen = 'https://schoolyte.my.id/api/absensiswa/update/';
  static String image = 'https://schoolyte.my.id/';
  static String getBook = 'https://schoolyte.my.id/api/buku';
  static String createBook = 'https://schoolyte.my.id/api/buku/create';
}

class Siswa {
  final int id;
  final String kelas_id;
  final String email;
  final String pass;
  final String nama;
  final String no_absen;
  final String alamat;
  final String tlpn;
  final String nis;
  final String jenis_kelamin;
  final String tempat_lahir;
  final String tgl_lahir;
  final String agama;
  final String saldo;
  final String semester;
  final String status;
  final String image;

  Siswa({
    required this.id,
    required this.kelas_id,
    required this.email,
    required this.pass,
    required this.nama,
    required this.no_absen,
    required this.alamat,
    required this.tlpn,
    required this.nis,
    required this.jenis_kelamin,
    required this.tempat_lahir,
    required this.tgl_lahir,
    required this.agama,
    required this.saldo,
    required this.semester,
    required this.status,
    required this.image,
  });

  factory Siswa.formJson(Map<String, dynamic> json) {
    return new Siswa(
      id: json['id'],
      kelas_id: json['kelas_id'],
      email: json['email'],
      pass: json['pass'],
      nama: json['nama'],
      no_absen: json['no_absen'],
      alamat: json['alamat'],
      tlpn: json['tlpn'],
      nis: json['nis'],
      jenis_kelamin: json['jenis_kelamin'],
      tempat_lahir: json['tempat_lahir'],
      tgl_lahir: json['tgl_lahir'],
      agama: json['agama'],
      saldo: json['saldo'],
      semester: json['semester'],
      status: json['status'],
      image: json['image'],
    );
  }
}

class Guru {
  final int id;
  final String email;
  final String pass;
  final String nama;
  final String alamat;
  final String tlpn;
  final String nip;
  final String jenis_kelamin;
  final String tempat_lahir;
  final String tgl_lahir;
  final String agama;
  final String saldo;
  final String status;
  final String image;

  Guru(
      {required this.id,
      required this.email,
      required this.pass,
      required this.nama,
      required this.alamat,
      required this.tlpn,
      required this.nip,
      required this.jenis_kelamin,
      required this.tempat_lahir,
      required this.tgl_lahir,
      required this.agama,
      required this.saldo,
      required this.status,
      required this.image});

  factory Guru.formJson(Map<String, dynamic> json) {
    return new Guru(
      id: json['id'],
      email: json['email'],
      pass: json['pass'],
      nama: json['nama'],
      alamat: json['alamat'],
      tlpn: json['tlpn'],
      nip: json['nip'],
      jenis_kelamin: json['jenis_kelamin'],
      tempat_lahir: json['tempat_lahir'],
      tgl_lahir: json['tgl_lahir'],
      agama: json['agama'],
      saldo: json['saldo'],
      status: json['status'],
      image: json['image'],
    );
  }
}

class Admin {
  final int id;
  final String email;
  final String pass;
  final String nama;
  final String alamat;
  final String tlpn;
  final String nik;
  final String jenis_kelamin;
  final String tempat_lahir;
  final String tgl_lahir;
  final String agama;
  final String status;
  final String image;

  Admin(
      {required this.id,
      required this.email,
      required this.pass,
      required this.nama,
      required this.alamat,
      required this.tlpn,
      required this.nik,
      required this.jenis_kelamin,
      required this.tempat_lahir,
      required this.tgl_lahir,
      required this.agama,
      required this.status,
      required this.image});

  factory Admin.formJson(Map<String, dynamic> json) {
    return new Admin(
      id: json['id'],
      email: json['email'],
      pass: json['pass'],
      nama: json['nama'],
      alamat: json['alamat'],
      tlpn: json['tlpn'],
      nik: json['nik'],
      jenis_kelamin: json['jenis_kelamin'],
      tempat_lahir: json['tempat_lahir'],
      tgl_lahir: json['tgl_lahir'],
      agama: json['agama'],
      status: json['status'],
      image: json['image'],
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
  final Address address;

  Test({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.website,
    required this.address,
  });

  factory Test.formJson(Map<String, dynamic> json) {
    return new Test(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      website: json['website'],
      address: Address.formJson(json['address']),
    );
  }
}

class Address {
  final String street;
  final String suite;
  final String city;
  final String zipcode;

  Address({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
  });

  factory Address.formJson(Map<String, dynamic> json) {
    return new Address(
      street: json['street'],
      suite: json['suite'],
      city: json['city'],
      zipcode: json['zipcode'],
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
