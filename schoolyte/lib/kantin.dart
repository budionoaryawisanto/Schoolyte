import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:schoolyte/absensi.dart';
import 'package:schoolyte/berita.dart';
import 'package:schoolyte/fasilitas.dart';
import 'package:schoolyte/home.dart';
import 'package:schoolyte/jadwal.dart';
import 'package:schoolyte/login.dart';
import 'package:schoolyte/menu.dart';
import 'package:schoolyte/nilaiBelajar.dart';
import 'package:schoolyte/perpustakaan.dart';
import 'package:schoolyte/rapor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'koperasi.dart';
import 'laporanKeuangan.dart';
import 'model.dart';
import 'osis.dart';
import 'ekstrakurikuler.dart';
import 'profil.dart';
import 'administrasi.dart';

class KantinPage extends StatefulWidget {
  @override
  _KantinPageState createState() => new _KantinPageState();
}

class _KantinPageState extends State<KantinPage> {
  List<Siswa> _siswa = [];
  List<Guru> _guru = [];
  List<Admin> _admin = [];
  List<Test> _list = [];
  List<Test> _search = [];
  late final profil;
  var loadingUser = false;
  var loading = false;
  var id;
  var status;
  var statusUser;

  Future<Null> fetchData() async {
    setState(() {
      loading = true;
    });
    _list.clear();
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        for (Map<String, dynamic> i in data) {
          _list.add(Test.formJson(i));
          loading = false;
        }
      });
    }
  }

  Future fetchDataSiswa() async {
    final prefs = await SharedPreferences.getInstance();
    id = prefs.getString('id');
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
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        for (Map<String, dynamic> i in data) {
          _admin.add(Admin.formJson(i));
        }
      });
      await getProfil();
    }
  }

  getProfil() async {
    final prefs = await SharedPreferences.getInstance();
    id = prefs.getString('id');
    status = prefs.getString('status');
    statusUser = prefs.getString('status user');
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

  @override
  void initState() {
    super.initState();
    fetchData();
    fetchDataSiswa();
    fetchDataGuru();
    fetchDataAdmin();
  }

  _logOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('slogin', false);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  bool akademikClick = true;
  bool peminjamanClick = true;
  bool pembelianClick = true;
  bool keuanganClick = true;
  bool kegiatanClick = true;
  bool profilClick = true;

  bool senClick = true;
  bool selClick = true;
  bool rabClick = true;
  bool kamClick = true;
  bool jumClick = true;

  int total = 30000;

  closeDrawer() {
    akademikClick = true;
    peminjamanClick = true;
    pembelianClick = true;
    keuanganClick = true;
    kegiatanClick = true;
    profilClick = true;
  }

  List<Tab> myTabs = <Tab>[
    Tab(text: 'Stand'),
    Tab(text: 'Pesanan Saya'),
    Tab(text: 'Selesai'),
  ];

  TextEditingController searchController = TextEditingController();
  TextEditingController catatanController = TextEditingController();

  onSearch(String text) async {
    _search.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    _list.forEach((e) {
      if (e.name.toLowerCase().contains(text.toLowerCase()) ||
          e.id.toString().contains(text)) {
        _search.add(e);
      }
    });
  }

  convertToIdr(dynamic number, int decimalDigit) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(number);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Color.fromRGBO(119, 119, 205, 1),
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    return ScreenUtilInit(
      designSize: const Size(490, 980),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: DefaultTabController(
            length: myTabs.length,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.white,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(138.h),
                child: AppBar(
                  backgroundColor: Color.fromRGBO(119, 115, 205, 1),
                  title: Align(
                    alignment: Alignment(-0.7, 0.0),
                    child: Text(
                      'Kantin',
                      style: TextStyle(
                        fontFamily: 'Gilroy-ExtraBold',
                        fontSize: 24.w,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  elevation: 0.0,
                  iconTheme: IconThemeData(color: Colors.white),
                  bottom: TabBar(
                    padding: EdgeInsets.only(bottom: 10),
                    indicatorColor: Colors.white,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorPadding: EdgeInsets.only(top: 0),
                    isScrollable: true,
                    labelStyle: TextStyle(
                      fontFamily: 'Gilroy-ExtraBold',
                      fontSize: 20.w,
                    ),
                    unselectedLabelStyle: TextStyle(
                      fontFamily: 'Gilroy-Light',
                      fontSize: 20.w,
                    ),
                    tabs: myTabs,
                  ),
                ),
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
                          fontFamily: 'Gilroy-Light',
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => JadwalPage()));
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RaporPage()));
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AbsensiPage()));
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PerpustakaanPage()));
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FasilitasPage()));
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
                              fontFamily: 'Gilroy-ExtraBold',
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
              body: TabBarView(
                children: [
                  Container(
                    width: 490.w,
                    height: 980.h,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            width: 490.w * 0.9,
                            height: 70.25.h,
                            margin: EdgeInsets.only(top: 10),
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Saldo',
                                          style: TextStyle(
                                            fontFamily: 'Gilroy-Light',
                                            fontSize: 14.w,
                                            color:
                                                Color.fromRGBO(76, 81, 97, 1),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                                                        status == 'Eksternal'
                                                    ? '-'
                                                    : loadingUser
                                                        ? '--'
                                                        : convertToIdr(
                                                            int.parse(
                                                                profil.saldo),
                                                            0),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
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
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(
                                          Icons.add_box_rounded,
                                          color: Color.fromRGBO(255, 199, 0, 1),
                                          size: 21.w,
                                        ),
                                        Text(
                                          'Top Up',
                                          style: TextStyle(
                                            fontFamily: 'Gilroy-ExtraBold',
                                            fontSize: 16.w,
                                            color:
                                                Color.fromRGBO(76, 81, 97, 1),
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
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(
                                          Icons.ios_share_outlined,
                                          color: Color.fromRGBO(255, 199, 0, 1),
                                          size: 21.w,
                                        ),
                                        Text(
                                          'Tarik',
                                          style: TextStyle(
                                            fontFamily: 'Gilroy-ExtraBold',
                                            fontSize: 16.w,
                                            color:
                                                Color.fromRGBO(76, 81, 97, 1),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 490.w * 0.855,
                            height: 50.h,
                            margin: EdgeInsets.only(top: 20.h),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(243, 243, 243, 1),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 0,
                                  blurRadius: 1.5,
                                  offset: Offset(0, 0),
                                )
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 490.w * 0.72,
                                  height: 46.h,
                                  child: Form(
                                    child: TextFormField(
                                      style: TextStyle(
                                        fontFamily: 'Gilroy-Light',
                                        fontSize: 16.w,
                                      ),
                                      textInputAction: TextInputAction.done,
                                      controller: searchController,
                                      autocorrect: true,
                                      onChanged: ((value) {
                                        setState(() {
                                          onSearch(value);
                                        });
                                      }),
                                      decoration: new InputDecoration(
                                        icon: Icon(
                                          Icons.search,
                                          size: 24.w,
                                        ),
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        hintText: 'Mau makan apa hari ini?',
                                        hintStyle: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                          fontSize: 16.w,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.cancel,
                                      size: 24.w,
                                      color: searchController.text.length != 0
                                          ? Colors.red
                                          : Color.fromRGBO(76, 81, 97, 58)),
                                  onPressed: () {
                                    searchController.clear();
                                    onSearch('');
                                  },
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 457.w,
                            height: 980.h * 0.66,
                            margin: EdgeInsets.only(top: 10),
                            child: loading
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : _search.length != 0 ||
                                        searchController.text.isNotEmpty
                                    ? GridView.builder(
                                        itemCount: _search.length,
                                        padding: EdgeInsets.all(10),
                                        gridDelegate:
                                            SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent: 140.w,
                                          mainAxisExtent: 275.h,
                                          crossAxisSpacing: 5,
                                          mainAxisSpacing: 5,
                                        ),
                                        itemBuilder: (context, i) {
                                          final b = _search[i];
                                          return GestureDetector(
                                            onTap: () async {
                                              final prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                              prefs.setString(
                                                  'nama kantin', b.name);
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Menu(
                                                            kantin: b,
                                                          )));
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 8.w,
                                                vertical: 4.h,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.3),
                                                    spreadRadius: 0,
                                                    blurRadius: 1.5,
                                                    offset: Offset(0, 0),
                                                  )
                                                ],
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 119.w,
                                                    height: 161.h,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: new Image.asset(
                                                      'assets/images/menu.png',
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 114.w,
                                                    child: Text(
                                                      'Dapur ' + b.name,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Gilroy-ExtraBold',
                                                        fontSize: 13.w,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 114.w,
                                                    child: Text(
                                                      'Kode: ' +
                                                          b.id.toString(),
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Gilroy-Light',
                                                        fontSize: 10.w,
                                                        color: Color.fromRGBO(
                                                            76, 81, 97, 1),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 114.w,
                                                    child: Text(
                                                      'Makanan, Minuman, Gorengan, Snack',
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Gilroy-Light',
                                                        fontSize: 10.w,
                                                        color: Color.fromRGBO(
                                                            76, 81, 97, 1),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 31.w,
                                                    height: 15.h,
                                                    decoration: BoxDecoration(
                                                      color: b.id % 2 == 0
                                                          ? Color.fromRGBO(
                                                              255, 217, 102, 1)
                                                          : Color.fromRGBO(
                                                              217, 217, 217, 1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        b.id % 2 == 0
                                                            ? 'Buka'
                                                            : 'Tutup',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-Light',
                                                          fontSize: 10.w,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        })
                                    : GridView.builder(
                                        itemCount: _list.length,
                                        padding: EdgeInsets.all(10),
                                        gridDelegate:
                                            SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent: 140.w,
                                          mainAxisExtent: 275.h,
                                          crossAxisSpacing: 10.w,
                                          mainAxisSpacing: 15.h,
                                        ),
                                        itemBuilder: (context, i) {
                                          final a = _list[i];
                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Menu(
                                                            kantin: a,
                                                          )));
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 8.w,
                                                vertical: 4.h,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.3),
                                                    spreadRadius: 0,
                                                    blurRadius: 1.5,
                                                    offset: Offset(0, 0),
                                                  )
                                                ],
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 119.w,
                                                    height: 161.h,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: new Image.asset(
                                                      'assets/images/menu.png',
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 114.w,
                                                    child: Text(
                                                      'Dapur ' + a.name,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Gilroy-ExtraBold',
                                                        fontSize: 13.w,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 114.w,
                                                    child: Text(
                                                      'Kode: ' +
                                                          a.id.toString(),
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Gilroy-Light',
                                                        fontSize: 10.w,
                                                        color: Color.fromRGBO(
                                                            76, 81, 97, 1),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 114.w,
                                                    child: Text(
                                                      'Makanan, Minuman, Gorengan, Snack',
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Gilroy-Light',
                                                        fontSize: 10.w,
                                                        color: Color.fromRGBO(
                                                            76, 81, 97, 1),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 31.w,
                                                    height: 15.h,
                                                    decoration: BoxDecoration(
                                                      color: a.id % 2 == 0
                                                          ? Color.fromRGBO(
                                                              255, 217, 102, 1)
                                                          : Color.fromRGBO(
                                                              217, 217, 217, 1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        a.id % 2 == 0
                                                            ? 'Buka'
                                                            : 'Tutup',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-Light',
                                                          fontSize: 10.w,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Container(
                        width: 490.w,
                        height: 980.h * 0.84,
                        color: Color.fromRGBO(243, 243, 243, 1),
                        child: GridView.builder(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15.w,
                              vertical: 20.h,
                            ),
                            itemCount: _list.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              mainAxisExtent: 225.h,
                              mainAxisSpacing: 15.w,
                            ),
                            itemBuilder: ((context, i) {
                              var menu = _list[i];
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      spreadRadius: 0,
                                      blurRadius: 1.5,
                                      offset: Offset(0, 0),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 437.w,
                                      height: 32.h,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'No Pesanan :',
                                                style: TextStyle(
                                                  fontFamily:
                                                      'Gilroy-ExtraBold',
                                                  fontSize: 13.w,
                                                  color: Color.fromRGBO(
                                                      76, 81, 97, 1),
                                                ),
                                              ),
                                              Text(
                                                '${menu.id}',
                                                style: TextStyle(
                                                  fontFamily: 'Gilroy-Light',
                                                  fontSize: 13.w,
                                                  color: Color.fromRGBO(
                                                      76, 81, 97, 1),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Waktu Pemesanan',
                                                style: TextStyle(
                                                  fontFamily: 'Gilroy-Light',
                                                  fontSize: 13.w,
                                                  color: Color.fromRGBO(
                                                      76, 81, 97, 1),
                                                ),
                                              ),
                                              Text(
                                                'Senin, 24 December 2022',
                                                style: TextStyle(
                                                  fontFamily: 'Gilroy-Light',
                                                  fontSize: 13.w,
                                                  color: Color.fromRGBO(
                                                      76, 81, 97, 1),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      color: Color.fromRGBO(76, 81, 97, 1),
                                    ),
                                    Container(
                                      width: 437.w,
                                      height: 99.h,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 89.w,
                                            height: 97.h,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Image.asset(
                                              'assets/images/menu.png',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Container(
                                            width: 329.w,
                                            height: 99.h,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Dapur ${menu.name}, Kode : ${menu.id}',
                                                  style: TextStyle(
                                                    fontFamily:
                                                        'Gilroy-ExtraBold',
                                                    fontSize: 13,
                                                    color: Color.fromRGBO(
                                                        76, 81, 97, 1),
                                                  ),
                                                ),
                                                Container(
                                                  width: 329.w,
                                                  height: 45.h,
                                                  child: GridView.builder(
                                                    itemCount: _list.length,
                                                    gridDelegate:
                                                        SliverGridDelegateWithFixedCrossAxisCount(
                                                            crossAxisCount: 1,
                                                            mainAxisExtent:
                                                                15.h),
                                                    itemBuilder: (context, i) {
                                                      final pesanan = _list[i];
                                                      return Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            '${pesanan.id}X Mie Ayam',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-Light',
                                                              fontSize: 13,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      76,
                                                                      81,
                                                                      97,
                                                                      1),
                                                            ),
                                                          ),
                                                          Text(
                                                            'Rp. 10.000',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-Light',
                                                              fontSize: 13,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      242,
                                                                      78,
                                                                      26,
                                                                      1),
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  width: 329.w,
                                                  height: 36.h,
                                                  child: Center(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'Total Pembayaran',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-Light',
                                                            fontSize: 13,
                                                            color:
                                                                Color.fromRGBO(
                                                                    76,
                                                                    81,
                                                                    97,
                                                                    1),
                                                          ),
                                                        ),
                                                        Text(
                                                          'Rp. 30.000',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-Light',
                                                            fontSize: 16,
                                                            color:
                                                                Color.fromRGBO(
                                                                    242,
                                                                    78,
                                                                    26,
                                                                    1),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Visibility(
                                      visible: menu.id == 2 || menu.id == 4
                                          ? false
                                          : true,
                                      child: Align(
                                        alignment: Alignment(0.97, 0.0),
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            width: 145.w,
                                            height: 36.h,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              color: Color.fromRGBO(
                                                  242, 78, 26, 1),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'Selesai',
                                                style: TextStyle(
                                                  fontFamily:
                                                      'Gilroy-ExtraBold',
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }))),
                  ),
                  SingleChildScrollView(
                    child: Container(
                        width: 490.w,
                        height: 980.h * 0.84,
                        color: Color.fromRGBO(243, 243, 243, 1),
                        child: GridView.builder(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15.w,
                              vertical: 20.h,
                            ),
                            itemCount: _list.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              mainAxisExtent: 215.h,
                              mainAxisSpacing: 15.w,
                            ),
                            itemBuilder: ((context, i) {
                              var menu = _list[i];
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      spreadRadius: 0,
                                      blurRadius: 1.5,
                                      offset: Offset(0, 0),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 437.w,
                                      height: 32.h,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'No Pesanan :',
                                                style: TextStyle(
                                                  fontFamily:
                                                      'Gilroy-ExtraBold',
                                                  fontSize: 13.w,
                                                  color: Color.fromRGBO(
                                                      76, 81, 97, 1),
                                                ),
                                              ),
                                              Text(
                                                '${menu.id}',
                                                style: TextStyle(
                                                  fontFamily: 'Gilroy-Light',
                                                  fontSize: 13.w,
                                                  color: Color.fromRGBO(
                                                      76, 81, 97, 1),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Waktu Pemesanan',
                                                style: TextStyle(
                                                  fontFamily: 'Gilroy-Light',
                                                  fontSize: 13.w,
                                                  color: Color.fromRGBO(
                                                      76, 81, 97, 1),
                                                ),
                                              ),
                                              Text(
                                                'Senin, 24 December 2022',
                                                style: TextStyle(
                                                  fontFamily: 'Gilroy-Light',
                                                  fontSize: 13.w,
                                                  color: Color.fromRGBO(
                                                      76, 81, 97, 1),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      color: Color.fromRGBO(76, 81, 97, 1),
                                    ),
                                    Container(
                                      width: 437.w,
                                      height: 99.h,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 89.w,
                                            height: 97.h,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Image.asset(
                                              'assets/images/menu.png',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Container(
                                            width: 329.w,
                                            height: 99.h,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Dapur ${menu.name}, Kode : ${menu.id}',
                                                  style: TextStyle(
                                                    fontFamily:
                                                        'Gilroy-ExtraBold',
                                                    fontSize: 13,
                                                    color: Color.fromRGBO(
                                                        76, 81, 97, 1),
                                                  ),
                                                ),
                                                Container(
                                                  width: 329.w,
                                                  height: 45.h,
                                                  child: GridView.builder(
                                                    itemCount: _list.length,
                                                    gridDelegate:
                                                        SliverGridDelegateWithFixedCrossAxisCount(
                                                            crossAxisCount: 1,
                                                            mainAxisExtent:
                                                                15.h),
                                                    itemBuilder: (context, i) {
                                                      final pesanan = _list[i];
                                                      return Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            '${pesanan.id}X Mie Ayam',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-Light',
                                                              fontSize: 13,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      76,
                                                                      81,
                                                                      97,
                                                                      1),
                                                            ),
                                                          ),
                                                          Text(
                                                            'Rp. 10.000',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-Light',
                                                              fontSize: 13,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      242,
                                                                      78,
                                                                      26,
                                                                      1),
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  width: 329.w,
                                                  height: 36.h,
                                                  child: Center(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'Total Pembayaran',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-Light',
                                                            fontSize: 13,
                                                            color:
                                                                Color.fromRGBO(
                                                                    76,
                                                                    81,
                                                                    97,
                                                                    1),
                                                          ),
                                                        ),
                                                        Text(
                                                          'Rp. 30.000',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-Light',
                                                            fontSize: 16,
                                                            color:
                                                                Color.fromRGBO(
                                                                    242,
                                                                    78,
                                                                    26,
                                                                    1),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      color: Color.fromRGBO(76, 81, 97, 1),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        width: 135.w,
                                        height: 24.h,
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          color:
                                              Color.fromRGBO(243, 243, 243, 1),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.wallet,
                                              size: 18,
                                              color:
                                                  Color.fromRGBO(76, 81, 97, 1),
                                            ),
                                            Text(
                                              '-Rp. 300.000',
                                              style: TextStyle(
                                                fontFamily: 'Gilroy-ExtraBold',
                                                fontSize: 16,
                                                color: Color.fromRGBO(
                                                    242, 78, 26, 1),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }))),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
