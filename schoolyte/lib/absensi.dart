import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:schoolyte/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:math';
import 'package:dropdown_search/dropdown_search.dart';

class AbsensiPage extends StatefulWidget {
  @override
  _AbsensiPageState createState() => new _AbsensiPageState();
}

class _AbsensiPageState extends State<AbsensiPage> {
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

  List<String> listBulan = [
    "Januari",
    "Februari",
    "Maret",
    "April",
    "Mei",
    "Juni",
    "Juli",
    "Agustus",
    "September",
    "Oktober",
    "November",
    "Desember"
  ];

  String bulan = '';

  getJanuariList() {
    List<Widget> listItems = [];

    for (var i = 1; i <= 10; i++) {
      var newItems = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(
              left: 15,
              top: 10,
              bottom: 10,
            ),
            child: Row(
              children: [
                Text(
                  'Senin,',
                  style: TextStyle(
                    fontFamily: 'Gilroy-ExtraBold',
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                Text(
                  ' $i Januari 2022',
                  style: TextStyle(
                    fontFamily: 'Gilroy-Light',
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 50,
            height: 22,
            margin: EdgeInsets.only(
              right: 15,
              top: 10,
              bottom: 10,
            ),
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 217, 102, 0.38),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Text(
                'Hadir',
                style: TextStyle(
                  fontFamily: 'Gilroy-Light',
                  fontSize: 16,
                  color: Color.fromRGBO(76, 81, 97, 1),
                ),
              ),
            ),
          ),
        ],
      );
      listItems.add(newItems);
    }
    return listItems;
  }

  getFebruariList() {
    List<Widget> listItems = [];

    for (var i = 1; i <= 10; i++) {
      var newItems = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(
              left: 15,
              top: 10,
              bottom: 10,
            ),
            child: Row(
              children: [
                Text(
                  'Senin,',
                  style: TextStyle(
                    fontFamily: 'Gilroy-ExtraBold',
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                Text(
                  ' $i Februari 2022',
                  style: TextStyle(
                    fontFamily: 'Gilroy-Light',
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 50,
            height: 22,
            margin: EdgeInsets.only(
              right: 15,
              top: 10,
              bottom: 10,
            ),
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 217, 102, 0.38),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Text(
                'Hadir',
                style: TextStyle(
                  fontFamily: 'Gilroy-Light',
                  fontSize: 16,
                  color: Color.fromRGBO(76, 81, 97, 1),
                ),
              ),
            ),
          ),
        ],
      );
      listItems.add(newItems);
    }
    return listItems;
  }

  getMaretList() {
    List<Widget> listItems = [];

    for (var i = 1; i <= 10; i++) {
      var newItems = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(
              left: 15,
              top: 10,
              bottom: 10,
            ),
            child: Row(
              children: [
                Text(
                  'Senin,',
                  style: TextStyle(
                    fontFamily: 'Gilroy-ExtraBold',
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                Text(
                  ' $i Maret 2022',
                  style: TextStyle(
                    fontFamily: 'Gilroy-Light',
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 50,
            height: 22,
            margin: EdgeInsets.only(
              right: 15,
              top: 10,
              bottom: 10,
            ),
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 217, 102, 0.38),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Text(
                'Hadir',
                style: TextStyle(
                  fontFamily: 'Gilroy-Light',
                  fontSize: 16,
                  color: Color.fromRGBO(76, 81, 97, 1),
                ),
              ),
            ),
          ),
        ],
      );
      listItems.add(newItems);
    }
    return listItems;
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Color.fromRGBO(243, 243, 243, 1),
          appBar: AppBar(
            title: Align(
              alignment: Alignment(-0.7, 0.0),
              child: Text(
                'Absensi',
                style: TextStyle(
                  fontFamily: 'Gilroy-ExtraBold',
                  fontSize: 24,
                  color: Color.fromRGBO(76, 81, 97, 1),
                ),
              ),
            ),
            elevation: 0.0,
            iconTheme: IconThemeData(color: Color.fromARGB(255, 66, 65, 65)),
            backgroundColor: Colors.white,
            systemOverlayStyle: const SystemUiOverlayStyle(
              systemNavigationBarDividerColor: Color.fromRGBO(98, 103, 117, 1),
              statusBarColor: Colors.white,
              statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.dark,
            ),
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
                          '/rapor', (Route<dynamic> route) => false);
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
                          fontFamily: 'Gilroy-ExtraBold',
                          fontSize: 14,
                          color: Color.fromRGBO(76, 81, 91, 1)),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/absensi', (Route<dynamic> route) => false);
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
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/perpustakaan', (Route<dynamic> route) => false);
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
                      closeDrawer();
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
                      fontFamily: (profilClick == false)
                          ? 'Gilroy-ExtraBold'
                          : 'Gilroy-Light',
                      fontSize: 16,
                      color: (profilClick == false)
                          ? Colors.white
                          : Color.fromRGBO(76, 81, 97, 1),
                    ),
                  ),
                  onTap: () {
                    print('clicked');
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
            child: Container(
              width: 490,
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.only(bottom: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 428,
                    height: 313,
                    margin: EdgeInsets.only(top: 25),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 0,
                          blurRadius: 1.5,
                          offset: Offset(0, 0),
                        )
                      ],
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 428,
                          height: 53,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 199, 0, 1),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 15),
                                child: Text(
                                  'Januari 2022',
                                  style: TextStyle(
                                    fontFamily: 'Gilroy-ExtraBold',
                                    fontSize: 24,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 428,
                          height: 260,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: getJanuariList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 428,
                    height: 313,
                    margin: EdgeInsets.only(top: 25),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 0,
                          blurRadius: 1.5,
                          offset: Offset(0, 0),
                        )
                      ],
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 428,
                          height: 53,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 199, 0, 1),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 15),
                                child: Text(
                                  'Februari 2022',
                                  style: TextStyle(
                                    fontFamily: 'Gilroy-ExtraBold',
                                    fontSize: 24,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 428,
                          height: 260,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: getFebruariList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 428,
                    height: 313,
                    margin: EdgeInsets.only(top: 25),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 0,
                          blurRadius: 1.5,
                          offset: Offset(0, 0),
                        )
                      ],
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 428,
                          height: 53,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 199, 0, 1),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 15),
                                child: Text(
                                  'Maret 2022',
                                  style: TextStyle(
                                    fontFamily: 'Gilroy-ExtraBold',
                                    fontSize: 24,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 428,
                          height: 260,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: getMaretList(),
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
        ),
      ),
    );
  }
}
