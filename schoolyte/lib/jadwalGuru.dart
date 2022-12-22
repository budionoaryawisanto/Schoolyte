import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolyte/absensiPegawai.dart';
import 'package:schoolyte/ekstrakurikuler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:schoolyte/absensi.dart';
import 'package:schoolyte/berita.dart';
import 'package:schoolyte/fasilitas.dart';
import 'package:schoolyte/nilaiBelajar.dart';
import 'package:schoolyte/perpustakaan.dart';
import 'package:schoolyte/rapor.dart';
import 'package:schoolyte/kantin.dart';
import 'package:schoolyte/home.dart';
import 'koperasi.dart';
import 'osis.dart';
import 'profil.dart';
import 'administrasi.dart';
import 'model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class JadwalGuruPage extends StatefulWidget {
  @override
  _JadwalGuruPageState createState() => new _JadwalGuruPageState();
}

class _JadwalGuruPageState extends State<JadwalGuruPage> {
  List<Test> _jadwal = [];
  var loading = false;

  Future fetchJadwal() async {
    setState(() {
      loading = true;
    });
    _jadwal.clear();
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    print(response.body);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        for (Map<String, dynamic> i in data) {
          _jadwal.add(Test.formJson(i));
          loading = false;
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchJadwal();
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

  bool senClick = true;
  bool selClick = true;
  bool rabClick = true;
  bool kamClick = true;
  bool jumClick = true;

  closeDrawer() {
    akademikClick = true;
    peminjamanClick = true;
    pembelianClick = true;
    keuanganClick = true;
    kegiatanClick = true;
    profilClick = true;
  }

  close() {
    senClick = true;
    selClick = true;
    rabClick = true;
    kamClick = true;
    jumClick = true;
  }

  List<Tab> myTabs = <Tab>[
    Tab(
      child: Text(
        'Sen',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    ),
    Tab(
      child: Text(
        'Sel',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    ),
    Tab(
      child: Text(
        'Rab',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    ),
    Tab(
      child: Text(
        'Kam',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    ),
    Tab(
      child: Text(
        'Jum',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        systemNavigationBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    return ScreenUtilInit(
      designSize: const Size(490, 980),
      builder: (context, child) {
        return new MaterialApp(
          debugShowCheckedModeBanner: false,
          home: DefaultTabController(
            length: myTabs.length,
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(138),
                child: AppBar(
                  backgroundColor: Colors.white,
                  title: Align(
                    alignment: Alignment(-0.7, 0.0),
                    child: Text(
                      'Jadwal Kelas',
                      style: TextStyle(
                        fontFamily: 'Gilroy-ExtraBold',
                        fontSize: 24.w,
                        color: Color.fromRGBO(76, 81, 97, 1),
                      ),
                    ),
                  ),
                  elevation: 0.0,
                  iconTheme:
                      IconThemeData(color: Color.fromRGBO(76, 81, 97, 1)),
                  bottom: TabBar(
                    padding: EdgeInsets.only(bottom: 10),
                    indicatorColor: Color.fromRGBO(76, 81, 97, 1),
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorPadding: EdgeInsets.only(top: 0),
                    labelStyle: TextStyle(
                      fontFamily: 'Gilroy-ExtraBold',
                      fontSize: 20.w,
                      color: Color.fromRGBO(76, 81, 97, 1),
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
                              fontFamily: 'Gilroy-ExtraBold',
                              fontSize: 14.w,
                              color: Color.fromRGBO(76, 81, 91, 1)),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => JadwalGuruPage()));
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
                                  builder: (context) => AbsensiPegawaiPage()));
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
              body: TabBarView(
                children: [
                  loading
                      ? Center(
                          child: CircularProgressIndicator(
                              color: Color.fromRGBO(76, 81, 97, 1)),
                        )
                      : SingleChildScrollView(
                          child: Container(
                            width: 490.w,
                            height: 980.h * 0.8,
                            margin: EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: loading
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : GridView.builder(
                                    itemCount: 9,
                                    padding: EdgeInsets.all(10),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                      mainAxisExtent: 93.h,
                                      mainAxisSpacing: 15,
                                    ),
                                    itemBuilder: (context, i) {
                                      final jadwal = _jadwal[i];
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 20,
                                        ),
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.3),
                                              spreadRadius: 0,
                                              blurRadius: 1.5,
                                              offset: Offset(0, 1),
                                            )
                                          ],
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                                margin:
                                                    EdgeInsets.only(right: 40),
                                                child: new Image.asset(
                                                  'assets/images/garis.png',
                                                )),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Kelas 10 IPA ${jadwal.id}',
                                                  style: TextStyle(
                                                    fontFamily:
                                                        'Gilroy-ExtraBold',
                                                    fontSize: 24.w,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  '07:00 - 09:00 WIB',
                                                  style: TextStyle(
                                                    fontFamily: 'Gilroy-Light',
                                                    fontSize: 14.w,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                          ),
                        ),
                  loading
                      ? Center(
                          child: CircularProgressIndicator(
                              color: Color.fromRGBO(76, 81, 97, 1)),
                        )
                      : SingleChildScrollView(
                          child: Container(
                            width: 490.w,
                            height: 980.h * 0.8,
                            margin: EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: loading
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : GridView.builder(
                                    itemCount: 9,
                                    padding: EdgeInsets.all(10),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                      mainAxisExtent: 93.h,
                                      mainAxisSpacing: 15,
                                    ),
                                    itemBuilder: (context, i) {
                                      final jadwal = _jadwal[i];
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 20,
                                        ),
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.3),
                                              spreadRadius: 0,
                                              blurRadius: 1.5,
                                              offset: Offset(0, 1),
                                            )
                                          ],
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                                margin:
                                                    EdgeInsets.only(right: 40),
                                                child: new Image.asset(
                                                  'assets/images/garis.png',
                                                )),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Kelas 10 IPA ${jadwal.id}',
                                                  style: TextStyle(
                                                    fontFamily:
                                                        'Gilroy-ExtraBold',
                                                    fontSize: 24.w,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  '07:00 - 09:00 WIB',
                                                  style: TextStyle(
                                                    fontFamily: 'Gilroy-Light',
                                                    fontSize: 14.w,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                          ),
                        ),
                  loading
                      ? Center(
                          child: CircularProgressIndicator(
                              color: Color.fromRGBO(76, 81, 97, 1)),
                        )
                      : SingleChildScrollView(
                          child: Container(
                            width: 490.w,
                            height: 980.h * 0.8,
                            margin: EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: loading
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : GridView.builder(
                                    itemCount: 9,
                                    padding: EdgeInsets.all(10),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                      mainAxisExtent: 93.h,
                                      mainAxisSpacing: 15,
                                    ),
                                    itemBuilder: (context, i) {
                                      final jadwal = _jadwal[i];
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 20,
                                        ),
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.3),
                                              spreadRadius: 0,
                                              blurRadius: 1.5,
                                              offset: Offset(0, 1),
                                            )
                                          ],
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                                margin:
                                                    EdgeInsets.only(right: 40),
                                                child: new Image.asset(
                                                  'assets/images/garis.png',
                                                )),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Kelas 10 IPA ${jadwal.id}',
                                                  style: TextStyle(
                                                    fontFamily:
                                                        'Gilroy-ExtraBold',
                                                    fontSize: 24.w,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  '07:00 - 09:00 WIB',
                                                  style: TextStyle(
                                                    fontFamily: 'Gilroy-Light',
                                                    fontSize: 14.w,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                          ),
                        ),
                  loading
                      ? Center(
                          child: CircularProgressIndicator(
                              color: Color.fromRGBO(76, 81, 97, 1)),
                        )
                      : SingleChildScrollView(
                          child: Container(
                            width: 490.w,
                            height: 980.h * 0.8,
                            margin: EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: loading
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : GridView.builder(
                                    itemCount: 9,
                                    padding: EdgeInsets.all(10),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                      mainAxisExtent: 93.h,
                                      mainAxisSpacing: 15,
                                    ),
                                    itemBuilder: (context, i) {
                                      final jadwal = _jadwal[i];
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 20,
                                        ),
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.3),
                                              spreadRadius: 0,
                                              blurRadius: 1.5,
                                              offset: Offset(0, 1),
                                            )
                                          ],
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                                margin:
                                                    EdgeInsets.only(right: 40),
                                                child: new Image.asset(
                                                  'assets/images/garis.png',
                                                )),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Kelas 10 IPA ${jadwal.id}',
                                                  style: TextStyle(
                                                    fontFamily:
                                                        'Gilroy-ExtraBold',
                                                    fontSize: 24.w,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  '07:00 - 09:00 WIB',
                                                  style: TextStyle(
                                                    fontFamily: 'Gilroy-Light',
                                                    fontSize: 14.w,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                          ),
                        ),
                  loading
                      ? Center(
                          child: CircularProgressIndicator(
                              color: Color.fromRGBO(76, 81, 97, 1)),
                        )
                      : SingleChildScrollView(
                          child: Container(
                            width: 490.w,
                            height: 980.h * 0.8,
                            margin: EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: loading
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : GridView.builder(
                                    itemCount: 9,
                                    padding: EdgeInsets.all(10),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                      mainAxisExtent: 93.h,
                                      mainAxisSpacing: 15,
                                    ),
                                    itemBuilder: (context, i) {
                                      final jadwal = _jadwal[i];
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 20,
                                        ),
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.3),
                                              spreadRadius: 0,
                                              blurRadius: 1.5,
                                              offset: Offset(0, 1),
                                            )
                                          ],
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                                margin:
                                                    EdgeInsets.only(right: 40),
                                                child: new Image.asset(
                                                  'assets/images/garis.png',
                                                )),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Kelas 10 IPA ${jadwal.id}',
                                                  style: TextStyle(
                                                    fontFamily:
                                                        'Gilroy-ExtraBold',
                                                    fontSize: 24.w,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  '07:00 - 09:00 WIB',
                                                  style: TextStyle(
                                                    fontFamily: 'Gilroy-Light',
                                                    fontSize: 14.w,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                          ),
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
