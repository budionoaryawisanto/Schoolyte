import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:schoolyte/fasilitasAdmin.dart';
import 'package:schoolyte/jadwalAdmin.dart';
import 'package:schoolyte/jadwalGuru.dart';
import 'package:schoolyte/laporanKeuangan.dart';
import 'package:schoolyte/raporAdmin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'absensiPegawai.dart';
import 'ekstrakurikuler.dart';
import 'koperasi.dart';
import 'model.dart';
import 'package:http/http.dart' as http;
import 'package:schoolyte/absensi.dart';
import 'package:schoolyte/berita.dart';
import 'package:schoolyte/fasilitas.dart';
import 'package:schoolyte/jadwal.dart';
import 'package:schoolyte/nilaiBelajar.dart';
import 'package:schoolyte/perpustakaan.dart';
import 'package:schoolyte/rapor.dart';
import 'package:schoolyte/kantin.dart';
import 'osis.dart';
import 'perpustakaanPegawai.dart';
import 'profil.dart';
import 'administrasi.dart';
import 'mutasi.dart';
import 'postingBerita.dart';
import 'beritaAdmin.dart';
import 'absensiAdmin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Siswa> _siswa = [];
  List<Guru> _guru = [];
  List<Admin> _admin = [];
  late final profil;
  List<Test> _list = [];
  var loadingUser = false;
  var loadingBerita = false;
  var status;
  var statusUser;

  Future fetchDataSiswa() async {
    final prefs = await SharedPreferences.getInstance();
    var id = prefs.getString('id');
    status = prefs.getString('status');
    statusUser = prefs.getString('status user');
    setState(() {
      loadingUser = true;
    });
    _siswa.clear();
    final response = await http.get(Uri.parse(Api.getSiswa));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        for (Map<String, dynamic> i in data) {
          _siswa.add(Siswa.formJson(i));
        }
      });
      await getProfil();
    }
  }

  Future fetchDataGuru() async {
    setState(() {
      loadingUser = true;
    });
    _guru.clear();
    final response = await http.get(Uri.parse(Api.getGuru));
    print(response.statusCode);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        for (Map<String, dynamic> i in data) {
          _guru.add(Guru.formJson(i));
        }
      });
      await getProfil();
    }
  }

  Future fetchDataAdmin() async {
    setState(() {
      loadingUser = true;
    });
    _admin.clear();
    final response = await http.get(Uri.parse(Api.getAdmin));
    print(response.body);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        for (Map<String, dynamic> i in data) {
          _admin.add(Admin.formJson(i));
          loadingUser = false;
        }
      });
      await getProfil();
    }
  }

  getProfil() async {
    final prefs = await SharedPreferences.getInstance();
    var id = prefs.getString('id');
    var status = prefs.getString('status');
    if (status!.toLowerCase() == 'siswa') {
      _siswa.forEach((siswa) {
        if (siswa.id.toString() == id) {
          setState(() {
            profil = siswa;
            loadingUser = false;
          });
        }
      });
    } else if (status.toLowerCase() == 'guru') {
      _guru.forEach((guru) {
        if (guru.id.toString() == id) {
          setState(() {
            profil = guru;
            loadingUser = false;
          });
        }
      });
    } else if (status.toLowerCase() == 'admin') {
      _admin.forEach((admin) {
        if (admin.id.toString() == id) {
          setState(() {
            profil = admin;
            loadingUser = false;
          });
        }
      });
    }
  }

  Future fetchDataBerita() async {
    setState(() {
      loadingBerita = true;
    });
    _siswa.clear();
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        for (Map<String, dynamic> i in data) {
          _list.add(Test.formJson(i));
        }
      });
      setState(() {
        loadingBerita = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDataSiswa();
    fetchDataGuru();
    fetchDataAdmin();
    fetchDataBerita();
  }

  _logOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('slogin', false);
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  }

  bool akademikClick = true;
  bool peminjamanClick = true;
  bool pembelianClick = true;
  bool keuanganClick = true;
  bool kegiatanClick = true;
  bool profilClick = true;

  closeDrawer() {
    akademikClick = true;
    peminjamanClick = true;
    pembelianClick = true;
    keuanganClick = true;
    kegiatanClick = true;
    profilClick = true;
  }

  convertToIdr(dynamic number, int decimalDigit) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(number);
  }

  navigasiJadwal() {
    if (status.toLowerCase() == 'siswa' ||
        profil.status.toLowerCase() == 'wali murid') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => JadwalPage()));
    } else if (profil.status.toLowerCase() == 'admin' ||
        profil.status.toLowerCase() == 'tata usaha' ||
        profil.status.toLowerCase() == 'dinas pendidikan') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => JadwalAdminPage()));
    } else if (status.toLowerCase() == 'guru') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => JadwalGuruPage()));
    } else {
      return;
    }
  }

  navigasiAbsensi() {
    if (status.toLowerCase() == 'siswa' ||
        profil.status.toLowerCase() == 'wali murid') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AbsensiPage()));
    } else if (status.toLowerCase() == 'guru' ||
        status.toLowerCase() == 'pegawai') {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => AbsensiPegawaiPage()));
    } else {
      return;
    }
  }

  navigasiRapor() {
    if (status.toLowerCase() == 'siswa' ||
        profil.status.toLowerCase() == 'wali murid') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => RaporPage()));
    } else if (status.toLowerCase() == 'guru') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => RaporAdmin()));
    } else {
      return;
    }
  }

  navigasiPerpustakaan() {
    if (statusUser.toLowerCase() == 'admin' ||
        statusUser.toLowerCase() == 'pegawai perpus') {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => PerpustakaanPegawaiPage()));
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => PerpustakaanPage()));
    }
  }

  navigasiFasilitas() {
    if (status.toLowerCase() == 'admin' ||
        statusUser.toLowerCase() == 'pegawai tu') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => FasilitasAdmin()));
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => FasilitasPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Color.fromRGBO(255, 255, 255, 1),
        systemNavigationBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    return ScreenUtilInit(
      designSize: const Size(490, 980),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SafeArea(
            child: Scaffold(
              backgroundColor: Color.fromRGBO(243, 243, 243, 1),
              appBar: AppBar(
                elevation: 0,
                iconTheme:
                    IconThemeData(color: Color.fromARGB(255, 66, 65, 65)),
                backgroundColor: Colors.white,
                actions: <Widget>[
                  Container(
                    margin: EdgeInsetsDirectional.only(end: 10),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AbsensiAdminPage()));
                      },
                      child: Image.asset(
                        'assets/images/lonceng.png',
                      ),
                    ),
                  ),
                ],
              ),
              drawer: Drawer(
                backgroundColor: Colors.white,
                width: 257.w,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    DrawerHeader(
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Image(
                        image: AssetImage('assets/images/logolanding.png'),
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.home,
                        color: Color.fromRGBO(255, 199, 0, 1),
                      ),
                      title: Text(
                        'Beranda',
                        style: TextStyle(
                          fontFamily: 'Gilroy-ExtraBold',
                          fontSize: 16.w,
                          color: Color.fromRGBO(76, 81, 97, 1),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
                      },
                    ),
                    ListTile(
                      tileColor: (akademikClick == false)
                          ? Color.fromRGBO(255, 199, 0, 1)
                          : Colors.white,
                      leading: Icon(
                        Icons.school_rounded,
                        color: (akademikClick == false)
                            ? Colors.white
                            : Color.fromRGBO(255, 199, 0, 1),
                      ),
                      title: Text(
                        'Akademik',
                        style: TextStyle(
                          fontFamily: (akademikClick == false)
                              ? 'Gilroy-ExtraBold'
                              : 'Gilroy-Light',
                          fontSize: 16.w,
                          color: (akademikClick == false)
                              ? Colors.white
                              : Color.fromRGBO(76, 81, 97, 1),
                        ),
                      ),
                      onTap: () {
                        closeDrawer();
                        setState(() {
                          closeDrawer();
                          akademikClick = !akademikClick;
                        });
                      },
                    ),
                    Visibility(
                      visible: (akademikClick == false) ? true : false,
                      child: ListTile(
                        tileColor: Color.fromRGBO(237, 237, 237, 1),
                        title: Text(
                          'Jadwal Kelas',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Gilroy-Light',
                              fontSize: 14.w,
                              color: Color.fromRGBO(76, 81, 91, 1)),
                        ),
                        onTap: () {
                          navigasiJadwal();
                        },
                      ),
                    ),
                    Visibility(
                      visible: (akademikClick == false) ? true : false,
                      maintainAnimation: false,
                      maintainState: false,
                      child: ListTile(
                        tileColor: Color.fromRGBO(237, 237, 237, 1),
                        title: Text(
                          'Rapor',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Gilroy-Light',
                              fontSize: 14.w,
                              color: Color.fromRGBO(76, 81, 91, 1)),
                        ),
                        onTap: () {
                          navigasiRapor();
                        },
                      ),
                    ),
                    Visibility(
                      visible: (akademikClick == false) ? true : false,
                      maintainAnimation: false,
                      maintainState: false,
                      child: ListTile(
                        tileColor: Color.fromRGBO(237, 237, 237, 1),
                        title: Text(
                          'Absensi',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Gilroy-Light',
                              fontSize: 14.w,
                              color: Color.fromRGBO(76, 81, 91, 1)),
                        ),
                        onTap: () {
                          navigasiAbsensi();
                        },
                      ),
                    ),
                    Visibility(
                      visible: (akademikClick == false) ? true : false,
                      maintainAnimation: false,
                      maintainState: false,
                      child: ListTile(
                        tileColor: Color.fromRGBO(237, 237, 237, 1),
                        title: Text(
                          'Nilai Belajar',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Gilroy-Light',
                              fontSize: 14.w,
                              color: Color.fromRGBO(76, 81, 91, 1)),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NilaiBelajarPage()));
                        },
                      ),
                    ),
                    ListTile(
                      tileColor: (peminjamanClick == false)
                          ? Color.fromRGBO(255, 199, 0, 1)
                          : Colors.white,
                      leading: Icon(
                        Icons.book,
                        color: (peminjamanClick == false)
                            ? Colors.white
                            : Color.fromRGBO(255, 199, 0, 1),
                      ),
                      title: Text(
                        'Peminjaman',
                        style: TextStyle(
                          fontFamily: (peminjamanClick == false)
                              ? 'Gilroy-ExtraBold'
                              : 'Gilroy-Light',
                          fontSize: 16.w,
                          color: (peminjamanClick == false)
                              ? Colors.white
                              : Color.fromRGBO(76, 81, 97, 1),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          closeDrawer();
                          peminjamanClick = !peminjamanClick;
                        });
                      },
                    ),
                    Visibility(
                      visible: (peminjamanClick == false) ? true : false,
                      maintainAnimation: false,
                      maintainState: false,
                      child: ListTile(
                        tileColor: Color.fromRGBO(237, 237, 237, 1),
                        title: Text(
                          'Perpustakaan',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Gilroy-Light',
                              fontSize: 14.w,
                              color: Color.fromRGBO(76, 81, 91, 1)),
                        ),
                        onTap: () {
                          navigasiPerpustakaan();
                        },
                      ),
                    ),
                    Visibility(
                      visible: (peminjamanClick == false) ? true : false,
                      maintainAnimation: false,
                      maintainState: false,
                      child: ListTile(
                        tileColor: Color.fromRGBO(237, 237, 237, 1),
                        title: Text(
                          'Fasilitas',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Gilroy-Light',
                              fontSize: 14.w,
                              color: Color.fromRGBO(76, 81, 91, 1)),
                        ),
                        onTap: () {
                          navigasiFasilitas();
                        },
                      ),
                    ),
                    ListTile(
                      tileColor: (pembelianClick == false)
                          ? Color.fromRGBO(255, 199, 0, 1)
                          : Colors.white,
                      leading: Icon(
                        Icons.payment_rounded,
                        color: (pembelianClick == false)
                            ? Colors.white
                            : Color.fromRGBO(255, 199, 0, 1),
                      ),
                      title: Text(
                        'Pembelian',
                        style: TextStyle(
                          fontFamily: (pembelianClick == false)
                              ? 'Gilroy-ExtraBold'
                              : 'Gilroy-Light',
                          fontSize: 16.w,
                          color: (pembelianClick == false)
                              ? Colors.white
                              : Color.fromRGBO(76, 81, 97, 1),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          closeDrawer();
                          pembelianClick = !pembelianClick;
                        });
                      },
                    ),
                    Visibility(
                      visible: (pembelianClick == false) ? true : false,
                      maintainAnimation: false,
                      maintainState: false,
                      child: ListTile(
                        tileColor: Color.fromRGBO(237, 237, 237, 1),
                        title: Text(
                          'Koperasi',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Gilroy-Light',
                              fontSize: 14.w,
                              color: Color.fromRGBO(76, 81, 91, 1)),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => KoperasiPage()));
                        },
                      ),
                    ),
                    Visibility(
                      visible: (pembelianClick == false) ? true : false,
                      maintainAnimation: false,
                      maintainState: false,
                      child: ListTile(
                        tileColor: Color.fromRGBO(237, 237, 237, 1),
                        title: Text(
                          'Kantin',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Gilroy-Light',
                              fontSize: 14.w,
                              color: Color.fromRGBO(76, 81, 91, 1)),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => KantinPage()));
                        },
                      ),
                    ),
                    ListTile(
                      tileColor: Colors.white,
                      leading: Icon(
                        Icons.newspaper_rounded,
                        color: Color.fromRGBO(255, 199, 0, 1),
                      ),
                      title: Text(
                        'Berita',
                        style: TextStyle(
                          fontFamily: 'Gilroy-Light',
                          fontSize: 16.w,
                          color: Color.fromRGBO(76, 81, 97, 1),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BeritaPage()));
                        });
                      },
                    ),
                    ListTile(
                      tileColor: Colors.white,
                      leading: Icon(
                        Icons.point_of_sale,
                        color: Color.fromRGBO(255, 199, 0, 1),
                      ),
                      title: Text(
                        'Administrasi',
                        style: TextStyle(
                          fontFamily: 'Gilroy-Light',
                          fontSize: 16.w,
                          color: Color.fromRGBO(76, 81, 97, 1),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdministrasiPage()));
                      },
                    ),
                    ListTile(
                      tileColor: (kegiatanClick == false)
                          ? Color.fromRGBO(255, 199, 0, 1)
                          : Colors.white,
                      leading: Icon(
                        Icons.people_rounded,
                        color: (kegiatanClick == false)
                            ? Colors.white
                            : Color.fromRGBO(255, 199, 0, 1),
                      ),
                      title: Text(
                        'Kegiatan Sekolah',
                        style: TextStyle(
                          fontFamily: (kegiatanClick == false)
                              ? 'Gilroy-ExtraBold'
                              : 'Gilroy-Light',
                          fontSize: 16.w,
                          color: (kegiatanClick == false)
                              ? Colors.white
                              : Color.fromRGBO(76, 81, 97, 1),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          closeDrawer();
                          kegiatanClick = !kegiatanClick;
                        });
                      },
                    ),
                    Visibility(
                      visible: (kegiatanClick == false) ? true : false,
                      maintainAnimation: false,
                      maintainState: false,
                      child: ListTile(
                        tileColor: Color.fromRGBO(237, 237, 237, 1),
                        title: Text(
                          'OSIS',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Gilroy-Light',
                              fontSize: 14.w,
                              color: Color.fromRGBO(76, 81, 91, 1)),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OsisPage()));
                        },
                      ),
                    ),
                    Visibility(
                      visible: (kegiatanClick == false) ? true : false,
                      maintainAnimation: false,
                      maintainState: false,
                      child: ListTile(
                        tileColor: Color.fromRGBO(237, 237, 237, 1),
                        title: Text(
                          'Ekstrakurikuler',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Gilroy-Light',
                              fontSize: 14.w,
                              color: Color.fromRGBO(76, 81, 91, 1)),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EkstrakurikulerPage()));
                        },
                      ),
                    ),
                    ListTile(
                      tileColor: Colors.white,
                      leading: Icon(
                        Icons.person_rounded,
                        color: Color.fromRGBO(255, 199, 0, 1),
                      ),
                      title: Text(
                        'Profil',
                        style: TextStyle(
                          fontFamily: 'Gilroy-Light',
                          fontSize: 16.w,
                          color: Color.fromRGBO(76, 81, 97, 1),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilPage()));
                      },
                    ),
                    Container(
                      child: Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: Column(
                          children: <Widget>[
                            Divider(),
                            ListTile(
                              leading: Icon(
                                Icons.logout_rounded,
                              ),
                              title: Text(
                                'Log Out',
                                style: TextStyle(
                                    fontFamily: 'Gilroy-Light',
                                    fontSize: 14.w,
                                    color: Color.fromRGBO(76, 81, 91, 1)),
                              ),
                              onTap: () {
                                _logOut();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              body: loadingUser
                  ? Container(
                      width: 490.w,
                      height: 980.h,
                      color: Colors.white,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Color.fromRGBO(119, 115, 205, 1),
                        ),
                      ),
                    )
                  : Container(
                      width: 490.w,
                      height: 980.h,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProfilPage()));
                              },
                              child: Container(
                                width: 490.w,
                                height: 104.h,
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                color: Colors.white,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 55.w,
                                      height: 55.h,
                                      margin: EdgeInsets.only(
                                        left: 7,
                                        right: 14,
                                      ),
                                      child: ClipOval(
                                        child: Image.network(
                                          Api.image + profil.image,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 490.w * 0.7,
                                      height: 68.h,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'Selamat Datang',
                                                style: TextStyle(
                                                  fontFamily: 'Gilroy-Light',
                                                  fontSize: 16.w,
                                                  color: Color.fromRGBO(
                                                      76, 81, 97, 1),
                                                ),
                                              ),
                                              Container(
                                                child: new Image.asset(
                                                  'assets/images/tangan.png',
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            child: Text(
                                              profil.nama,
                                              style: TextStyle(
                                                fontFamily: 'Gilroy-ExtraBold',
                                                fontSize: 22.w,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PostingBerita()));
                              },
                              child: Container(
                                width: 490.h,
                                height: 225.h,
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Center(
                                  child: new Image.asset(
                                    'assets/images/postberita.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 490.w,
                              height: 355.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 490.w * 0.9,
                                    height: 70.25.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.3),
                                          spreadRadius: 0,
                                          blurRadius: 1.5,
                                          offset: Offset(0, 1),
                                        )
                                      ],
                                      color: Colors.white,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        LaporanKeuangan()));
                                          },
                                          child: Container(
                                            width: 150.w,
                                            height: 980.h * 0.047,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Saldo',
                                                  style: TextStyle(
                                                    fontFamily: 'Gilroy-Light',
                                                    fontSize: 14.w,
                                                    color: Color.fromRGBO(
                                                        76, 81, 97, 1),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      child: Icon(
                                                        Icons.wallet_outlined,
                                                        size: 24.w,
                                                        color: Color.fromRGBO(
                                                            255, 199, 0, 1),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 120.w,
                                                      child: Text(
                                                        status == 'Admin' ||
                                                                status ==
                                                                    'Eksternal'
                                                            ? '-'
                                                            : convertToIdr(
                                                                int.parse(profil
                                                                    .saldo),
                                                                2),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-ExtraBold',
                                                          fontSize: 16.w,
                                                          color: Color.fromRGBO(
                                                              76, 81, 97, 1),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        VerticalDivider(
                                          color: Color.fromRGBO(0, 0, 0, 0.18),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        LaporanKeuangan()));
                                          },
                                          child: Container(
                                            width: 70.w,
                                            height: 980.h * 0.047,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Icon(
                                                  Icons.add_box_rounded,
                                                  color: Color.fromRGBO(
                                                      255, 199, 0, 1),
                                                  size: 21.w,
                                                ),
                                                Text(
                                                  'Top Up',
                                                  style: TextStyle(
                                                    fontFamily:
                                                        'Gilroy-ExtraBold',
                                                    fontSize: 16.w,
                                                    color: Color.fromRGBO(
                                                        76, 81, 97, 1),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        VerticalDivider(
                                          color: Color.fromRGBO(0, 0, 0, 0.18),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        LaporanKeuangan()));
                                          },
                                          child: Container(
                                            width: 70.w,
                                            height: 980.h * 0.047,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Icon(
                                                  Icons.ios_share_outlined,
                                                  color: Color.fromRGBO(
                                                      255, 199, 0, 1),
                                                  size: 21.w,
                                                ),
                                                Text(
                                                  'Tarik',
                                                  style: TextStyle(
                                                    fontFamily:
                                                        'Gilroy-ExtraBold',
                                                    fontSize: 16.w,
                                                    color: Color.fromRGBO(
                                                        76, 81, 97, 1),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          navigasiJadwal();
                                        },
                                        child: Container(
                                          width: 57.54.w,
                                          height: 84.61.h,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/images/Frame 125.png',
                                              ),
                                              Text(
                                                'Jadwal Kelas',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: 'Gilroy-Light',
                                                  fontSize: 11.w,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          navigasiRapor();
                                        },
                                        child: Container(
                                          width: 55.56.w,
                                          height: 78.05.h,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/images/Frame 126.png',
                                              ),
                                              Text(
                                                'Rapor',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: 'Gilroy-Light',
                                                  fontSize: 11.w,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          navigasiAbsensi();
                                        },
                                        child: Container(
                                          width: 55.56.w,
                                          height: 78.05.h,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/images/Frame 127.png',
                                              ),
                                              Text(
                                                'Absensi',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: 'Gilroy-Light',
                                                  fontSize: 11.w,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          navigasiFasilitas();
                                        },
                                        child: Container(
                                          width: 58.w,
                                          height: 71.h,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/images/Frame 128.png',
                                              ),
                                              Text(
                                                'Fasilitas',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: 'Gilroy-Light',
                                                  fontSize: 11.w,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          navigasiPerpustakaan();
                                        },
                                        child: Container(
                                          width: 71.w,
                                          height: 72.h,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/images/Frame 129.png',
                                              ),
                                              Text(
                                                'Perpustakaan',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: 'Gilroy-Light',
                                                  fontSize: 11.w,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EkstrakurikulerPage()));
                                        },
                                        child: Container(
                                          width: 77.w,
                                          height: 84.5.h,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/images/Frame 130.png',
                                              ),
                                              Text(
                                                'Ekstrakurikuler',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: 'Gilroy-Light',
                                                  fontSize: 11.w,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      KantinPage()));
                                        },
                                        child: Container(
                                          width: 57.w,
                                          height: 69.h,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/images/Frame 131.png',
                                              ),
                                              Text(
                                                'Kantin',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: 'Gilroy-Light',
                                                  fontSize: 11.w,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AdministrasiPage()));
                                        },
                                        child: Container(
                                          width: 88.w,
                                          height: 80.h,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/images/Frame 132.png',
                                              ),
                                              Text(
                                                'Administrasi Keuangan',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: 'Gilroy-Light',
                                                  fontSize: 11.w,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 490.w,
                              height: 980.h * 0.48,
                              padding: EdgeInsets.symmetric(
                                vertical: 30,
                                horizontal: 20,
                              ),
                              margin: EdgeInsets.only(top: 15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: 20),
                                        child: Text(
                                          'Berita Sekolah',
                                          style: TextStyle(
                                            fontFamily: 'Gilroy-ExtraBold',
                                            fontSize: 20.w,
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pushNamedAndRemoveUntil(
                                                  '/berita',
                                                  (Route<dynamic> route) =>
                                                      false);
                                        },
                                        child: Container(
                                          width: 490.w * 0.18,
                                          height: 980.h * 0.018,
                                          margin: EdgeInsets.only(right: 20),
                                          decoration: BoxDecoration(
                                            color: Color.fromRGBO(
                                                180, 176, 255, 1),
                                            border: Border.all(
                                              width: 1,
                                              color: Color.fromRGBO(
                                                  180, 176, 255, 1),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Lihat Semua",
                                              style: TextStyle(
                                                fontFamily: 'Gilroy-ExtraBold',
                                                fontSize: 12.w,
                                                color: Color.fromRGBO(
                                                    119, 115, 205, 1),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: 490.w * 0.85,
                                    height: 980.h * 0.27,
                                    margin: EdgeInsets.only(top: 20),
                                    child: loadingBerita
                                        ? Center(
                                            child: CircularProgressIndicator(
                                                color: Color.fromRGBO(
                                                    76, 81, 97, 1)),
                                          )
                                        : GridView.builder(
                                            itemCount: 3,
                                            gridDelegate:
                                                SliverGridDelegateWithMaxCrossAxisExtent(
                                              maxCrossAxisExtent: 445.w,
                                              mainAxisExtent: 89.h,
                                              crossAxisSpacing: 15,
                                            ),
                                            itemBuilder: (context, i) {
                                              final berita = _list[i];
                                              return GestureDetector(
                                                onTap: () {
                                                  showModalBottomSheet<void>(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(15),
                                                        topRight:
                                                            Radius.circular(15),
                                                      ),
                                                    ),
                                                    isScrollControlled: true,
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return Container(
                                                        height: 980.h * 0.87,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    15),
                                                            topRight:
                                                                Radius.circular(
                                                                    15),
                                                          ),
                                                          color: Colors.white,
                                                        ),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Container(
                                                                  width: 50.w,
                                                                  height: 50.h,
                                                                ),
                                                                Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.1,
                                                                  height: 5,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0.25),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: 50.w,
                                                                  height: 50.h,
                                                                ),
                                                              ],
                                                            ),
                                                            Container(
                                                              width:
                                                                  490.w * 0.8,
                                                              height:
                                                                  980.h * 0.16,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            9),
                                                              ),
                                                              child: new Image
                                                                  .asset(
                                                                'assets/images/logoberita.png',
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                            Container(
                                                              width:
                                                                  490.w * 0.8,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      top: 10),
                                                              child: Text(
                                                                '10 Sekolah Adiwiyata HSS Lomba cerdas cermat di Desa Rejosari',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-ExtraBold',
                                                                  fontSize:
                                                                      24.w,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          76,
                                                                          81,
                                                                          97,
                                                                          1),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              width:
                                                                  490.w * 0.8,
                                                              height: 31.h,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      top: 15),
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            16),
                                                                color: Color
                                                                    .fromRGBO(
                                                                        242,
                                                                        78,
                                                                        26,
                                                                        1),
                                                              ),
                                                              child: Center(
                                                                child: Text(
                                                                  '${berita.name} - 12-12-2022',
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'Gilroy-ExtraBold',
                                                                    fontSize:
                                                                        16.w,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              width:
                                                                  490.w * 0.8,
                                                              height:
                                                                  980.h * 0.5,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      top: 15),
                                                              child:
                                                                  SingleChildScrollView(
                                                                child: Text(
                                                                  'Pertemuan dua nama sekolah besar akan jadi laga pembuka Honda DBL 2021 DKI Jakarta Series, Kamis (7/10) besok di Gelanggang Remaja Cempaka Putih, Jakarta Pusat. Adalah Tim putra SMAN 28 Jakarta kontra SMAN 70 Jakarta. Bentroknya dua sekolah ini mengingatkan kita semua pada final Honda DBL DKI Jakarta Series 2019-South Region.\n\nDimana, kedua sekolah ini saling berjumpa waktu itu. Hanya saja, ketika itu perwakilan tim putri mereka yang saling bertemu. Srikandi SMAN 28 mampu menaklukan putri Seventy (julukan SMAN 70), di partai puncak 51-39.\n\nTahun ini, kedua sekolah kembali saling bentrok. Namun, diwakili oleh tim putranya. Tentu ini jadi misi revans putra Seventy demi menebus kekalahan tim putri mereka, dua tahun silam. “Pasti, anak-anak semangat mengusung misi ini, kami targetkan bisa ambil game pertama,” cetus Ari Adiska pelatih tim putra Seventy. Pertemuan dua nama sekolah besar akan jadi laga pembuka Honda DBL 2021 DKI Jakarta Series, Kamis (7/10) besok di Gelanggang Remaja Cempaka Putih, Jakarta Pusat. Adalah Tim putra SMAN 28 Jakarta kontra SMAN 70 Jakarta. Bentroknya dua sekolah ini mengingatkan kita semua pada final Honda DBL DKI Jakarta Series 2019-South Region. Dimana, kedua sekolah ini saling berjumpa waktu itu. Hanya saja, ketika itu perwakilan tim putri mereka yang saling bertemu. Srikandi SMAN 28 mampu menaklukan putri Seventy (julukan SMAN 70), di partai puncak 51-39. Tahun ini, kedua sekolah kembali saling bentrok. Namun, diwakili oleh tim putranya. Tentu ini jadi misi revans putra Seventy demi menebus kekalahan tim putri mereka, dua tahun silam. “Pasti, anak-anak semangat mengusung misi ini, kami targetkan bisa ambil game pertama,” cetus Ari Adiska pelatih tim putra Seventy.',
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'Gilroy-Light',
                                                                    fontSize:
                                                                        15.w,
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            76,
                                                                            81,
                                                                            97,
                                                                            1),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 20),
                                                  margin: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.3),
                                                        spreadRadius: 0,
                                                        blurRadius: 1.5,
                                                        offset: Offset(0, 1),
                                                      )
                                                    ],
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        width: 490.w * 0.55,
                                                        height: 64.h,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "10 Sekolah Adiwiyata HSS Lomba cerdas cermat di Desa Rejosari",
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Gilroy-ExtraBold',
                                                                fontSize: 16.w,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        76,
                                                                        81,
                                                                        97,
                                                                        1),
                                                              ),
                                                            ),
                                                            Text(
                                                              '${berita.name} - 12-12-2022',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Gilroy-Light',
                                                                fontSize: 13.w,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        76,
                                                                        81,
                                                                        97,
                                                                        1),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 67.w,
                                                        height: 67.h,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        7)),
                                                        child: new Image.asset(
                                                          'assets/images/logoberita.png',
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MutasiPage(profil: profil)));
                              },
                              child: Container(
                                width: 490.w,
                                child: Image.asset(
                                  'assets/images/mutasi.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}
