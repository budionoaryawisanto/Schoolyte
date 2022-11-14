import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
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

class BeritaPage extends StatefulWidget {
  @override
  _BeritaPageState createState() => new _BeritaPageState();
}

class _BeritaPageState extends State<BeritaPage> {
  List<Test> _list = [];
  List<Test> _search = [];
  var loading = false;

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

  @override
  void initState() {
    super.initState();
    fetchData();
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
    Tab(text: 'Berita Sekolah'),
    Tab(text: 'Berita Kelas'),
  ];

  final TextEditingController searchController = TextEditingController();

  onSearch(String text) async {
    _search.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    _list.forEach((e) {
      if (e.name.toLowerCase().contains(text.toLowerCase()) ||
          e.id.toString().contains(text) ||
          e.username.toLowerCase().contains(text.toLowerCase())) {
        _search.add(e);
      }
    });
  }

  var imgList = [
    'assets/images/berita.jpg',
    'assets/images/infonilai.png',
    'assets/images/infoabsen.png'
  ];

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
      home: DefaultTabController(
        length: myTabs.length,
        child: Scaffold(
          backgroundColor: Color.fromRGBO(243, 243, 243, 1),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(138),
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
              bottom: TabBar(
                padding: EdgeInsets.only(bottom: 10),
                indicatorColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding: EdgeInsets.only(top: 0),
                labelStyle: TextStyle(
                  fontFamily: 'Gilroy-ExtraBold',
                  fontSize: 20,
                ),
                unselectedLabelStyle: TextStyle(
                  fontFamily: 'Gilroy-Light',
                  fontSize: 20,
                ),
                tabs: myTabs,
              ),
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
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
                      fontFamily: 'Gilroy-ExtraBold',
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
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
          body: TabBarView(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        height: MediaQuery.of(context).size.height * 0.22,
                        viewportFraction: 1,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 2),
                      ),
                      items: imgList.map(
                        (i) {
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                        BorderRadius.circular(
                                                            10),
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
                                              child: new Image.asset(
                                                i,
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
                                                'Seventy Andalkan Trio Bigman Untuk Hancurkan Pertahanan SMAN 28 | DBL ID',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      'Gilroy-ExtraBold',
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
                                                  0.4,
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
                                                  'Harir Ataki - 12/12/2022',
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
                                                  'Pertemuan dua nama sekolah besar akan jadi laga pembuka Honda DBL 2021 DKI Jakarta Series, Kamis (7/10) besok di Gelanggang Remaja Cempaka Putih, Jakarta Pusat. Adalah Tim putra SMAN 28 Jakarta kontra SMAN 70 Jakarta. Bentroknya dua sekolah ini mengingatkan kita semua pada final Honda DBL DKI Jakarta Series 2019-South Region.\n\nDimana, kedua sekolah ini saling berjumpa waktu itu. Hanya saja, ketika itu perwakilan tim putri mereka yang saling bertemu. Srikandi SMAN 28 mampu menaklukan putri Seventy (julukan SMAN 70), di partai puncak 51-39.\n\nTahun ini, kedua sekolah kembali saling bentrok. Namun, diwakili oleh tim putranya. Tentu ini jadi misi revans putra Seventy demi menebus kekalahan tim putri mereka, dua tahun silam. “Pasti, anak-anak semangat mengusung misi ini, kami targetkan bisa ambil game pertama,” cetus Ari Adiska pelatih tim putra Seventy. Pertemuan dua nama sekolah besar akan jadi laga pembuka Honda DBL 2021 DKI Jakarta Series, Kamis (7/10) besok di Gelanggang Remaja Cempaka Putih, Jakarta Pusat. Adalah Tim putra SMAN 28 Jakarta kontra SMAN 70 Jakarta. Bentroknya dua sekolah ini mengingatkan kita semua pada final Honda DBL DKI Jakarta Series 2019-South Region. Dimana, kedua sekolah ini saling berjumpa waktu itu. Hanya saja, ketika itu perwakilan tim putri mereka yang saling bertemu. Srikandi SMAN 28 mampu menaklukan putri Seventy (julukan SMAN 70), di partai puncak 51-39. Tahun ini, kedua sekolah kembali saling bentrok. Namun, diwakili oleh tim putranya. Tentu ini jadi misi revans putra Seventy demi menebus kekalahan tim putri mereka, dua tahun silam. “Pasti, anak-anak semangat mengusung misi ini, kami targetkan bisa ambil game pertama,” cetus Ari Adiska pelatih tim putra Seventy.',
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
                                  height:
                                      MediaQuery.of(context).size.height * 0.22,
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment(0.0, 0.0),
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 224,
                                          child: Image.asset(
                                            i,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment(0.0, 0.0),
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 224,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: <Color>[
                                                Color.fromRGBO(
                                                    255, 255, 255, 0),
                                                Color.fromRGBO(
                                                    87, 92, 107, 0.78),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment(0.0, 0.5),
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.75,
                                          height: 58,
                                          child: Text(
                                            'Seventy Andalkan Trio Bigman Untuk Hancurkan Pertahanan Lawan',
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
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.588,
                      margin: EdgeInsets.only(top: 10),
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: loading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : GridView.builder(
                              itemCount: 10,
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent:
                                    MediaQuery.of(context).size.width * 0.95,
                                mainAxisExtent:
                                    MediaQuery.of(context).size.height * 0.095,
                                crossAxisSpacing: 20,
                              ),
                              itemBuilder: (context, i) {
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
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    width: 50,
                                                    height: 50,
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.1,
                                                    height: 5,
                                                    decoration: BoxDecoration(
                                                      color: Color.fromRGBO(
                                                          0, 0, 0, 0.25),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
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
                                                child: new Image.asset(
                                                  'assets/images/logoberita.png',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.8,
                                                margin:
                                                    EdgeInsets.only(top: 10),
                                                child: Text(
                                                  '10 Sekolah Adiwiyata HSS Lomba cerdas cermat di Desa Rejosari',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily:
                                                        'Gilroy-ExtraBold',
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
                                                    0.4,
                                                height: 31,
                                                margin:
                                                    EdgeInsets.only(top: 15),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  color: Color.fromRGBO(
                                                      242, 78, 26, 1),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'Arya - 12/12/2022',
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
                                                margin:
                                                    EdgeInsets.only(top: 15),
                                                child: SingleChildScrollView(
                                                  child: Text(
                                                    'Pertemuan dua nama sekolah besar akan jadi laga pembuka Honda DBL 2021 DKI Jakarta Series, Kamis (7/10) besok di Gelanggang Remaja Cempaka Putih, Jakarta Pusat. Adalah Tim putra SMAN 28 Jakarta kontra SMAN 70 Jakarta. Bentroknya dua sekolah ini mengingatkan kita semua pada final Honda DBL DKI Jakarta Series 2019-South Region.\n\nDimana, kedua sekolah ini saling berjumpa waktu itu. Hanya saja, ketika itu perwakilan tim putri mereka yang saling bertemu. Srikandi SMAN 28 mampu menaklukan putri Seventy (julukan SMAN 70), di partai puncak 51-39.\n\nTahun ini, kedua sekolah kembali saling bentrok. Namun, diwakili oleh tim putranya. Tentu ini jadi misi revans putra Seventy demi menebus kekalahan tim putri mereka, dua tahun silam. “Pasti, anak-anak semangat mengusung misi ini, kami targetkan bisa ambil game pertama,” cetus Ari Adiska pelatih tim putra Seventy. Pertemuan dua nama sekolah besar akan jadi laga pembuka Honda DBL 2021 DKI Jakarta Series, Kamis (7/10) besok di Gelanggang Remaja Cempaka Putih, Jakarta Pusat. Adalah Tim putra SMAN 28 Jakarta kontra SMAN 70 Jakarta. Bentroknya dua sekolah ini mengingatkan kita semua pada final Honda DBL DKI Jakarta Series 2019-South Region. Dimana, kedua sekolah ini saling berjumpa waktu itu. Hanya saja, ketika itu perwakilan tim putri mereka yang saling bertemu. Srikandi SMAN 28 mampu menaklukan putri Seventy (julukan SMAN 70), di partai puncak 51-39. Tahun ini, kedua sekolah kembali saling bentrok. Namun, diwakili oleh tim putranya. Tentu ini jadi misi revans putra Seventy demi menebus kekalahan tim putri mereka, dua tahun silam. “Pasti, anak-anak semangat mengusung misi ini, kami targetkan bisa ambil game pertama,” cetus Ari Adiska pelatih tim putra Seventy.',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Gilroy-Light',
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    margin: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.6,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.064,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "10 Sekolah Adiwiyata HSS Lomba cerdas cermat di Desa Rejosari",
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontFamily:
                                                      'Gilroy-ExtraBold',
                                                  fontSize: 16,
                                                  color: Color.fromRGBO(
                                                      76, 81, 97, 1),
                                                ),
                                              ),
                                              Text(
                                                'Senin, 12/12/2022',
                                                style: TextStyle(
                                                  fontFamily: 'Gilroy-Light',
                                                  fontSize: 13,
                                                  color: Color.fromRGBO(
                                                      76, 81, 97, 1),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.15,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.15,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(7)),
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
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        height: MediaQuery.of(context).size.height * 0.22,
                        viewportFraction: 1,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 2),
                      ),
                      items: imgList.map(
                        (i) {
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                        BorderRadius.circular(
                                                            10),
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
                                              child: new Image.asset(
                                                i,
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
                                                'Seventy Andalkan Trio Bigman Untuk Hancurkan Pertahanan SMAN 28 | DBL ID',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      'Gilroy-ExtraBold',
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
                                                  0.4,
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
                                                  'Harir Ataki - 12/12/2022',
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
                                                  'Pertemuan dua nama sekolah besar akan jadi laga pembuka Honda DBL 2021 DKI Jakarta Series, Kamis (7/10) besok di Gelanggang Remaja Cempaka Putih, Jakarta Pusat. Adalah Tim putra SMAN 28 Jakarta kontra SMAN 70 Jakarta. Bentroknya dua sekolah ini mengingatkan kita semua pada final Honda DBL DKI Jakarta Series 2019-South Region.\n\nDimana, kedua sekolah ini saling berjumpa waktu itu. Hanya saja, ketika itu perwakilan tim putri mereka yang saling bertemu. Srikandi SMAN 28 mampu menaklukan putri Seventy (julukan SMAN 70), di partai puncak 51-39.\n\nTahun ini, kedua sekolah kembali saling bentrok. Namun, diwakili oleh tim putranya. Tentu ini jadi misi revans putra Seventy demi menebus kekalahan tim putri mereka, dua tahun silam. “Pasti, anak-anak semangat mengusung misi ini, kami targetkan bisa ambil game pertama,” cetus Ari Adiska pelatih tim putra Seventy. Pertemuan dua nama sekolah besar akan jadi laga pembuka Honda DBL 2021 DKI Jakarta Series, Kamis (7/10) besok di Gelanggang Remaja Cempaka Putih, Jakarta Pusat. Adalah Tim putra SMAN 28 Jakarta kontra SMAN 70 Jakarta. Bentroknya dua sekolah ini mengingatkan kita semua pada final Honda DBL DKI Jakarta Series 2019-South Region. Dimana, kedua sekolah ini saling berjumpa waktu itu. Hanya saja, ketika itu perwakilan tim putri mereka yang saling bertemu. Srikandi SMAN 28 mampu menaklukan putri Seventy (julukan SMAN 70), di partai puncak 51-39. Tahun ini, kedua sekolah kembali saling bentrok. Namun, diwakili oleh tim putranya. Tentu ini jadi misi revans putra Seventy demi menebus kekalahan tim putri mereka, dua tahun silam. “Pasti, anak-anak semangat mengusung misi ini, kami targetkan bisa ambil game pertama,” cetus Ari Adiska pelatih tim putra Seventy.',
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
                                  height:
                                      MediaQuery.of(context).size.height * 0.22,
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment(0.0, 0.0),
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 224,
                                          child: Image.asset(
                                            i,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment(0.0, 0.0),
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 224,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: <Color>[
                                                Color.fromRGBO(
                                                    255, 255, 255, 0),
                                                Color.fromRGBO(
                                                    87, 92, 107, 0.78),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment(0.0, 0.5),
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.75,
                                          height: 58,
                                          child: Text(
                                            'Seventy Andalkan Trio Bigman Untuk Hancurkan Pertahanan Lawan',
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
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.588,
                      margin: EdgeInsets.only(top: 10),
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: loading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : GridView.builder(
                              itemCount: 10,
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent:
                                    MediaQuery.of(context).size.width * 0.95,
                                mainAxisExtent:
                                    MediaQuery.of(context).size.height * 0.095,
                                crossAxisSpacing: 20,
                              ),
                              itemBuilder: (context, i) {
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
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    width: 50,
                                                    height: 50,
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.1,
                                                    height: 5,
                                                    decoration: BoxDecoration(
                                                      color: Color.fromRGBO(
                                                          0, 0, 0, 0.25),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
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
                                                child: new Image.asset(
                                                  'assets/images/logoberita.png',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.8,
                                                margin:
                                                    EdgeInsets.only(top: 10),
                                                child: Text(
                                                  '10 Sekolah Adiwiyata HSS Lomba cerdas cermat di Desa Rejosari',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily:
                                                        'Gilroy-ExtraBold',
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
                                                    0.4,
                                                height: 31,
                                                margin:
                                                    EdgeInsets.only(top: 15),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  color: Color.fromRGBO(
                                                      242, 78, 26, 1),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'Arya - 12/12/2022',
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
                                                margin:
                                                    EdgeInsets.only(top: 15),
                                                child: SingleChildScrollView(
                                                  child: Text(
                                                    'Pertemuan dua nama sekolah besar akan jadi laga pembuka Honda DBL 2021 DKI Jakarta Series, Kamis (7/10) besok di Gelanggang Remaja Cempaka Putih, Jakarta Pusat. Adalah Tim putra SMAN 28 Jakarta kontra SMAN 70 Jakarta. Bentroknya dua sekolah ini mengingatkan kita semua pada final Honda DBL DKI Jakarta Series 2019-South Region.\n\nDimana, kedua sekolah ini saling berjumpa waktu itu. Hanya saja, ketika itu perwakilan tim putri mereka yang saling bertemu. Srikandi SMAN 28 mampu menaklukan putri Seventy (julukan SMAN 70), di partai puncak 51-39.\n\nTahun ini, kedua sekolah kembali saling bentrok. Namun, diwakili oleh tim putranya. Tentu ini jadi misi revans putra Seventy demi menebus kekalahan tim putri mereka, dua tahun silam. “Pasti, anak-anak semangat mengusung misi ini, kami targetkan bisa ambil game pertama,” cetus Ari Adiska pelatih tim putra Seventy. Pertemuan dua nama sekolah besar akan jadi laga pembuka Honda DBL 2021 DKI Jakarta Series, Kamis (7/10) besok di Gelanggang Remaja Cempaka Putih, Jakarta Pusat. Adalah Tim putra SMAN 28 Jakarta kontra SMAN 70 Jakarta. Bentroknya dua sekolah ini mengingatkan kita semua pada final Honda DBL DKI Jakarta Series 2019-South Region. Dimana, kedua sekolah ini saling berjumpa waktu itu. Hanya saja, ketika itu perwakilan tim putri mereka yang saling bertemu. Srikandi SMAN 28 mampu menaklukan putri Seventy (julukan SMAN 70), di partai puncak 51-39. Tahun ini, kedua sekolah kembali saling bentrok. Namun, diwakili oleh tim putranya. Tentu ini jadi misi revans putra Seventy demi menebus kekalahan tim putri mereka, dua tahun silam. “Pasti, anak-anak semangat mengusung misi ini, kami targetkan bisa ambil game pertama,” cetus Ari Adiska pelatih tim putra Seventy.',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Gilroy-Light',
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    margin: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.6,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.064,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "10 Sekolah Adiwiyata HSS Lomba cerdas cermat di Desa Rejosari",
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontFamily:
                                                      'Gilroy-ExtraBold',
                                                  fontSize: 16,
                                                  color: Color.fromRGBO(
                                                      76, 81, 97, 1),
                                                ),
                                              ),
                                              Text(
                                                'Senin, 12/12/2022',
                                                style: TextStyle(
                                                  fontFamily: 'Gilroy-Light',
                                                  fontSize: 13,
                                                  color: Color.fromRGBO(
                                                      76, 81, 97, 1),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.15,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.15,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(7)),
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
            ],
          ),
        ),
      ),
    );
  }
}
