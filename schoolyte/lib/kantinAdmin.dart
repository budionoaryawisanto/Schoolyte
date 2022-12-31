import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolyte/administrasi.dart';
import 'package:schoolyte/ekstrakurikuler.dart';
import 'package:schoolyte/lihatPesanan.dart';
import 'package:schoolyte/model.dart';
import 'package:schoolyte/osis.dart';
import 'package:schoolyte/perpustakaan.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:schoolyte/home.dart';
import 'berita.dart';
import 'profil.dart';

class KantinAdmin extends StatefulWidget {
  @override
  _KantinAdminState createState() => new _KantinAdminState();
}

class _KantinAdminState extends State<KantinAdmin> {
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

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Color.fromRGBO(255, 217, 102, 1),
        systemNavigationBarColor: Colors.white,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    return ScreenUtilInit(
      designSize: const Size(490, 980),
      builder: (context, child) {
        return new MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
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
                elevation: 0,
                iconTheme: IconThemeData(color: Colors.white),
                backgroundColor: Color.fromRGBO(255, 217, 102, 1),
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
                        onTap: () {},
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
                        onTap: () {},
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
                        onTap: () {},
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
                        onTap: () {},
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
                        onTap: () {},
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
                                  builder: (context) => HomePage()));
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
                                  builder: (context) => KantinAdmin()));
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
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/infoFasilitas.png',
                      fit: BoxFit.fill,
                    ),
                    Container(
                      width: 220.w,
                      height: 400.h,
                      margin: EdgeInsets.only(top: 50.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Pilih Kategori',
                            style: TextStyle(
                                fontFamily: 'Gilroy-ExtraBold',
                                fontSize: 24.w,
                                color: Color.fromRGBO(
                                  76,
                                  81,
                                  97,
                                  1,
                                )),
                          ),
                          Container(
                            width: 220.w,
                            height: 200.h,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        width: 88.h,
                                        height: 114.w,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 70.w,
                                              height: 70.h,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.3),
                                                    spreadRadius: 0,
                                                    blurRadius: 1.5,
                                                    offset: Offset(0, 1),
                                                  ),
                                                ],
                                                color: Colors.white,
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  Icons.post_add,
                                                  size: 50.w,
                                                  color: Color.fromRGBO(
                                                      76, 81, 97, 1),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              'Tambah Menu',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: 'Gilroy-Light',
                                                fontSize: 14.w,
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
                                                    LihatPesanan()));
                                      },
                                      child: Container(
                                        width: 88.w,
                                        height: 114.h,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 70.w,
                                              height: 70.h,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.3),
                                                    spreadRadius: 0,
                                                    blurRadius: 1.5,
                                                    offset: Offset(0, 1),
                                                  ),
                                                ],
                                                color: Colors.white,
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  Icons.menu_book,
                                                  size: 50.w,
                                                  color: Color.fromRGBO(
                                                      76, 81, 97, 1),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              'Lihat Pesanan',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: 'Gilroy-Light',
                                                fontSize: 14.w,
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
