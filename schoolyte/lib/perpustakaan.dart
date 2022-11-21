import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'koperasi.dart';
import 'model.dart';
import 'package:schoolyte/absensi.dart';
import 'package:schoolyte/berita.dart';
import 'package:schoolyte/fasilitas.dart';
import 'package:schoolyte/jadwal.dart';
import 'package:schoolyte/nilaiBelajar.dart';
import 'package:schoolyte/rapor.dart';
import 'package:schoolyte/kantin.dart';
import 'package:schoolyte/home.dart';
import 'package:date_time_picker/date_time_picker.dart';

import 'osis.dart';
import 'sumbangBuku.dart';

class PerpustakaanPage extends StatefulWidget {
  @override
  _PerpustakaanPageState createState() => new _PerpustakaanPageState();
}

class _PerpustakaanPageState extends State<PerpustakaanPage> {
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
    Tab(text: 'Buku'),
    Tab(text: 'Menunggu'),
    Tab(text: 'Dipinjam'),
    Tab(text: 'Selesai'),
    Tab(text: 'Telat'),
    Tab(text: 'Kehilangan'),
  ];

  final TextEditingController searchController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

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

  var start = '';
  var end = '';
  var count = 1;

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: myTabs.length,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(138),
            child: AppBar(
              backgroundColor: Color.fromRGBO(119, 115, 205, 1),
              title: Align(
                alignment: Alignment(-0.7, 0.0),
                child: Text(
                  'Perpustakaan',
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
                isScrollable: true,
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
                          fontFamily: 'Gilroy-ExtraBold',
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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.88,
                        height: MediaQuery.of(context).size.height * 0.050,
                        margin: EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(243, 243, 243, 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.73,
                              child: Form(
                                child: TextFormField(
                                  style: TextStyle(
                                    fontFamily: 'Gilroy-Light',
                                    fontSize: 16,
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
                                      size: 24,
                                    ),
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    hintText: 'Apa yang ingin kamu pinjam?',
                                    hintStyle: TextStyle(
                                      fontFamily: 'Gilroy-Light',
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.cancel,
                                  size: 24,
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
                      SingleChildScrollView(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.73,
                          margin: EdgeInsets.all(20),
                          child: Stack(
                            children: [
                              loading
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
                                            maxCrossAxisExtent:
                                                MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.35,
                                            mainAxisExtent:
                                                MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.28,
                                            crossAxisSpacing: 15,
                                            mainAxisSpacing: 12,
                                          ),
                                          itemBuilder: (context, i) {
                                            final b = _search[i];
                                            return GestureDetector(
                                              onTap: () {
                                                showModalBottomSheet(
                                                    isScrollControlled: true,
                                                    enableDrag: false,
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return SafeArea(
                                                        child:
                                                            Container(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.964,
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            horizontal: 30,
                                                          ),
                                                          child:
                                                              SingleChildScrollView(
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                Container(
                                                                  margin: EdgeInsets
                                                                      .symmetric(
                                                                          vertical:
                                                                              30),
                                                                  child: Row(
                                                                    children: [
                                                                      GestureDetector(
                                                                        onTap: () =>
                                                                            Navigator.pop(context),
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .chevron_left,
                                                                          color: Color.fromRGBO(
                                                                              200,
                                                                              200,
                                                                              200,
                                                                              1),
                                                                          size:
                                                                              40,
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        margin: EdgeInsets.only(
                                                                            left:
                                                                                25),
                                                                        child:
                                                                            Text(
                                                                          'Pinjam Buku',
                                                                          style:
                                                                              TextStyle(
                                                                            fontFamily:
                                                                                'Gilroy-ExtraBold',
                                                                            fontSize:
                                                                                20,
                                                                            color: Color.fromRGBO(
                                                                                76,
                                                                                81,
                                                                                97,
                                                                                1),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Center(
                                                                  child:
                                                                      Container(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.33,
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        0.22,
                                                                    child: Image
                                                                        .asset(
                                                                      'assets/images/samplebook.png',
                                                                      fit: BoxFit
                                                                          .fill,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Center(
                                                                  child:
                                                                      Container(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.67,
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        0.2,
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceEvenly,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                          'Ilmu Pengetahuan Alam',
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style:
                                                                              TextStyle(
                                                                            fontFamily:
                                                                                'Gilroy-ExtraBold',
                                                                            fontSize:
                                                                                32,
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          'Tahun terbit: 2013',
                                                                          style:
                                                                              TextStyle(
                                                                            fontFamily:
                                                                                'Gilroy-Light',
                                                                            fontSize:
                                                                                13,
                                                                            color: Color.fromRGBO(
                                                                                76,
                                                                                81,
                                                                                97,
                                                                                1),
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          'Oleh: ' +
                                                                              b.name,
                                                                          style:
                                                                              TextStyle(
                                                                            fontFamily:
                                                                                'Gilroy-Light',
                                                                            fontSize:
                                                                                13,
                                                                            color: Color.fromRGBO(
                                                                                76,
                                                                                81,
                                                                                97,
                                                                                1),
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          width:
                                                                              MediaQuery.of(context).size.width * 0.12,
                                                                          height:
                                                                              MediaQuery.of(context).size.height * 0.018,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(4),
                                                                            color: b.id % 2 == 0
                                                                                ? Color.fromRGBO(119, 115, 205, 1)
                                                                                : Color.fromRGBO(217, 217, 217, 1),
                                                                          ),
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Text(
                                                                              b.id % 2 == 0 ? 'Tersedia : 6' : 'Habis',
                                                                              style: TextStyle(
                                                                                fontFamily: 'Gilroy-Light',
                                                                                fontSize: 10,
                                                                                color: b.id % 2 == 0 ? Colors.white : Colors.black,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                Center(
                                                                  child:
                                                                      Container(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.8,
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        0.24,
                                                                    child:
                                                                        SingleChildScrollView(
                                                                      child:
                                                                          Text(
                                                                        'Buku ini mendeskripsikan usaha minimal yang harus dilakukan siswa untuk mencapai kompetensi yang diharapkan. Sesuai dengan pendekatan yang dipergunakan dalam Kurikulum 2013, siswa diberanikan untuk mencari dari sumber belajar lain yang tersedia di sekitarnya. Peran guru sangat penting untuk meningkatkan dan menyesuaikan daya serap siswa dengan ketersediaan kegiatan pada buku ini. Guru dapat menyederhanakan dan memperkayanya dengan kreasi dalam bentuk kegiatan-kegiatan lain yang sesuai dan relevan yang bersumber dari lingkungan sosial dan alam. Buku IPA SMALB Tunarungu Kelas XI edisi pertama ini sangat terbuka dan terus dilakukan perbaikan dan penyempurnaan. Untuk itu, kami mengharapkan para pembaca memberikan masukan, kritik, dan saran untuk perbaikan dan penyempurnaan pada edisi berikutnya. Atas kontribusi tersebut, kami ucapkan terimakasih. Semoga kita dapat memberikan yang terbaik bagi kemajuan dunia pendidikan di Indonesia. Buku ini mendeskripsikan usaha minimal yang harus dilakukan siswa untuk mencapai kompetensi yang diharapkan. Sesuai dengan pendekatan yang dipergunakan dalam Kurikulum 2013, siswa diberanikan untuk mencari dari sumber belajar lain yang tersedia di sekitarnya. Peran guru sangat penting untuk meningkatkan dan menyesuaikan daya serap siswa dengan ketersediaan kegiatan pada buku ini. Guru dapat menyederhanakan dan memperkayanya dengan kreasi dalam bentuk kegiatan-kegiatan lain yang sesuai dan relevan yang bersumber dari lingkungan sosial dan alam. Buku IPA SMALB Tunarungu Kelas XI edisi pertama ini sangat terbuka dan terus dilakukan perbaikan dan penyempurnaan. Untuk itu, kami mengharapkan para pembaca memberikan masukan, kritik, dan saran untuk perbaikan dan penyempurnaan pada edisi berikutnya. Atas kontribusi tersebut, kami ucapkan terimakasih. Semoga kita dapat memberikan yang terbaik bagi kemajuan dunia pendidikan di Indonesia.',
                                                                        style:
                                                                            TextStyle(
                                                                          fontFamily:
                                                                              'Gilroy-Light',
                                                                          fontSize:
                                                                              12,
                                                                          color: Color.fromRGBO(
                                                                              76,
                                                                              81,
                                                                              97,
                                                                              1),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Divider(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          0.22),
                                                                ),
                                                                Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.9,
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.045,
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                        'Mulai       : ',
                                                                        style:
                                                                            TextStyle(
                                                                          fontFamily:
                                                                              'Gilroy-Light',
                                                                          fontSize:
                                                                              16,
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.65,
                                                                        margin: EdgeInsets.only(
                                                                            left:
                                                                                15),
                                                                        child:
                                                                            DateTimePicker(
                                                                          type:
                                                                              DateTimePickerType.dateTimeSeparate,
                                                                          dateMask:
                                                                              'd MMMM yyyy',
                                                                          initialValue:
                                                                              DateTime.now().toString(),
                                                                          firstDate:
                                                                              DateTime.now(),
                                                                          lastDate:
                                                                              DateTime(DateTime.now().year + 1),
                                                                          selectableDayPredicate:
                                                                              (date) {
                                                                            if (date.weekday == 6 ||
                                                                                date.weekday == 7) {
                                                                              return false;
                                                                            }

                                                                            return true;
                                                                          },
                                                                          onChanged: (val) =>
                                                                              setState(() {
                                                                            start =
                                                                                val;
                                                                          }),
                                                                          validator:
                                                                              (val) {
                                                                            return null;
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.9,
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.045,
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                        'Berakhir  : ',
                                                                        style:
                                                                            TextStyle(
                                                                          fontFamily:
                                                                              'Gilroy-Light',
                                                                          fontSize:
                                                                              16,
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.65,
                                                                        margin: EdgeInsets.only(
                                                                            left:
                                                                                15),
                                                                        child:
                                                                            DateTimePicker(
                                                                          type:
                                                                              DateTimePickerType.dateTimeSeparate,
                                                                          dateMask:
                                                                              'd MMMM yyyy',
                                                                          initialValue:
                                                                              DateTime.now().toString(),
                                                                          firstDate:
                                                                              DateTime.now(),
                                                                          lastDate:
                                                                              DateTime(DateTime.now().year + 1),
                                                                          selectableDayPredicate:
                                                                              (date) {
                                                                            if (date.weekday == 6 ||
                                                                                date.weekday == 7) {
                                                                              return false;
                                                                            }

                                                                            return true;
                                                                          },
                                                                          onChanged: (val) =>
                                                                              setState(() {
                                                                            end =
                                                                                val;
                                                                          }),
                                                                          validator:
                                                                              (val) {
                                                                            return null;
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.9,
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.033,
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          top:
                                                                              20),
                                                                  child: Row(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                        'Jumlah Buku : ',
                                                                        style:
                                                                            TextStyle(
                                                                          fontFamily:
                                                                              'Gilroy-Light',
                                                                          fontSize:
                                                                              16,
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.17,
                                                                        height: MediaQuery.of(context).size.height *
                                                                            0.026,
                                                                        margin: EdgeInsets.only(
                                                                            left:
                                                                                20),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceAround,
                                                                          children: [
                                                                            GestureDetector(
                                                                              onTap: () => setState(() {
                                                                                count != 1 ? count-- : null;
                                                                              }),
                                                                              child: Container(
                                                                                width: MediaQuery.of(context).size.width * 0.052,
                                                                                height: MediaQuery.of(context).size.height * 0.0240,
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(180),
                                                                                  border: Border.all(
                                                                                    width: 1,
                                                                                    color: Color.fromRGBO(119, 115, 205, 1),
                                                                                  ),
                                                                                ),
                                                                                child: Center(
                                                                                  child: Icon(
                                                                                    Icons.remove,
                                                                                    color: Color.fromRGBO(119, 115, 205, 1),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Text(
                                                                              count.toString(),
                                                                              style: TextStyle(
                                                                                fontFamily: 'Gilroy-Light',
                                                                                fontSize: 16,
                                                                                color: Colors.black,
                                                                              ),
                                                                            ),
                                                                            GestureDetector(
                                                                              onTap: () => setState(() {
                                                                                count++;
                                                                              }),
                                                                              child: Container(
                                                                                width: MediaQuery.of(context).size.width * 0.052,
                                                                                height: MediaQuery.of(context).size.height * 0.0240,
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(180),
                                                                                  border: Border.all(
                                                                                    width: 1,
                                                                                    color: Color.fromRGBO(119, 115, 205, 1),
                                                                                  ),
                                                                                ),
                                                                                child: Center(
                                                                                  child: Icon(
                                                                                    Icons.add,
                                                                                    color: Color.fromRGBO(119, 115, 205, 1),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.9,
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.04,
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          top:
                                                                              40),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      GestureDetector(
                                                                        onTap: () =>
                                                                            Navigator.pop(context),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              MediaQuery.of(context).size.width * 0.38,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(10),
                                                                            color: Color.fromRGBO(
                                                                                217,
                                                                                217,
                                                                                217,
                                                                                1),
                                                                          ),
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Text(
                                                                              'Batal',
                                                                              style: TextStyle(
                                                                                fontFamily: 'Gilroy-Light',
                                                                                fontSize: 18,
                                                                                color: Colors.black,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      GestureDetector(
                                                                        onTap: () =>
                                                                            print('clicked'),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              MediaQuery.of(context).size.width * 0.38,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(10),
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Text(
                                                                              'Pinjam Buku',
                                                                              style: TextStyle(
                                                                                fontFamily: 'Gilroy-Light',
                                                                                fontSize: 18,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
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
                                                      );
                                                    });
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 8,
                                                  vertical: 4,
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
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.16,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                      child: new Image.asset(
                                                        'assets/images/samplebook.png',
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        'Ilmu Pengetahuan Alam',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-ExtraBold',
                                                          fontSize: 13,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        'Tahun terbit: 2013',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-Light',
                                                          fontSize: 10,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        'Oleh: ' + b.name,
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-Light',
                                                          fontSize: 10,
                                                        ),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        'Kategori: Buku Paket',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-Light',
                                                          fontSize: 10,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.014,
                                                      decoration: BoxDecoration(
                                                        color: b.id % 2 == 0
                                                            ? Color.fromRGBO(
                                                                115,
                                                                119,
                                                                205,
                                                                1)
                                                            : Color.fromRGBO(
                                                                217,
                                                                217,
                                                                217,
                                                                1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          b.id % 2 == 0
                                                              ? 'Tersedia : 6'
                                                              : 'Habis',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-Light',
                                                            fontSize: 10,
                                                            color: b.id % 2 == 0
                                                                ? Colors.white
                                                                : Colors.black,
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
                                            maxCrossAxisExtent:
                                                MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.35,
                                            mainAxisExtent:
                                                MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.28,
                                            crossAxisSpacing: 15,
                                            mainAxisSpacing: 12,
                                          ),
                                          itemBuilder: (context, i) {
                                            final a = _list[i];
                                            return GestureDetector(
                                              onTap: () {
                                                showModalBottomSheet(
                                                    isScrollControlled: true,
                                                    enableDrag: false,
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return SafeArea(
                                                        child: Container(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.964,
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            horizontal: 30,
                                                          ),
                                                          child:
                                                              SingleChildScrollView(
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                Container(
                                                                  margin: EdgeInsets
                                                                      .symmetric(
                                                                          vertical:
                                                                              30),
                                                                  child: Row(
                                                                    children: [
                                                                      GestureDetector(
                                                                        onTap: () =>
                                                                            Navigator.pop(context),
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .chevron_left,
                                                                          color: Color.fromRGBO(
                                                                              200,
                                                                              200,
                                                                              200,
                                                                              1),
                                                                          size:
                                                                              40,
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        margin: EdgeInsets.only(
                                                                            left:
                                                                                25),
                                                                        child:
                                                                            Text(
                                                                          'Pinjam Buku',
                                                                          style:
                                                                              TextStyle(
                                                                            fontFamily:
                                                                                'Gilroy-ExtraBold',
                                                                            fontSize:
                                                                                20,
                                                                            color: Color.fromRGBO(
                                                                                76,
                                                                                81,
                                                                                97,
                                                                                1),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Center(
                                                                  child:
                                                                      Container(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.33,
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        0.22,
                                                                    child: Image
                                                                        .asset(
                                                                      'assets/images/samplebook.png',
                                                                      fit: BoxFit
                                                                          .fill,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Center(
                                                                  child:
                                                                      Container(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.67,
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        0.2,
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceEvenly,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                          'Ilmu Pengetahuan Alam',
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style:
                                                                              TextStyle(
                                                                            fontFamily:
                                                                                'Gilroy-ExtraBold',
                                                                            fontSize:
                                                                                32,
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          'Tahun terbit: 2013',
                                                                          style:
                                                                              TextStyle(
                                                                            fontFamily:
                                                                                'Gilroy-Light',
                                                                            fontSize:
                                                                                13,
                                                                            color: Color.fromRGBO(
                                                                                76,
                                                                                81,
                                                                                97,
                                                                                1),
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          'Oleh: ' +
                                                                              a.name,
                                                                          style:
                                                                              TextStyle(
                                                                            fontFamily:
                                                                                'Gilroy-Light',
                                                                            fontSize:
                                                                                13,
                                                                            color: Color.fromRGBO(
                                                                                76,
                                                                                81,
                                                                                97,
                                                                                1),
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          width:
                                                                              MediaQuery.of(context).size.width * 0.12,
                                                                          height:
                                                                              MediaQuery.of(context).size.height * 0.018,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(4),
                                                                            color: a.id % 2 == 0
                                                                                ? Color.fromRGBO(119, 115, 205, 1)
                                                                                : Color.fromRGBO(217, 217, 217, 1),
                                                                          ),
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Text(
                                                                              a.id % 2 == 0 ? 'Tersedia : 6' : 'Habis',
                                                                              style: TextStyle(
                                                                                fontFamily: 'Gilroy-Light',
                                                                                fontSize: 10,
                                                                                color: a.id % 2 == 0 ? Colors.white : Colors.black,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                Center(
                                                                  child:
                                                                      Container(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.8,
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        0.24,
                                                                    child:
                                                                        SingleChildScrollView(
                                                                      child:
                                                                          Text(
                                                                        'Buku ini mendeskripsikan usaha minimal yang harus dilakukan siswa untuk mencapai kompetensi yang diharapkan. Sesuai dengan pendekatan yang dipergunakan dalam Kurikulum 2013, siswa diberanikan untuk mencari dari sumber belajar lain yang tersedia di sekitarnya. Peran guru sangat penting untuk meningkatkan dan menyesuaikan daya serap siswa dengan ketersediaan kegiatan pada buku ini. Guru dapat menyederhanakan dan memperkayanya dengan kreasi dalam bentuk kegiatan-kegiatan lain yang sesuai dan relevan yang bersumber dari lingkungan sosial dan alam. Buku IPA SMALB Tunarungu Kelas XI edisi pertama ini sangat terbuka dan terus dilakukan perbaikan dan penyempurnaan. Untuk itu, kami mengharapkan para pembaca memberikan masukan, kritik, dan saran untuk perbaikan dan penyempurnaan pada edisi berikutnya. Atas kontribusi tersebut, kami ucapkan terimakasih. Semoga kita dapat memberikan yang terbaik bagi kemajuan dunia pendidikan di Indonesia. Buku ini mendeskripsikan usaha minimal yang harus dilakukan siswa untuk mencapai kompetensi yang diharapkan. Sesuai dengan pendekatan yang dipergunakan dalam Kurikulum 2013, siswa diberanikan untuk mencari dari sumber belajar lain yang tersedia di sekitarnya. Peran guru sangat penting untuk meningkatkan dan menyesuaikan daya serap siswa dengan ketersediaan kegiatan pada buku ini. Guru dapat menyederhanakan dan memperkayanya dengan kreasi dalam bentuk kegiatan-kegiatan lain yang sesuai dan relevan yang bersumber dari lingkungan sosial dan alam. Buku IPA SMALB Tunarungu Kelas XI edisi pertama ini sangat terbuka dan terus dilakukan perbaikan dan penyempurnaan. Untuk itu, kami mengharapkan para pembaca memberikan masukan, kritik, dan saran untuk perbaikan dan penyempurnaan pada edisi berikutnya. Atas kontribusi tersebut, kami ucapkan terimakasih. Semoga kita dapat memberikan yang terbaik bagi kemajuan dunia pendidikan di Indonesia.',
                                                                        style:
                                                                            TextStyle(
                                                                          fontFamily:
                                                                              'Gilroy-Light',
                                                                          fontSize:
                                                                              12,
                                                                          color: Color.fromRGBO(
                                                                              76,
                                                                              81,
                                                                              97,
                                                                              1),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Divider(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          0.22),
                                                                ),
                                                                Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.9,
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.045,
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                        'Mulai       : ',
                                                                        style:
                                                                            TextStyle(
                                                                          fontFamily:
                                                                              'Gilroy-Light',
                                                                          fontSize:
                                                                              16,
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.65,
                                                                        margin: EdgeInsets.only(
                                                                            left:
                                                                                15),
                                                                        child:
                                                                            DateTimePicker(
                                                                          type:
                                                                              DateTimePickerType.dateTimeSeparate,
                                                                          dateMask:
                                                                              'd MMMM yyyy',
                                                                          initialValue:
                                                                              DateTime.now().toString(),
                                                                          firstDate:
                                                                              DateTime.now(),
                                                                          lastDate:
                                                                              DateTime(DateTime.now().year + 1),
                                                                          selectableDayPredicate:
                                                                              (date) {
                                                                            if (date.weekday == 6 ||
                                                                                date.weekday == 7) {
                                                                              return false;
                                                                            }

                                                                            return true;
                                                                          },
                                                                          onChanged: (val) =>
                                                                              setState(() {
                                                                            start =
                                                                                val;
                                                                          }),
                                                                          validator:
                                                                              (val) {
                                                                            return null;
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.9,
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.045,
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                        'Berakhir  : ',
                                                                        style:
                                                                            TextStyle(
                                                                          fontFamily:
                                                                              'Gilroy-Light',
                                                                          fontSize:
                                                                              16,
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.65,
                                                                        margin: EdgeInsets.only(
                                                                            left:
                                                                                15),
                                                                        child:
                                                                            DateTimePicker(
                                                                          type:
                                                                              DateTimePickerType.dateTimeSeparate,
                                                                          dateMask:
                                                                              'd MMMM yyyy',
                                                                          initialValue:
                                                                              DateTime.now().toString(),
                                                                          firstDate:
                                                                              DateTime.now(),
                                                                          lastDate:
                                                                              DateTime(DateTime.now().year + 1),
                                                                          selectableDayPredicate:
                                                                              (date) {
                                                                            if (date.weekday == 6 ||
                                                                                date.weekday == 7) {
                                                                              return false;
                                                                            }

                                                                            return true;
                                                                          },
                                                                          onChanged: (val) =>
                                                                              setState(() {
                                                                            end =
                                                                                val;
                                                                          }),
                                                                          validator:
                                                                              (val) {
                                                                            return null;
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.9,
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.033,
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          top:
                                                                              20),
                                                                  child: Row(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                        'Jumlah Buku : ',
                                                                        style:
                                                                            TextStyle(
                                                                          fontFamily:
                                                                              'Gilroy-Light',
                                                                          fontSize:
                                                                              16,
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.17,
                                                                        height: MediaQuery.of(context).size.height *
                                                                            0.026,
                                                                        margin: EdgeInsets.only(
                                                                            left:
                                                                                20),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceAround,
                                                                          children: [
                                                                            GestureDetector(
                                                                              onTap: () => setState(() {
                                                                                count != 1 ? count-- : null;
                                                                              }),
                                                                              child: Container(
                                                                                width: MediaQuery.of(context).size.width * 0.052,
                                                                                height: MediaQuery.of(context).size.height * 0.0240,
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(180),
                                                                                  border: Border.all(
                                                                                    width: 1,
                                                                                    color: Color.fromRGBO(119, 115, 205, 1),
                                                                                  ),
                                                                                ),
                                                                                child: Center(
                                                                                  child: Icon(
                                                                                    Icons.remove,
                                                                                    color: Color.fromRGBO(119, 115, 205, 1),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Text(
                                                                              count.toString(),
                                                                              style: TextStyle(
                                                                                fontFamily: 'Gilroy-Light',
                                                                                fontSize: 16,
                                                                                color: Colors.black,
                                                                              ),
                                                                            ),
                                                                            GestureDetector(
                                                                              onTap: () => setState(() {
                                                                                count++;
                                                                              }),
                                                                              child: Container(
                                                                                width: MediaQuery.of(context).size.width * 0.052,
                                                                                height: MediaQuery.of(context).size.height * 0.0240,
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(180),
                                                                                  border: Border.all(
                                                                                    width: 1,
                                                                                    color: Color.fromRGBO(119, 115, 205, 1),
                                                                                  ),
                                                                                ),
                                                                                child: Center(
                                                                                  child: Icon(
                                                                                    Icons.add,
                                                                                    color: Color.fromRGBO(119, 115, 205, 1),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.9,
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.04,
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          top:
                                                                              40),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      GestureDetector(
                                                                        onTap: () =>
                                                                            Navigator.pop(context),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              MediaQuery.of(context).size.width * 0.38,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(10),
                                                                            color: Color.fromRGBO(
                                                                                217,
                                                                                217,
                                                                                217,
                                                                                1),
                                                                          ),
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Text(
                                                                              'Batal',
                                                                              style: TextStyle(
                                                                                fontFamily: 'Gilroy-Light',
                                                                                fontSize: 18,
                                                                                color: Colors.black,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      GestureDetector(
                                                                        onTap: () =>
                                                                            print('clicked'),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              MediaQuery.of(context).size.width * 0.38,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(10),
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Text(
                                                                              'Pinjam Buku',
                                                                              style: TextStyle(
                                                                                fontFamily: 'Gilroy-Light',
                                                                                fontSize: 18,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
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
                                                      );
                                                    });
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 8,
                                                  vertical: 4,
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
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.16,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                      child: new Image.asset(
                                                        'assets/images/samplebook.png',
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        'Ilmu Pengetahuan Alam',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-ExtraBold',
                                                          fontSize: 13,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        'Tahun terbit: 2013',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-Light',
                                                          fontSize: 10,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        'Oleh: ' + a.name,
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-Light',
                                                          fontSize: 10,
                                                        ),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        'Kategori: Buku Paket',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-Light',
                                                          fontSize: 10,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.014,
                                                      decoration: BoxDecoration(
                                                        color: a.id % 2 == 0
                                                            ? Color.fromRGBO(
                                                                115,
                                                                119,
                                                                205,
                                                                1)
                                                            : Color.fromRGBO(
                                                                217,
                                                                217,
                                                                217,
                                                                1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          a.id % 2 == 0
                                                              ? 'Tersedia : 6'
                                                              : 'Habis',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-Light',
                                                            fontSize: 10,
                                                            color: a.id % 2 == 0
                                                                ? Colors.white
                                                                : Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                              Align(
                                alignment: Alignment(0.9, 0.9),
                                child: FloatingActionButton(
                                  backgroundColor:
                                      Color.fromRGBO(119, 115, 205, 1),
                                  child: Icon(
                                    Icons.add,
                                    size: 40,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SumbangBuku()));
                                  },
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
              SingleChildScrollView(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.85,
                    padding: EdgeInsets.only(bottom: 25),
                    color: Color.fromRGBO(243, 243, 243, 1),
                    child: GridView.builder(
                        itemCount: _list.length,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: MediaQuery.of(context).size.width,
                          mainAxisExtent:
                              MediaQuery.of(context).size.height * 0.133,
                          mainAxisSpacing: 7,
                        ),
                        itemBuilder: ((context, i) {
                          final a = _list[i];
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.height *
                                      0.098,
                                  margin: EdgeInsets.only(left: 40),
                                  child: Image.asset(
                                    'assets/images/samplebook.png',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  height:
                                      MediaQuery.of(context).size.height * 0.11,
                                  margin: EdgeInsets.only(left: 40),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'ID Peminjaman : ' + a.id.toString(),
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                          fontSize: 15,
                                          color: Color.fromRGBO(76, 81, 97, 1),
                                        ),
                                      ),
                                      Text(
                                        'Ilmu Pengetahuan Alam',
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-ExtraBold',
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text(
                                        'Mulai : 07 September 2022',
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                          fontSize: 14,
                                          color: Color.fromRGBO(76, 81, 97, 78),
                                        ),
                                      ),
                                      Text(
                                        'Berakhir : 11 September 2022',
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                          fontSize: 14,
                                          color: Color.fromRGBO(76, 81, 97, 78),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.017,
                                        decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(217, 217, 217, 1),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Menunggu Konfirmasi',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy-Light',
                                              fontSize: 13,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }))),
              ),
              SingleChildScrollView(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.85,
                    padding: EdgeInsets.only(bottom: 25),
                    color: Color.fromRGBO(243, 243, 243, 1),
                    child: GridView.builder(
                        itemCount: _list.length,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: MediaQuery.of(context).size.width,
                          mainAxisExtent:
                              MediaQuery.of(context).size.height * 0.133,
                          mainAxisSpacing: 7,
                        ),
                        itemBuilder: ((context, i) {
                          final a = _list[i];
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.height *
                                      0.098,
                                  margin: EdgeInsets.only(left: 40),
                                  child: Image.asset(
                                    'assets/images/samplebook.png',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  height:
                                      MediaQuery.of(context).size.height * 0.11,
                                  margin: EdgeInsets.only(left: 40),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'ID Peminjaman : ' + a.id.toString(),
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                          fontSize: 15,
                                          color: Color.fromRGBO(76, 81, 97, 1),
                                        ),
                                      ),
                                      Text(
                                        'Ilmu Pengetahuan Alam',
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-ExtraBold',
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text(
                                        'Mulai : 07 September 2022',
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                          fontSize: 14,
                                          color: Color.fromRGBO(76, 81, 97, 78),
                                        ),
                                      ),
                                      Text(
                                        'Berakhir : 11 September 2022',
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                          fontSize: 14,
                                          color: Color.fromRGBO(76, 81, 97, 78),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.24,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.017,
                                        decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(255, 217, 102, 1),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Sedang Dipinjam',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy-Light',
                                              fontSize: 13,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }))),
              ),
              SingleChildScrollView(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.85,
                    padding: EdgeInsets.only(bottom: 25),
                    color: Color.fromRGBO(243, 243, 243, 1),
                    child: GridView.builder(
                        itemCount: _list.length,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: MediaQuery.of(context).size.width,
                          mainAxisExtent:
                              MediaQuery.of(context).size.height * 0.133,
                          mainAxisSpacing: 7,
                        ),
                        itemBuilder: ((context, i) {
                          final a = _list[i];
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.height *
                                      0.098,
                                  margin: EdgeInsets.only(left: 40),
                                  child: Image.asset(
                                    'assets/images/samplebook.png',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  height: MediaQuery.of(context).size.height *
                                      0.115,
                                  margin: EdgeInsets.only(left: 40),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'ID Peminjaman : ' + a.id.toString(),
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                          fontSize: 15,
                                          color: Color.fromRGBO(76, 81, 97, 1),
                                        ),
                                      ),
                                      Text(
                                        'Ilmu Pengetahuan Alam',
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-ExtraBold',
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text(
                                        'Mulai : 07 September 2022',
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                          fontSize: 14,
                                          color: Color.fromRGBO(76, 81, 97, 78),
                                        ),
                                      ),
                                      Text(
                                        'Berakhir : 11 September 2022',
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                          fontSize: 14,
                                          color: Color.fromRGBO(76, 81, 97, 78),
                                        ),
                                      ),
                                      Text(
                                        'Dikembalikan : 11 September 2022',
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                          fontSize: 14,
                                          color: Color.fromRGBO(76, 81, 97, 78),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.24,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.017,
                                        decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(217, 217, 217, 1),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Selesai Dipinjam',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy-Light',
                                              fontSize: 13,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }))),
              ),
              SingleChildScrollView(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.85,
                    padding: EdgeInsets.only(bottom: 25),
                    color: Color.fromRGBO(243, 243, 243, 1),
                    child: GridView.builder(
                        itemCount: _list.length,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: MediaQuery.of(context).size.width,
                          mainAxisExtent:
                              MediaQuery.of(context).size.height * 0.22,
                          mainAxisSpacing: 7,
                        ),
                        itemBuilder: ((context, i) {
                          final a = _list[i];
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.098,
                                        margin: EdgeInsets.only(left: 40),
                                        child: Image.asset(
                                          'assets/images/samplebook.png',
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.115,
                                        margin: EdgeInsets.only(left: 40),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'ID Peminjaman : ' +
                                                  a.id.toString(),
                                              style: TextStyle(
                                                fontFamily: 'Gilroy-Light',
                                                fontSize: 15,
                                                color: Color.fromRGBO(
                                                    76, 81, 97, 1),
                                              ),
                                            ),
                                            Text(
                                              'Ilmu Pengetahuan Alam',
                                              style: TextStyle(
                                                fontFamily: 'Gilroy-ExtraBold',
                                                fontSize: 20,
                                              ),
                                            ),
                                            Text(
                                              'Mulai : 07 September 2022',
                                              style: TextStyle(
                                                fontFamily: 'Gilroy-Light',
                                                fontSize: 14,
                                                color: Color.fromRGBO(
                                                    76, 81, 97, 78),
                                              ),
                                            ),
                                            Text(
                                              'Berakhir : 11 September 2022',
                                              style: TextStyle(
                                                fontFamily: 'Gilroy-Light',
                                                fontSize: 14,
                                                color: Color.fromRGBO(
                                                    76, 81, 97, 78),
                                              ),
                                            ),
                                            Text(
                                              'Dikembalikan : 12 September 2022',
                                              style: TextStyle(
                                                fontFamily: 'Gilroy-Light',
                                                fontSize: 14,
                                                color: Color.fromRGBO(
                                                    76, 81, 97, 78),
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.27,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.017,
                                              decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    242, 78, 26, 1),
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'Telat Pengembalian',
                                                  style: TextStyle(
                                                    fontFamily: 'Gilroy-Light',
                                                    fontSize: 13,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.83,
                                  height:
                                      MediaQuery.of(context).size.height * 0.07,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Telat Pengembalian : ',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy-ExtraBold',
                                              fontSize: 13,
                                              color:
                                                  Color.fromRGBO(76, 81, 97, 1),
                                            ),
                                          ),
                                          Text(
                                            '1 hari',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy-Light',
                                              fontSize: 13,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 80),
                                            child: Text(
                                              'Denda : ',
                                              style: TextStyle(
                                                fontFamily: 'Gilroy-Light',
                                                fontSize: 13,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'Rp.5000',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy-Light',
                                              fontSize: 13,
                                              color: Color.fromRGBO(
                                                  242, 78, 26, 1),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }))),
              ),
              SingleChildScrollView(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.85,
                    padding: EdgeInsets.only(bottom: 25),
                    color: Color.fromRGBO(243, 243, 243, 1),
                    child: GridView.builder(
                        itemCount: _list.length,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: MediaQuery.of(context).size.width,
                          mainAxisExtent:
                              MediaQuery.of(context).size.height * 0.22,
                          mainAxisSpacing: 7,
                        ),
                        itemBuilder: ((context, i) {
                          final a = _list[i];
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.098,
                                        margin: EdgeInsets.only(left: 40),
                                        child: Image.asset(
                                          'assets/images/samplebook.png',
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.115,
                                        margin: EdgeInsets.only(left: 40),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'ID Peminjaman : ' +
                                                  a.id.toString(),
                                              style: TextStyle(
                                                fontFamily: 'Gilroy-Light',
                                                fontSize: 15,
                                                color: Color.fromRGBO(
                                                    76, 81, 97, 1),
                                              ),
                                            ),
                                            Text(
                                              'Ilmu Pengetahuan Alam',
                                              style: TextStyle(
                                                fontFamily: 'Gilroy-ExtraBold',
                                                fontSize: 20,
                                              ),
                                            ),
                                            Text(
                                              'Mulai : 07 September 2022',
                                              style: TextStyle(
                                                fontFamily: 'Gilroy-Light',
                                                fontSize: 14,
                                                color: Color.fromRGBO(
                                                    76, 81, 97, 78),
                                              ),
                                            ),
                                            Text(
                                              'Berakhir : 11 September 2022',
                                              style: TextStyle(
                                                fontFamily: 'Gilroy-Light',
                                                fontSize: 14,
                                                color: Color.fromRGBO(
                                                    76, 81, 97, 78),
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.24,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.017,
                                              decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    242, 78, 26, 1),
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'Kehilangan Buku',
                                                  style: TextStyle(
                                                    fontFamily: 'Gilroy-Light',
                                                    fontSize: 13,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.83,
                                  height:
                                      MediaQuery.of(context).size.height * 0.07,
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(left: 60),
                                          child: Text(
                                            'Denda : ',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy-Light',
                                              fontSize: 13,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(right: 60),
                                          child: Text(
                                            'Rp.50000',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy-Light',
                                              fontSize: 13,
                                              color: Color.fromRGBO(
                                                  242, 78, 26, 1),
                                            ),
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
  }
}
