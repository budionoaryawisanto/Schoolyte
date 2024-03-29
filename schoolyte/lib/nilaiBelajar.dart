import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:schoolyte/absensi.dart';
import 'package:schoolyte/berita.dart';
import 'package:schoolyte/fasilitas.dart';
import 'package:schoolyte/jadwal.dart';
import 'package:schoolyte/perpustakaan.dart';
import 'package:schoolyte/rapor.dart';
import 'package:schoolyte/kantin.dart';
import 'package:schoolyte/home.dart';
import 'koperasi.dart';
import 'osis.dart';
import 'ekstrakurikuler.dart';
import 'profil.dart';
import 'administrasi.dart';

class NilaiBelajarPage extends StatefulWidget {
  @override
  _NilaiBelajarState createState() => new _NilaiBelajarState();
}

class _NilaiBelajarState extends State<NilaiBelajarPage> {
  @override
  void initState() {
    super.initState();
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

  var loading = false;

  var mapel = ['Matematika', 'Bahasa Indonesia', 'Bahasa Inggris'];

  List<Tab> myTabs = <Tab>[
    Tab(text: 'Pengetahuan'),
    Tab(text: 'Keterampilan'),
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Color.fromRGBO(255, 217, 102, 1),
        systemNavigationBarColor: Colors.white,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: DefaultTabController(
          length: myTabs.length,
          child: Scaffold(
            backgroundColor: Color.fromRGBO(243, 243, 243, 1),
            appBar: AppBar(
              title: Align(
                alignment: Alignment(-0.7, 0.0),
                child: Text(
                  'Nilai Belajar',
                  style: TextStyle(
                    fontFamily: 'Gilroy-ExtraBold',
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ),
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.white),
              backgroundColor: Color.fromRGBO(255, 217, 102, 1),
            ),
            drawer: Drawer(
              backgroundColor: Colors.white,
              width: 257,
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
                        fontSize: 16,
                        color: Color.fromRGBO(76, 81, 97, 1),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
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
                        fontSize: 16,
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
                            fontSize: 14,
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
                            fontSize: 14,
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
                            fontSize: 14,
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
                            fontFamily: 'Gilroy-ExtraBold',
                            fontSize: 14,
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
                        fontSize: 16,
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
                            fontSize: 14,
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
                            fontSize: 14,
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
                        fontSize: 16,
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
                            fontSize: 14,
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
                            fontSize: 14,
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
                        fontSize: 16,
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
                        fontSize: 16,
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
                        fontSize: 16,
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
                            fontSize: 14,
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
                            fontSize: 14,
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
                        fontSize: 16,
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
                                  fontSize: 14,
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
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: new Image.asset(
                      'assets/images/infonilai.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.065,
                    color: Colors.white,
                    child: TabBar(
                      padding: EdgeInsets.only(bottom: 10),
                      indicatorColor: Color.fromRGBO(76, 81, 97, 1),
                      indicatorSize: TabBarIndicatorSize.label,
                      labelColor: Color.fromRGBO(76, 81, 97, 1),
                      unselectedLabelColor: Color.fromRGBO(76, 81, 97, 1),
                      labelStyle: TextStyle(
                        fontFamily: 'Gilroy-ExtraBold',
                        fontSize: 20,
                        color: Color.fromRGBO(76, 81, 97, 1),
                      ),
                      unselectedLabelStyle: TextStyle(
                        fontFamily: 'Gilroy-Light',
                        fontSize: 20,
                        color: Color.fromRGBO(76, 81, 97, 1),
                      ),
                      tabs: myTabs,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.61,
                    child: TabBarView(
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment(-0.9, 0.0),
                                child: Container(
                                  margin: EdgeInsets.only(top: 20),
                                  child: Text(
                                    'Semester Ganjil',
                                    style: TextStyle(
                                      fontFamily: 'Gilroy-ExtraBold',
                                      fontSize: 18,
                                      color: Color.fromRGBO(76, 81, 97, 1),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 335,
                                margin: EdgeInsets.only(
                                  bottom: 20,
                                ),
                                child: GridView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: mapel.length,
                                  padding: EdgeInsets.all(10),
                                  gridDelegate:
                                      SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 330,
                                    mainAxisExtent: 461,
                                    mainAxisSpacing: 10,
                                  ),
                                  itemBuilder: (context, i) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.2),
                                            spreadRadius: 0,
                                            blurRadius: 1.5,
                                            offset: Offset(0, 0),
                                          )
                                        ],
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width:
                                                        MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 47,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 40,
                                              vertical: 10,
                                            ),
                                            child: Text(
                                              mapel[i],
                                              style: TextStyle(
                                                fontFamily: 'Gilroy-ExtraBold',
                                                fontSize: 20,
                                                color: Color.fromRGBO(
                                                    76, 81, 97, 1),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width:
                                                        MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 0.25,
                                                  color: Color.fromRGBO(
                                                      76, 81, 97, 0.37)),
                                            ),
                                          ),
                                          Container(
                                            width:
                                                        MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 198,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 40,
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                        'Tugas 1',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-light',
                                                          fontSize: 16,
                                                          color: Color.fromRGBO(
                                                              76, 81, 97, 1),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        '88',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-ExtraBold',
                                                          fontSize: 16,
                                                          color: Color.fromRGBO(
                                                              76, 81, 97, 1),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                        'Tugas 2',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-light',
                                                          fontSize: 16,
                                                          color: Color.fromRGBO(
                                                              76, 81, 97, 1),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        '88',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-ExtraBold',
                                                          fontSize: 16,
                                                          color: Color.fromRGBO(
                                                              76, 81, 97, 1),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                        'Tugas 3',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-light',
                                                          fontSize: 16,
                                                          color: Color.fromRGBO(
                                                              76, 81, 97, 1),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        '88',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-ExtraBold',
                                                          fontSize: 16,
                                                          color: Color.fromRGBO(
                                                              76, 81, 97, 1),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                        'UTS',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-light',
                                                          fontSize: 16,
                                                          color: Color.fromRGBO(
                                                              76, 81, 97, 1),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        '-',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-ExtraBold',
                                                          fontSize: 16,
                                                          color: Color.fromRGBO(
                                                              76, 81, 97, 1),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                        'UAS',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-light',
                                                          fontSize: 16,
                                                          color: Color.fromRGBO(
                                                              76, 81, 97, 1),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        '-',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-ExtraBold',
                                                          fontSize: 16,
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
                                          Container(
                                            width:
                                                        MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 47,
                                            padding: EdgeInsets.only(
                                              left: 120,
                                              right: 70,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10),
                                              ),
                                              color: Color.fromRGBO(
                                                  243, 243, 243, 1),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Total (rata-rata)',
                                                  style: TextStyle(
                                                    fontFamily:
                                                        'Gilroy-ExtraBold',
                                                    fontSize: 16,
                                                    color: Color.fromRGBO(
                                                        76, 81, 97, 1),
                                                  ),
                                                ),
                                                Text(
                                                  '88',
                                                  style: TextStyle(
                                                    fontFamily:
                                                        'Gilroy-ExtraBold',
                                                    fontSize: 16,
                                                    color: Color.fromRGBO(
                                                        76, 81, 97, 1),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Align(
                                alignment: Alignment(-0.9, 0.0),
                                child: Text(
                                  'Semester Genap',
                                  style: TextStyle(
                                    fontFamily: 'Gilroy-ExtraBold',
                                    fontSize: 18,
                                    color: Color.fromRGBO(76, 81, 97, 1),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 335,
                                margin: EdgeInsets.only(
                                  bottom: 10,
                                ),
                                child: GridView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: mapel.length,
                                  padding: EdgeInsets.all(10),
                                  gridDelegate:
                                      SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 330,
                                    mainAxisExtent: 461,
                                    mainAxisSpacing: 10,
                                  ),
                                  itemBuilder: (context, i) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.2),
                                            spreadRadius: 0,
                                            blurRadius: 1.5,
                                            offset: Offset(0, 0),
                                          )
                                        ],
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width:
                                                        MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 47,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 40,
                                              vertical: 10,
                                            ),
                                            child: Text(
                                              mapel[i],
                                              style: TextStyle(
                                                fontFamily: 'Gilroy-ExtraBold',
                                                fontSize: 20,
                                                color: Color.fromRGBO(
                                                    76, 81, 97, 1),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width:
                                                        MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 0.25,
                                                  color: Color.fromRGBO(
                                                      76, 81, 97, 0.37)),
                                            ),
                                          ),
                                          Container(
                                            width:
                                                        MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 198,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 40,
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                        'Tugas 1',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-light',
                                                          fontSize: 16,
                                                          color: Color.fromRGBO(
                                                              76, 81, 97, 1),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        '88',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-ExtraBold',
                                                          fontSize: 16,
                                                          color: Color.fromRGBO(
                                                              76, 81, 97, 1),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                        'Tugas 2',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-light',
                                                          fontSize: 16,
                                                          color: Color.fromRGBO(
                                                              76, 81, 97, 1),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        '88',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-ExtraBold',
                                                          fontSize: 16,
                                                          color: Color.fromRGBO(
                                                              76, 81, 97, 1),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                        'Tugas 3',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-light',
                                                          fontSize: 16,
                                                          color: Color.fromRGBO(
                                                              76, 81, 97, 1),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        '88',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-ExtraBold',
                                                          fontSize: 16,
                                                          color: Color.fromRGBO(
                                                              76, 81, 97, 1),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                        'UTS',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-light',
                                                          fontSize: 16,
                                                          color: Color.fromRGBO(
                                                              76, 81, 97, 1),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        '-',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-ExtraBold',
                                                          fontSize: 16,
                                                          color: Color.fromRGBO(
                                                              76, 81, 97, 1),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                        'UAS',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-light',
                                                          fontSize: 16,
                                                          color: Color.fromRGBO(
                                                              76, 81, 97, 1),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        '-',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-ExtraBold',
                                                          fontSize: 16,
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
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 47,
                                            padding: EdgeInsets.only(
                                              left: 120,
                                              right: 70,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10),
                                              ),
                                              color: Color.fromRGBO(
                                                  243, 243, 243, 1),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Total (rata-rata)',
                                                  style: TextStyle(
                                                    fontFamily:
                                                        'Gilroy-ExtraBold',
                                                    fontSize: 16,
                                                    color: Color.fromRGBO(
                                                        76, 81, 97, 1),
                                                  ),
                                                ),
                                                Text(
                                                  '88',
                                                  style: TextStyle(
                                                    fontFamily:
                                                        'Gilroy-ExtraBold',
                                                    fontSize: 16,
                                                    color: Color.fromRGBO(
                                                        76, 81, 97, 1),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment(-0.9, 0.0),
                                child: Container(
                                  margin: EdgeInsets.only(top: 20),
                                  child: Text(
                                    'Semester Ganjil',
                                    style: TextStyle(
                                      fontFamily: 'Gilroy-ExtraBold',
                                      fontSize: 18,
                                      color: Color.fromRGBO(76, 81, 97, 1),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 335,
                                margin: EdgeInsets.only(
                                  bottom: 20,
                                ),
                                child: GridView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: mapel.length,
                                  padding: EdgeInsets.all(10),
                                  gridDelegate:
                                      SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 330,
                                    mainAxisExtent: 461,
                                    mainAxisSpacing: 10,
                                  ),
                                  itemBuilder: (context, i) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.2),
                                            spreadRadius: 0,
                                            blurRadius: 1.5,
                                            offset: Offset(0, 0),
                                          )
                                        ],
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 47,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 40,
                                              vertical: 10,
                                            ),
                                            child: Text(
                                              mapel[i],
                                              style: TextStyle(
                                                fontFamily: 'Gilroy-ExtraBold',
                                                fontSize: 20,
                                                color: Color.fromRGBO(
                                                    76, 81, 97, 1),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 0.25,
                                                  color: Color.fromRGBO(
                                                      76, 81, 97, 0.37)),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 198,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 40,
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                        'Tugas Keterampilan 1',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-light',
                                                          fontSize: 16,
                                                          color: Color.fromRGBO(
                                                              76, 81, 97, 1),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        '88',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-ExtraBold',
                                                          fontSize: 16,
                                                          color: Color.fromRGBO(
                                                              76, 81, 97, 1),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                        'Tugas Keterampilan 2',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-light',
                                                          fontSize: 16,
                                                          color: Color.fromRGBO(
                                                              76, 81, 97, 1),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        '88',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-ExtraBold',
                                                          fontSize: 16,
                                                          color: Color.fromRGBO(
                                                              76, 81, 97, 1),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                        'Tugas Keterampilan 3',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-light',
                                                          fontSize: 16,
                                                          color: Color.fromRGBO(
                                                              76, 81, 97, 1),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        '88',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-ExtraBold',
                                                          fontSize: 16,
                                                          color: Color.fromRGBO(
                                                              76, 81, 97, 1),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                        'UTS',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-light',
                                                          fontSize: 16,
                                                          color: Color.fromRGBO(
                                                              76, 81, 97, 1),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        '-',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-ExtraBold',
                                                          fontSize: 16,
                                                          color: Color.fromRGBO(
                                                              76, 81, 97, 1),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                        'UAS',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-light',
                                                          fontSize: 16,
                                                          color: Color.fromRGBO(
                                                              76, 81, 97, 1),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        '-',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-ExtraBold',
                                                          fontSize: 16,
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
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 47,
                                            padding: EdgeInsets.only(
                                              left: 120,
                                              right: 70,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10),
                                              ),
                                              color: Color.fromRGBO(
                                                  243, 243, 243, 1),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Total (rata-rata)',
                                                  style: TextStyle(
                                                    fontFamily:
                                                        'Gilroy-ExtraBold',
                                                    fontSize: 16,
                                                    color: Color.fromRGBO(
                                                        76, 81, 97, 1),
                                                  ),
                                                ),
                                                Text(
                                                  '88',
                                                  style: TextStyle(
                                                    fontFamily:
                                                        'Gilroy-ExtraBold',
                                                    fontSize: 16,
                                                    color: Color.fromRGBO(
                                                        76, 81, 97, 1),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Align(
                                alignment: Alignment(-0.9, 0.0),
                                child: Text(
                                  'Semester Genap',
                                  style: TextStyle(
                                    fontFamily: 'Gilroy-ExtraBold',
                                    fontSize: 18,
                                    color: Color.fromRGBO(76, 81, 97, 1),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 335,
                                margin: EdgeInsets.only(
                                  bottom: 10,
                                ),
                                child: GridView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: mapel.length,
                                  padding: EdgeInsets.all(10),
                                  gridDelegate:
                                      SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 330,
                                    mainAxisExtent: 461,
                                    mainAxisSpacing: 10,
                                  ),
                                  itemBuilder: (context, i) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.2),
                                            spreadRadius: 0,
                                            blurRadius: 1.5,
                                            offset: Offset(0, 0),
                                          )
                                        ],
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 47,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 40,
                                              vertical: 10,
                                            ),
                                            child: Text(
                                              mapel[i],
                                              style: TextStyle(
                                                fontFamily: 'Gilroy-ExtraBold',
                                                fontSize: 20,
                                                color: Color.fromRGBO(
                                                    76, 81, 97, 1),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 0.25,
                                                  color: Color.fromRGBO(
                                                      76, 81, 97, 0.37)),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 198,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 40,
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                        'Tugas Keterampilan 1',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-light',
                                                          fontSize: 16,
                                                          color: Color.fromRGBO(
                                                              76, 81, 97, 1),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        '88',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-ExtraBold',
                                                          fontSize: 16,
                                                          color: Color.fromRGBO(
                                                              76, 81, 97, 1),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                        'Tugas Keterampilan 2',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-light',
                                                          fontSize: 16,
                                                          color: Color.fromRGBO(
                                                              76, 81, 97, 1),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        '88',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-ExtraBold',
                                                          fontSize: 16,
                                                          color: Color.fromRGBO(
                                                              76, 81, 97, 1),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                        'Tugas Keterampilan 3',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-light',
                                                          fontSize: 16,
                                                          color: Color.fromRGBO(
                                                              76, 81, 97, 1),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        '88',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-ExtraBold',
                                                          fontSize: 16,
                                                          color: Color.fromRGBO(
                                                              76, 81, 97, 1),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                        'UTS',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-light',
                                                          fontSize: 16,
                                                          color: Color.fromRGBO(
                                                              76, 81, 97, 1),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        '-',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-ExtraBold',
                                                          fontSize: 16,
                                                          color: Color.fromRGBO(
                                                              76, 81, 97, 1),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                        'UAS',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-light',
                                                          fontSize: 16,
                                                          color: Color.fromRGBO(
                                                              76, 81, 97, 1),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        '-',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-ExtraBold',
                                                          fontSize: 16,
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
                                          Container(
                                            width:
                                                        MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 47,
                                            padding: EdgeInsets.only(
                                              left: 120,
                                              right: 70,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10),
                                              ),
                                              color: Color.fromRGBO(
                                                  243, 243, 243, 1),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Total (rata-rata)',
                                                  style: TextStyle(
                                                    fontFamily:
                                                        'Gilroy-ExtraBold',
                                                    fontSize: 16,
                                                    color: Color.fromRGBO(
                                                        76, 81, 97, 1),
                                                  ),
                                                ),
                                                Text(
                                                  '88',
                                                  style: TextStyle(
                                                    fontFamily:
                                                        'Gilroy-ExtraBold',
                                                    fontSize: 16,
                                                    color: Color.fromRGBO(
                                                        76, 81, 97, 1),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
