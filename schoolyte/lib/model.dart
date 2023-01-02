class Api {
  static String getSiswa = 'https://schoolyte.my.id/api/siswa';
  static String getGuru = 'https://schoolyte.my.id/api/guru';
  static String getPegawai = 'https://schoolyte.my.id/api/pegawai';
  static String getAdmin = 'https://schoolyte.my.id/api/admin';
  static String getAbsenSiswa = 'https://schoolyte.my.id/api/absensiswa';
  static String createAbsenSiswa =
      'https://schoolyte.my.id/api/absensiswa/create';
  static String editAbsen = 'https://schoolyte.my.id/api/absensiswa/update/';
  static String image = 'https://schoolyte.my.id/';
  static String getBook = 'https://schoolyte.my.id/api/buku';
  static String createBook = 'https://schoolyte.my.id/api/buku/create';
  static String getFasilitas = 'https://schoolyte.my.id/api/fasilitas';
  static String createFasilitas =
      'https://schoolyte.my.id/api/fasilitas/create';
  static String getBerita = 'https://schoolyte.my.id/api/berita';
  static String createBerita = 'https://schoolyte.my.id/api/berita/create';
  static String getStand = 'https://schoolyte.my.id/api/stand';
  static String createStand = 'https://schoolyte.my.id/api/stand/create';
  static String getMenu = 'https://schoolyte.my.id/api/menu';
  static String updateSaldoSiswa =
      'https://schoolyte.my.id/api/pembayaran-kantin/';
  static String updateSaldoGuru =
      'https://schoolyte.my.id/api/pembayaran-kantin-guru/';
  static String getPesanan = 'https://schoolyte.my.id/api/pesan-kantin';
  static String createPesanan =
      'https://schoolyte.my.id/api/pesan-kantin/create';
  static String deletePesanan = 'https://schoolyte.my.id/api/pesan-kantin/';
  static String updatePesanan =
      'https://schoolyte.my.id/api/pesan-kantin/status/';
  static String getRiwayat = 'https://schoolyte.my.id/api/selesai-kantin';
  static String createRiwayat =
      'https://schoolyte.my.id/api/selesai-kantin/create';
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

class Pegawai {
  final int id;
  final String email;
  final String pass;
  final String nama;
  final String alamat;
  final String tlpn;
  final String jenis_kelamin;
  final String tempat_lahir;
  final String nik;
  final String tgl_lahir;
  final String agama;
  final String saldo;
  final String status;
  final String image;

  Pegawai({
    required this.id,
    required this.email,
    required this.pass,
    required this.nama,
    required this.alamat,
    required this.tlpn,
    required this.jenis_kelamin,
    required this.tempat_lahir,
    required this.nik,
    required this.tgl_lahir,
    required this.agama,
    required this.saldo,
    required this.status,
    required this.image,
  });

  factory Pegawai.formJson(Map<String, dynamic> json) {
    return new Pegawai(
      id: json['id'],
      email: json['email'],
      pass: json['pass'],
      nama: json['nama'],
      alamat: json['alamat'],
      tlpn: json['tlpn'],
      jenis_kelamin: json['jenis_kelamin'],
      tempat_lahir: json['tempat_lahir'],
      nik: json['nik'],
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

class AbsensiSiswa {
  final int id;
  final String siswa_id;
  final String kelas_id;
  final String status_absen;
  final String image;
  final String tgl_absen;
  final String wkt_absen;

  AbsensiSiswa(
      {required this.id,
      required this.siswa_id,
      required this.kelas_id,
      required this.status_absen,
      required this.image,
      required this.tgl_absen,
      required this.wkt_absen});

  factory AbsensiSiswa.formJson(Map<String, dynamic> json) {
    return new AbsensiSiswa(
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

class Fasilitas {
  final int id;
  final String nama_fasilitas;
  final String jenis_fasilitas;
  final String image;

  Fasilitas({
    required this.id,
    required this.nama_fasilitas,
    required this.jenis_fasilitas,
    required this.image,
  });

  factory Fasilitas.formJson(Map<String, dynamic> json) {
    return new Fasilitas(
      id: json['id'],
      nama_fasilitas: json['nama_fasilitas'],
      jenis_fasilitas: json['jenis_fasilitas'],
      image: json['image'],
    );
  }
}

class Berita {
  final int id;
  final String siswa_id;
  final String judul;
  final String isi;
  final String tanggal;
  final String image;

  Berita(
      {required this.id,
      required this.siswa_id,
      required this.judul,
      required this.isi,
      required this.tanggal,
      required this.image});

  factory Berita.formJson(Map<String, dynamic> json) {
    return new Berita(
      id: json['id'],
      siswa_id: json['siswa_id'],
      judul: json['judul'],
      isi: json['isi'],
      tanggal: json['tanggal'],
      image: json['image'],
    );
  }
}

class Stand {
  final int id;
  final String nama_stand;
  final String jenis_stand;
  final String kode_stand;
  final String barcode_stand;
  final String image;

  Stand(
      {required this.id,
      required this.nama_stand,
      required this.jenis_stand,
      required this.kode_stand,
      required this.barcode_stand,
      required this.image});

  factory Stand.formJson(Map<String, dynamic> json) {
    return new Stand(
      id: json['id'],
      nama_stand: json['nama_stand'],
      jenis_stand: json['jenis_stand'],
      kode_stand: json['kode_stand'],
      barcode_stand: json['barcode_stand'],
      image: json['image'],
    );
  }
}

class Menu {
  final int id;
  final String stand_id;
  final String nama_menu;
  final String harga;
  final String image;

  Menu(
      {required this.id,
      required this.stand_id,
      required this.nama_menu,
      required this.harga,
      required this.image});

  factory Menu.formJson(Map<String, dynamic> json) {
    return new Menu(
      id: json['id'],
      stand_id: json['stand_id'],
      nama_menu: json['nama_menu'],
      harga: json['harga'],
      image: json['image'],
    );
  }
}

class Pesanan {
  final int id;
  final String user_id;
  final String stand_id;
  final String menu_id;
  final String no_pemesanan;
  final String tgl_pemesanan;
  final String nama_stand;
  final String nama_menu;
  final String kode_stand;
  final String jumlah;
  final String status;
  final String total;
  final String nama_pemesanan;

  Pesanan(
      {required this.id,
      required this.user_id,
      required this.stand_id,
      required this.menu_id,
      required this.no_pemesanan,
      required this.tgl_pemesanan,
      required this.nama_stand,
      required this.nama_menu,
      required this.kode_stand,
      required this.jumlah,
      required this.status,
      required this.total,
      required this.nama_pemesanan});

  factory Pesanan.formJson(Map<String, dynamic> json) {
    return new Pesanan(
      id: json['id'],
      user_id: json['user_id'],
      stand_id: json['stand_id'],
      menu_id: json['menu_id'],
      no_pemesanan: json['no_pemesanan'],
      tgl_pemesanan: json['tgl_pemesanan'],
      nama_stand: json['nama_stand'],
      nama_menu: json['nama_menu'],
      kode_stand: json['kode_stand'],
      jumlah: json['jumlah'],
      status: json['status'],
      total: json['total'],
      nama_pemesanan: json['nama_pemesanan'],
    );
  }
}

class RiwayatPesanan {
  final int id;
  final String user_id;
  final String stand_id;
  final String menu_id;
  final String no_pemesanan;
  final String tgl_pemesanan;
  final String nama_stand;
  final String nama_menu;
  final String kode_stand;
  final String jumlah;
  final String status;
  final String total;
  final String nama_pemesanan;

  RiwayatPesanan(
      {required this.id,
      required this.user_id,
      required this.stand_id,
      required this.menu_id,
      required this.no_pemesanan,
      required this.tgl_pemesanan,
      required this.nama_stand,
      required this.nama_menu,
      required this.kode_stand,
      required this.jumlah,
      required this.status,
      required this.total,
      required this.nama_pemesanan});

  factory RiwayatPesanan.formJson(Map<String, dynamic> json) {
    return new RiwayatPesanan(
      id: json['id'],
      user_id: json['user_id'],
      stand_id: json['stand_id'],
      menu_id: json['menu_id'],
      no_pemesanan: json['no_pemesanan'],
      tgl_pemesanan: json['tgl_pemesanan'],
      nama_stand: json['nama_stand'],
      nama_menu: json['nama_menu'],
      kode_stand: json['kode_stand'],
      jumlah: json['jumlah'],
      status: json['status'],
      total: json['total'],
      nama_pemesanan: json['nama_pemesanan'],
    );
  }
}
