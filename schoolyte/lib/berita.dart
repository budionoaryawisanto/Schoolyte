import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:schoolyte/postingBerita.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'koperasi.dart';
import 'model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:schoolyte/absensi.dart';
import 'package:schoolyte/fasilitas.dart';
import 'package:schoolyte/jadwal.dart';
import 'package:schoolyte/nilaiBelajar.dart';
import 'package:schoolyte/perpustakaan.dart';
import 'package:schoolyte/rapor.dart';
import 'package:schoolyte/kantin.dart';
import 'package:schoolyte/home.dart';
import 'osis.dart';
import 'ekstrakurikuler.dart';
import 'profil.dart';
import 'administrasi.dart';

class BeritaPage extends StatefulWidget {
  @override
  _BeritaPageState createState() => new _BeritaPageState();
}

class _BeritaPageState extends State<BeritaPage> {
  List<Berita> _berita = [];
  var loading = false;

  Future fetchDataBerita() async {
    setState(() {
      loading = true;
    });
    _berita.clear();
    final response = await http.get(Uri.parse(Api.getBerita));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      for (Map<String, dynamic> i in data) {
        _berita.add(Berita.formJson(i));
      }
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
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
        statusBarColor: Color.fromRGBO(255, 199, 0, 1),
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromRGBO(243, 243, 243, 1),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(75),
          child: AppBar(
            backgroundColor: Color.fromRGBO(255, 199, 0, 1),
            title: Align(
              alignment: Alignment(-0.7, 0.0),
              child: Text(
                'Berita',
                style: TextStyle(
                  fontFamily: 'Gilroy-ExtraBold',
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
            elevation: 0.0,
            iconTheme: IconThemeData(color: Colors.white),
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => JadwalPage()));
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => RaporPage()));
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AbsensiPage()));
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => KantinPage()));
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
                    fontFamily: 'Gilroy-ExtraBold',
                    fontSize: 16,
                    color: Color.fromRGBO(76, 81, 97, 1),
                  ),
                ),
                onTap: () {
                  setState(() {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => BeritaPage()));
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => OsisPage()));
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfilPage()));
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
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    height: 224,
                    viewportFraction: 1,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 2),
                  ),
                  items: _berita.map(
                    (berita) {
                      return Builder(
                        builder: (BuildContext context) {
                          return GestureDetector(
                            onTap: () {
                              showModalBottomSheet<void>(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                  ),
                                ),
                                isScrollControlled: true,
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.87,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                      ),
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: 50,
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.1,
                                              height: 5,
                                              decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    0, 0, 0, 0.25),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            Container(
                                              width: 50,
                                              height: 50,
                                            ),
                                          ],
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.16,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(9),
                                          ),
                                          child: Image.network(
                                            Api.image + berita.image,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          margin: EdgeInsets.only(top: 10),
                                          child: Text(
                                            berita.judul,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: 'Gilroy-ExtraBold',
                                              fontSize: 24,
                                              color:
                                                  Color.fromRGBO(76, 81, 97, 1),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          height: 31,
                                          margin: EdgeInsets.only(top: 15),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            color:
                                                Color.fromRGBO(242, 78, 26, 1),
                                          ),
                                          child: Center(
                                            child: Text(
                                              '${berita.id} - ${berita.tanggal}',
                                              style: TextStyle(
                                                fontFamily: 'Gilroy-ExtraBold',
                                                fontSize: 16,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.5,
                                          margin: EdgeInsets.only(top: 15),
                                          child: SingleChildScrollView(
                                            child: Text(
                                              berita.isi,
                                              style: TextStyle(
                                                fontFamily: 'Gilroy-Light',
                                                fontSize: 15,
                                                color: Color.fromRGBO(
                                                    76, 81, 97, 1),
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
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.22,
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment(0.0, 0.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 224,
                                      child: Image.network(
                                        Api.image + berita.image,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment(0.0, 0.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 224,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: <Color>[
                                            Color.fromRGBO(255, 255, 255, 0),
                                            Color.fromRGBO(87, 92, 107, 0.78),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment(0.0, 0.5),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.75,
                                      height: 58,
                                      child: Text(
                                        berita.judul,
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-ExtraBold',
                                          fontSize: 24,
                                          color: Colors.white,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ).toList(),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PostingBerita()));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 133,
                    margin: EdgeInsets.only(top: 10),
                    child: Image.asset(
                      'assets/images/postingBerita.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.53,
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: loading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : GridView.builder(
                          itemCount: _berita.length,
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent:
                                MediaQuery.of(context).size.width * 0.95,
                            mainAxisExtent:
                                MediaQuery.of(context).size.height * 0.095,
                            crossAxisSpacing: 20,
                          ),
                          itemBuilder: (context, i) {
                            final berita = _berita[i];
                            return GestureDetector(
                              onTap: () {
                                showModalBottomSheet<void>(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                    ),
                                  ),
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.87,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15),
                                        ),
                                        color: Colors.white,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 50,
                                                height: 50,
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.1,
                                                height: 5,
                                                decoration: BoxDecoration(
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 0.25),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                              Container(
                                                width: 50,
                                                height: 50,
                                              ),
                                            ],
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.16,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(9),
                                            ),
                                            child: Image.network(
                                              Api.image + berita.image,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8,
                                            margin: EdgeInsets.only(top: 10),
                                            child: Text(
                                              berita.judul,
                                              textAlign: TextAlign.center,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontFamily: 'Gilroy-ExtraBold',
                                                fontSize: 24,
                                                color: Color.fromRGBO(
                                                    76, 81, 97, 1),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8,
                                            height: 31,
                                            margin: EdgeInsets.only(top: 15),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              color: Color.fromRGBO(
                                                  242, 78, 26, 1),
                                            ),
                                            child: Center(
                                              child: Text(
                                                '${berita.id} - ${berita.tanggal}',
                                                style: TextStyle(
                                                  fontFamily:
                                                      'Gilroy-ExtraBold',
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.5,
                                            margin: EdgeInsets.only(top: 15),
                                            child: SingleChildScrollView(
                                              child: Text(
                                                berita.isi,
                                                style: TextStyle(
                                                  fontFamily: 'Gilroy-Light',
                                                  fontSize: 15,
                                                  color: Color.fromRGBO(
                                                      76, 81, 97, 1),
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
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                margin: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      spreadRadius: 0,
                                      blurRadius: 1.5,
                                      offset: Offset(0, 1),
                                    )
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      height: 64,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            berita.judul,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontFamily: 'Gilroy-ExtraBold',
                                              fontSize: 16,
                                              color:
                                                  Color.fromRGBO(76, 81, 97, 1),
                                            ),
                                          ),
                                          Text(
                                            '${berita.id} - ${berita.tanggal}',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy-Light',
                                              fontSize: 13,
                                              color:
                                                  Color.fromRGBO(76, 81, 97, 1),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.15,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.15,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7)),
                                      child: Image.network(
                                        Api.image + berita.image,
                                        fit: BoxFit.cover,
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
        ),
      ),
    );
  }
}
