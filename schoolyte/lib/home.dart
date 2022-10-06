import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:schoolyte/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:math';
import 'package:dropdown_search/dropdown_search.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 1,
            iconTheme: IconThemeData(color: Color.fromARGB(255, 66, 65, 65)),
            backgroundColor: Colors.white,
            systemOverlayStyle: const SystemUiOverlayStyle(
              systemNavigationBarDividerColor: Color.fromRGBO(98, 103, 117, 1),
              statusBarColor: Colors.white,
              statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.dark,
            ),
            actions: <Widget>[
              Container(
                margin: EdgeInsetsDirectional.only(end: 10),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/landing', (Route<dynamic> route) => false);
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
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/home', (Route<dynamic> route) => false);
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
                    setState(() {
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
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/jadwal', (Route<dynamic> route) => false);
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
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/landing', (Route<dynamic> route) => false);
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
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/landing', (Route<dynamic> route) => false);
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
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/landing', (Route<dynamic> route) => false);
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
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/landing', (Route<dynamic> route) => false);
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
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/landing', (Route<dynamic> route) => false);
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
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/landing', (Route<dynamic> route) => false);
                    },
                  ),
                ),
                ListTile(
                  tileColor: (keuanganClick == false)
                      ? Color.fromRGBO(255, 199, 0, 1)
                      : Colors.white,
                  leading: Icon(
                    Icons.point_of_sale,
                    color: (keuanganClick == false)
                        ? Colors.white
                        : Color.fromRGBO(255, 199, 0, 1),
                  ),
                  title: Text(
                    'Administrasi Keuangan',
                    style: TextStyle(
                      fontFamily: (keuanganClick == false)
                          ? 'Gilroy-ExtraBold'
                          : 'Gilroy-Light',
                      fontSize: 16,
                      color: (keuanganClick == false)
                          ? Colors.white
                          : Color.fromRGBO(76, 81, 97, 1),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      keuanganClick = !keuanganClick;
                    });
                  },
                ),
                Visibility(
                  visible: (keuanganClick == false) ? true : false,
                  maintainAnimation: false,
                  maintainState: false,
                  child: ListTile(
                    tileColor: Color.fromRGBO(237, 237, 237, 1),
                    title: Text(
                      'Pembayaran SPP',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Gilroy-Light',
                          fontSize: 14,
                          color: Color.fromRGBO(76, 81, 91, 1)),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/landing', (Route<dynamic> route) => false);
                    },
                  ),
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
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/landing', (Route<dynamic> route) => false);
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
                      'Ekstrakulikuler',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Gilroy-Light',
                          fontSize: 14,
                          color: Color.fromRGBO(76, 81, 91, 1)),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/landing', (Route<dynamic> route) => false);
                    },
                  ),
                ),
                ListTile(
                  tileColor: (profilClick == false)
                      ? Color.fromRGBO(255, 199, 0, 1)
                      : Colors.white,
                  leading: Icon(
                    Icons.person_rounded,
                    color: (profilClick == false)
                        ? Colors.white
                        : Color.fromRGBO(255, 199, 0, 1),
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
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/landing', (Route<dynamic> route) => false);
                  },
                ),
                Visibility(
                  visible: (profilClick == false) ? true : false,
                  child: ListTile(
                    leading: Icon(
                      Icons.logout_rounded,
                    ),
                    tileColor: Color.fromRGBO(237, 237, 237, 1),
                    title: Text(
                      'Log Out',
                      style: TextStyle(
                          fontFamily: 'Gilroy-Light',
                          fontSize: 14,
                          color: Color.fromRGBO(76, 81, 91, 1)),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/landing', (Route<dynamic> route) => false);
                    },
                  ),
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
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/landing', (Route<dynamic> route) => false);
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
            child: Container(
              width: 490,
              height: 1100,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment(0.0, -1.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/landing', (Route<dynamic> route) => false);
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        fixedSize: Size(490, 104),
                        backgroundColor: Colors.white,
                      ),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment(-1.0, 0.0),
                            child: Container(
                              width: 55,
                              height: 55,
                              margin: EdgeInsets.only(left: 7),
                              child: ClipOval(
                                child: new Image.asset(
                                  'assets/images/profil.png',
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment(-0.6, -0.4),
                            child: Text(
                              'Selamat Datang',
                              style: TextStyle(
                                fontFamily: 'Gilroy-Light',
                                fontSize: 16,
                                color: Color.fromRGBO(76, 81, 97, 1),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment(-0.5, 0.2),
                            child: Container(
                              margin: EdgeInsets.only(left: 9),
                              child: Text(
                                'Rendy Pratama Putra',
                                style: TextStyle(
                                  fontFamily: 'Gilroy-ExtraBold',
                                  fontSize: 22,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Align(
                              alignment: Alignment(-0.1, -0.5),
                              child: new Image.asset(
                                'assets/images/tangan.png',
                              )),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(0.0, -0.8),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/landing', (Route<dynamic> route) => false);
                      },
                      child: Container(
                        width: 490,
                        height: 216,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(247, 247, 247, 1),
                        ),
                        child: Center(
                          child: new Image.asset(
                            'assets/images/autoslide1.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(0.0, -0.2),
                    child: Container(
                      width: 410,
                      height: 190,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment(-0.9, -1.0),
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/landing',
                                    (Route<dynamic> route) => false);
                              },
                              child: Container(
                                width: 56,
                                height: 83,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment(0.0, -1.0),
                                      child: new Image.asset(
                                        'assets/images/Frame 125.png',
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment(0.0, 0.8),
                                      child: Text(
                                        'Jadwal Kelas',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                          fontSize: 11,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment(-0.3, -1.0),
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/landing',
                                    (Route<dynamic> route) => false);
                              },
                              child: Container(
                                width: 56,
                                height: 83,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment(0.0, -1.0),
                                      child: new Image.asset(
                                        'assets/images/Frame 126.png',
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment(0.0, 0.7),
                                      child: Text(
                                        'Rapor',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                          fontSize: 11,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment(0.3, -1.0),
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/landing',
                                    (Route<dynamic> route) => false);
                              },
                              child: Container(
                                width: 56,
                                height: 83,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment(0.0, -1.0),
                                      child: new Image.asset(
                                        'assets/images/Frame 127.png',
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment(0.0, 0.5),
                                      child: Text(
                                        'Absensi',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                          fontSize: 11,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment(0.9, -1.0),
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/landing',
                                    (Route<dynamic> route) => false);
                              },
                              child: Container(
                                width: 56,
                                height: 83,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment(0.0, -1.0),
                                      child: new Image.asset(
                                        'assets/images/Frame 128.png',
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment(0.0, 0.5),
                                      child: Text(
                                        'Fasilitas',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                          fontSize: 11,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment(-0.9, 1.0),
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/landing',
                                    (Route<dynamic> route) => false);
                              },
                              child: Container(
                                width: 71,
                                height: 72,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment(0.0, -1.0),
                                      child: new Image.asset(
                                        'assets/images/Frame 129.png',
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment(0.0, 0.7),
                                      child: Text(
                                        'Perpustakaan',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                          fontSize: 11,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment(-0.2, 1.0),
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/landing',
                                    (Route<dynamic> route) => false);
                              },
                              child: Container(
                                width: 77,
                                height: 84.5,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment(0.0, -1.0),
                                      child: new Image.asset(
                                        'assets/images/Frame 130.png',
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment(0.0, 0.7),
                                      child: Text(
                                        'Ekstrakulikuler',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                          fontSize: 11,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment(0.4, 0.9),
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/landing',
                                    (Route<dynamic> route) => false);
                              },
                              child: Container(
                                width: 57,
                                height: 69,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment(0.0, -1.0),
                                      child: new Image.asset(
                                        'assets/images/Frame 131.png',
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment(0.0, 0.9),
                                      child: Text(
                                        'Kantin',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                          fontSize: 11,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment(1.0, 1.0),
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/landing',
                                    (Route<dynamic> route) => false);
                              },
                              child: Container(
                                width: 85,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment(0.0, -1.0),
                                      child: new Image.asset(
                                        'assets/images/Frame 132.png',
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment(0.0, 0.8),
                                      child: Text(
                                        'Pembayaran SPP',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                          fontSize: 11,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(0.0, 0.7),
                    child: Container(
                      width: 403,
                      height: 375,
                      child: Stack(
                        children: [
                          Align(
                            child: Container(
                              margin: EdgeInsets.only(top: 10),
                              alignment: Alignment(-1.0, -1.0),
                              child: Text(
                                'Berita Sekolah',
                                style: TextStyle(
                                  fontFamily: 'Gilroy-ExtraBold',
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment(1.0, -1.0),
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/landing',
                                    (Route<dynamic> route) => false);
                              },
                              child: Container(
                                width: 87,
                                height: 18,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(180, 176, 255, 1),
                                  border: Border.all(
                                    width: 1,
                                    color: Color.fromRGBO(180, 176, 255, 1),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    "Lihat Semua",
                                    style: TextStyle(
                                      fontFamily: 'Gilroy-ExtraBold',
                                      fontSize: 12,
                                      color: Color.fromRGBO(119, 115, 205, 1),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment(0.0, -0.6),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/landing',
                                    (Route<dynamic> route) => false);
                              },
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(403, 89),
                                side: BorderSide(
                                  width: 2,
                                  color: Color.fromARGB(255, 240, 236, 236),
                                ),
                                backgroundColor: Colors.white,
                              ),
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment(-0.9, 0.0),
                                    child: Container(
                                      width: 270,
                                      height: 44,
                                      child: Text(
                                        "10 Sekolah Adiwiyata HSS Lomba cerdas cermat di Desa Rejosari",
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-ExtraBold',
                                          fontSize: 16,
                                          color: Color.fromRGBO(76, 81, 97, 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment(1.0, 0.0),
                                    child: Container(
                                      width: 67,
                                      height: 67,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1,
                                            color: Colors.white,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(7)),
                                      child: new Image.asset(
                                        'assets/images/hi1.png',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment(0.0, 0.1),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/landing',
                                    (Route<dynamic> route) => false);
                              },
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(403, 89),
                                side: BorderSide(
                                  width: 2,
                                  color: Color.fromARGB(255, 240, 236, 236),
                                ),
                                backgroundColor: Colors.white,
                              ),
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment(-0.9, 0.0),
                                    child: Container(
                                      width: 270,
                                      height: 44,
                                      child: Text(
                                        "10 Sekolah Adiwiyata HSS Lomba cerdas cermat di Desa Rejosari",
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-ExtraBold',
                                          fontSize: 16,
                                          color: Color.fromRGBO(76, 81, 97, 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment(1.0, 0.0),
                                    child: Container(
                                      width: 67,
                                      height: 67,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1,
                                            color: Colors.white,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(7)),
                                      child: new Image.asset(
                                        'assets/images/hi1.png',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment(0.0, 0.8),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/landing',
                                    (Route<dynamic> route) => false);
                              },
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(403, 89),
                                side: BorderSide(
                                  width: 2,
                                  color: Color.fromARGB(255, 240, 236, 236),
                                ),
                                backgroundColor: Colors.white,
                              ),
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment(-0.9, 0.0),
                                    child: Container(
                                      width: 270,
                                      height: 44,
                                      child: Text(
                                        "10 Sekolah Adiwiyata HSS Lomba cerdas cermat di Desa Rejosari",
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-ExtraBold',
                                          fontSize: 16,
                                          color: Color.fromRGBO(76, 81, 97, 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment(1.0, 0.0),
                                    child: Container(
                                      width: 67,
                                      height: 67,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1,
                                            color: Colors.white,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(7)),
                                      child: new Image.asset(
                                        'assets/images/hi1.png',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
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
  }
}
