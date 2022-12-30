import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolyte/pinjamBuku.dart';
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
import 'ekstrakurikuler.dart';
import 'profil.dart';
import 'administrasi.dart';

class PerpustakaanPage extends StatefulWidget {
  @override
  _PerpustakaanPageState createState() => new _PerpustakaanPageState();
}

class _PerpustakaanPageState extends State<PerpustakaanPage> {
  List<Book> _books = [];
  List<Book> _search = [];
  var loading = false;

  Future fetchData() async {
    setState(() {
      loading = true;
    });
    _books.clear();
    final response = await http.get(Uri.parse(Api.getBook));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        for (Map<String, dynamic> i in data) {
          _books.add(Book.formJson(i));
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
    Tab(text: 'Kembali'),
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
    _books.forEach((book) {
      if (book.nama_buku.toLowerCase().contains(text.toLowerCase()) ||
          book.kategori_buku.toLowerCase().contains(text.toLowerCase()) ||
          book.nama_penulis.toLowerCase().contains(text.toLowerCase()) ||
          book.tahun_terbit.toLowerCase().contains(text.toLowerCase())) {
        _search.add(book);
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
                  'Perpustakaan',
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
                  fontSize: 20,
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
                          fontFamily: 'Gilroy-ExtraBold',
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
                              color: Color.fromRGBO(255, 199, 0, 1)),
                        )
                      : Container(
                          width: 490.w,
                          height: 980.h,
                          color: Color.fromRGBO(243, 243, 243, 1),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  width: 490.w,
                                  height: 85,
                                  color: Colors.white,
                                  child: Center(
                                    child: Container(
                                      width: 490.w * 0.88,
                                      height: 980.h * 0.050,
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(243, 243, 243, 1),
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.3),
                                            spreadRadius: 0,
                                            blurRadius: 1.5,
                                            offset: Offset(0, 0),
                                          )
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 490.w * 0.73,
                                            child: Form(
                                              child: TextFormField(
                                                style: TextStyle(
                                                  fontFamily: 'Gilroy-Light',
                                                  fontSize: 16.w,
                                                ),
                                                textInputAction:
                                                    TextInputAction.done,
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
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  hintText:
                                                      'Apa yang ingin kamu pinjam?',
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
                                                color: searchController
                                                            .text.length !=
                                                        0
                                                    ? Colors.red
                                                    : Color.fromRGBO(
                                                        76, 81, 97, 58)),
                                            onPressed: () {
                                              searchController.clear();
                                              onSearch('');
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 490.w,
                                  height: 980.h * 0.73,
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 10,
                                  ),
                                  child: Stack(
                                    children: [
                                      _search.length != 0 ||
                                              searchController.text.isNotEmpty
                                          ? GridView.builder(
                                              itemCount: _search.length,
                                              padding: EdgeInsets.all(10),
                                              gridDelegate:
                                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                                maxCrossAxisExtent: 140.h,
                                                mainAxisExtent: 282.w,
                                                crossAxisSpacing: 15.w,
                                                mainAxisSpacing: 12.h,
                                              ),
                                              itemBuilder: (context, i) {
                                                final book = _search[i];
                                                return GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                PinjamBuku(
                                                                    book:
                                                                        book)));
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 8.w,
                                                      vertical: 8.h,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7),
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
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          width: 119.w,
                                                          height: 161.h,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                          child: Image.network(
                                                            Api.image +
                                                                book.image,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        Container(
                                                          height: 100.h,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                    Alignment(
                                                                        -1.0,
                                                                        0.0),
                                                                child: Text(
                                                                  book.nama_buku,
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'Gilroy-ExtraBold',
                                                                    fontSize:
                                                                        13.w,
                                                                  ),
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    Alignment(
                                                                        -1.0,
                                                                        0.0),
                                                                child: Text(
                                                                  'Tahun terbit: ' +
                                                                      book.tahun_terbit,
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'Gilroy-Light',
                                                                    fontSize:
                                                                        10.w,
                                                                  ),
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    Alignment(
                                                                        -1.0,
                                                                        0.0),
                                                                child: Text(
                                                                  'Oleh: ' +
                                                                      book.nama_penulis,
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'Gilroy-Light',
                                                                    fontSize:
                                                                        10.w,
                                                                  ),
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    Alignment(
                                                                        -1.0,
                                                                        0.0),
                                                                child: Text(
                                                                  'Kategori: ' +
                                                                      book.kategori_buku,
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'Gilroy-Light',
                                                                    fontSize:
                                                                        10.w,
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                height: 980.h *
                                                                    0.014,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: book.jumlah_buku !=
                                                                          '0'
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
                                                                          .circular(
                                                                              4),
                                                                ),
                                                                child: Center(
                                                                  child: Text(
                                                                    book.jumlah_buku !=
                                                                            '0'
                                                                        ? 'Tersedia : ' +
                                                                            book.jumlah_buku
                                                                        : 'Habis',
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'Gilroy-Light',
                                                                      fontSize:
                                                                          10.w,
                                                                      color: book.jumlah_buku !=
                                                                              '0'
                                                                          ? Colors
                                                                              .white
                                                                          : Colors
                                                                              .black,
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
                                                );
                                              })
                                          : GridView.builder(
                                              itemCount: _books.length,
                                              padding: EdgeInsets.all(10),
                                              gridDelegate:
                                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                                maxCrossAxisExtent: 140.w,
                                                mainAxisExtent: 282.h,
                                                crossAxisSpacing: 15.w,
                                                mainAxisSpacing: 12.h,
                                              ),
                                              itemBuilder: (context, i) {
                                                final book = _books[i];
                                                return GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                PinjamBuku(
                                                                    book:
                                                                        book)));
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 8.w,
                                                      vertical: 8.h,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7),
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
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          width: 119.w,
                                                          height: 161.h,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                          child: Image.network(
                                                            Api.image +
                                                                book.image,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        Container(
                                                          height: 100.h,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                    Alignment(
                                                                        -1.0,
                                                                        0.0),
                                                                child: Text(
                                                                  book.nama_buku,
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'Gilroy-ExtraBold',
                                                                    fontSize:
                                                                        13.w,
                                                                  ),
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    Alignment(
                                                                        -1.0,
                                                                        0.0),
                                                                child: Text(
                                                                  'Tahun terbit: ' +
                                                                      book.tahun_terbit,
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'Gilroy-Light',
                                                                    fontSize:
                                                                        10.w,
                                                                  ),
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    Alignment(
                                                                        -1.0,
                                                                        0.0),
                                                                child: Text(
                                                                  'Oleh: ' +
                                                                      book.nama_penulis,
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'Gilroy-Light',
                                                                    fontSize:
                                                                        10.w,
                                                                  ),
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    Alignment(
                                                                        -1.0,
                                                                        0.0),
                                                                child: Text(
                                                                  'Kategori: ' +
                                                                      book.kategori_buku,
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'Gilroy-Light',
                                                                    fontSize:
                                                                        10.w,
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                height: 980.w *
                                                                    0.014,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: book.jumlah_buku !=
                                                                          '0'
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
                                                                          .circular(
                                                                              4),
                                                                ),
                                                                child: Center(
                                                                  child: Text(
                                                                    book.jumlah_buku !=
                                                                            '0'
                                                                        ? 'Tersedia : ' +
                                                                            book.jumlah_buku
                                                                        : 'Habis',
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'Gilroy-Light',
                                                                      fontSize:
                                                                          10.w,
                                                                      color: book.jumlah_buku !=
                                                                              '0'
                                                                          ? Colors
                                                                              .white
                                                                          : Colors
                                                                              .black,
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
                              ],
                            ),
                          ),
                        ),
                  SingleChildScrollView(
                child: Container(
                        width: 490.w,
                        height: 980.h * 0.85,
                    padding: EdgeInsets.only(bottom: 25),
                    color: Color.fromRGBO(243, 243, 243, 1),
                    child: GridView.builder(
                        itemCount: _books.length,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 490.w,
                              mainAxisExtent: 160.h,
                              crossAxisSpacing: 10.w,
                              mainAxisSpacing: 7.h,
                        ),
                        itemBuilder: ((context, i) {
                          final book = _books[i];
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                      width: 94.w,
                                      height: 120.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  margin: EdgeInsets.only(left: 40),
                                  child: Image.network(
                                    Api.image + book.image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  width:
                                      490.w * 0.6,
                                  height:
                                     980.h * 0.11,
                                  margin: EdgeInsets.only(left: 40),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'ID Peminjaman : ' + book.id.toString(),
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                              fontSize: 15.w,
                                          color: Color.fromRGBO(76, 81, 97, 1),
                                        ),
                                      ),
                                      Text(
                                        book.nama_buku,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-ExtraBold',
                                              fontSize: 20.w,
                                        ),
                                      ),
                                      Text(
                                        'Mulai : 07 September 2022',
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                              fontSize: 14.w,
                                          color: Color.fromRGBO(76, 81, 97, 78),
                                        ),
                                      ),
                                      Text(
                                        'Berakhir : 11 September 2022',
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                              fontSize: 14.w,
                                          color: Color.fromRGBO(76, 81, 97, 78),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            490.w *
                                                0.3,
                                        height:
                                           980.h *
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
                                                  fontSize: 13.w,
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
                        width: 490.w,
                        height: 980.h * 0.85,
                    padding: EdgeInsets.only(bottom: 25),
                    color: Color.fromRGBO(243, 243, 243, 1),
                    child: GridView.builder(
                        itemCount: _books.length,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 490.w,
                              mainAxisExtent: 221.h,
                              crossAxisSpacing: 10.w,
                              mainAxisSpacing: 7.h,
                        ),
                        itemBuilder: ((context, i) {
                          final book = _books[i];
                          return Container(
                                padding: EdgeInsets.symmetric(horizontal: 40.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                          width: 94.w,
                                          height: 120.h,
                                      child: Image.network(
                                        Api.image + book.image,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Container(
                                          width: 225.w,
                                          height: 122.h,
                                          margin: EdgeInsets.only(left: 40.w),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'ID Peminjaman : ' +
                                                book.id.toString(),
                                            style: TextStyle(
                                              fontFamily: 'Gilroy-Light',
                                                  fontSize: 15.w,
                                              color:
                                                  Color.fromRGBO(76, 81, 97, 1),
                                            ),
                                          ),
                                          Text(
                                            book.nama_buku,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontFamily: 'Gilroy-ExtraBold',
                                                  fontSize: 20.w,
                                            ),
                                          ),
                                          Text(
                                            'Mulai : 07 September 2022',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy-Light',
                                                  fontSize: 14.w,
                                              color: Color.fromRGBO(
                                                  76, 81, 97, 78),
                                            ),
                                          ),
                                          Text(
                                            'Berakhir : 11 September 2022',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy-Light',
                                                  fontSize: 14.w,
                                              color: Color.fromRGBO(
                                                  76, 81, 97, 78),
                                            ),
                                          ),
                                          Container(
                                                width: 490.w *
                                                0.24,
                                                height: 980.h *
                                                0.017,
                                            decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  255, 217, 102, 1),
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'Sedang Dipinjam',
                                                style: TextStyle(
                                                  fontFamily: 'Gilroy-Light',
                                                      fontSize: 13.w,
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                            width: 131.w,
                                            height: 36.h,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          color: Color.fromRGBO(242, 78, 26, 1),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Kembalikan',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy-ExtraBold',
                                                  fontSize: 15.w,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }))),
              ),
              SingleChildScrollView(
                child: Container(
                        width: 490.w,
                        height: 980.h * 0.85,
                    padding: EdgeInsets.only(bottom: 25),
                    color: Color.fromRGBO(243, 243, 243, 1),
                    child: GridView.builder(
                        itemCount: _books.length,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 490.w,
                              mainAxisExtent: 160.h,
                              mainAxisSpacing: 7.h,
                              crossAxisSpacing: 10.w,
                        ),
                        itemBuilder: ((context, i) {
                          final book = _books[i];
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                      width: 97.w,
                                      height: 120.h,
                                      margin: EdgeInsets.only(left: 40.w),
                                  child: Image.network(
                                    Api.image + book.image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  width:
                                      490.w * 0.6,
                                      height: 980.h *
                                      0.115,
                                      margin: EdgeInsets.only(left: 40.w),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'ID Peminjaman : ' + book.id.toString(),
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                              fontSize: 15.w,
                                          color: Color.fromRGBO(76, 81, 97, 1),
                                        ),
                                      ),
                                      Text(
                                        book.nama_buku,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-ExtraBold',
                                              fontSize: 20.w,
                                        ),
                                      ),
                                      Text(
                                        'Mulai : 07 September 2022',
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                              fontSize: 14.w,
                                          color: Color.fromRGBO(76, 81, 97, 78),
                                        ),
                                      ),
                                      Text(
                                        'Berakhir : 11 September 2022',
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                              fontSize: 14.w,
                                          color: Color.fromRGBO(76, 81, 97, 78),
                                        ),
                                      ),
                                      Text(
                                        'Jumlah Buku : ' + book.jumlah_buku,
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                              fontSize: 14.w,
                                          color: Color.fromRGBO(76, 81, 97, 78),
                                        ),
                                      ),
                                      Container(
                                            width: 94.w,
                                            height: 19.h,
                                        decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(217, 217, 217, 1),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Pengembalian',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy-Light',
                                                  fontSize: 13.w,
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
                        width: 490.w,
                        height: 980.h * 0.85,
                    padding: EdgeInsets.only(bottom: 25),
                    color: Color.fromRGBO(243, 243, 243, 1),
                    child: GridView.builder(
                        itemCount: _books.length,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 490.w,
                              mainAxisExtent: 175.h,
                              crossAxisSpacing: 10.w,
                              mainAxisSpacing: 7.h,
                        ),
                        itemBuilder: ((context, i) {
                          final book = _books[i];
                          return Container(
                                padding: EdgeInsets.symmetric(horizontal: 40.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                      width: 97.w,
                                      height: 120.h,
                                  child: Image.network(
                                    Api.image + book.image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  width:
                                      490.w * 0.55,
                                  height: 137,
                                  margin: EdgeInsets.only(left: 40),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'ID Peminjaman : ' + book.id.toString(),
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                              fontSize: 15.w,
                                          color: Color.fromRGBO(76, 81, 97, 1),
                                        ),
                                      ),
                                      Text(
                                        book.nama_buku,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-ExtraBold',
                                              fontSize: 20.w,
                                        ),
                                      ),
                                      Text(
                                        'Mulai : 07 September 2022',
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                              fontSize: 14.w,
                                          color: Color.fromRGBO(76, 81, 97, 78),
                                        ),
                                      ),
                                      Text(
                                        'Berakhir : 11 September 2022',
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                              fontSize: 14.w,
                                          color: Color.fromRGBO(76, 81, 97, 78),
                                        ),
                                      ),
                                      Text(
                                        'Dikembalikan : 11 September 2022',
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                              fontSize: 14.w,
                                          color: Color.fromRGBO(76, 81, 97, 78),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            490.w *
                                                0.24,
                                        height:
                                           980.h *
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
                                                  fontSize: 13.w,
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
                        width: 490.w,
                        height: 980.h * 0.85,
                    padding: EdgeInsets.only(bottom: 25),
                    color: Color.fromRGBO(243, 243, 243, 1),
                    child: GridView.builder(
                        itemCount: _books.length,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 490.w,
                              mainAxisExtent: 226.h,
                              mainAxisSpacing: 7.h,
                              crossAxisSpacing: 10.w,
                        ),
                        itemBuilder: ((context, i) {
                          final book = _books[i];
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
                                            width: 97.w,
                                            height: 120.h,
                                            margin: EdgeInsets.only(left: 40.w),
                                        child: Image.network(
                                          Api.image + book.image,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Container(
                                        width:
                                            490.w *
                                                0.6,
                                        height:
                                           980.h *
                                                0.115,
                                            margin: EdgeInsets.only(left: 40.w),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'ID Peminjaman : ' +
                                                  book.id.toString(),
                                              style: TextStyle(
                                                fontFamily: 'Gilroy-Light',
                                                    fontSize: 15.w,
                                                color: Color.fromRGBO(
                                                    76, 81, 97, 1),
                                              ),
                                            ),
                                            Text(
                                              book.nama_buku,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontFamily: 'Gilroy-ExtraBold',
                                                    fontSize: 20.w,
                                              ),
                                            ),
                                            Text(
                                              'Mulai : 07 September 2022',
                                              style: TextStyle(
                                                fontFamily: 'Gilroy-Light',
                                                    fontSize: 14.w,
                                                color: Color.fromRGBO(
                                                    76, 81, 97, 78),
                                              ),
                                            ),
                                            Text(
                                              'Berakhir : 11 September 2022',
                                              style: TextStyle(
                                                fontFamily: 'Gilroy-Light',
                                                    fontSize: 14.w,
                                                color: Color.fromRGBO(
                                                    76, 81, 97, 78),
                                              ),
                                            ),
                                            Text(
                                              'Dikembalikan : 12 September 2022',
                                              style: TextStyle(
                                                fontFamily: 'Gilroy-Light',
                                                    fontSize: 14.w,
                                                color: Color.fromRGBO(
                                                    76, 81, 97, 78),
                                              ),
                                            ),
                                            Container(
                                                  width: 490.w *
                                                  0.27,
                                                  height: 980.h *
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
                                                        fontSize: 13.w,
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
                                      490.w * 0.83,
                                  height:
                                     980.h * 0.07,
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
                                                  fontSize: 13.w,
                                              color:
                                                  Color.fromRGBO(76, 81, 97, 1),
                                            ),
                                          ),
                                          Text(
                                            '1 hari',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy-Light',
                                                  fontSize: 13.w,
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
                                                margin:
                                                    EdgeInsets.only(left: 80.w),
                                            child: Text(
                                              'Denda : ',
                                              style: TextStyle(
                                                fontFamily: 'Gilroy-Light',
                                                    fontSize: 13.w,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'Rp.5000',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy-Light',
                                                  fontSize: 13.w,
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
                        width: 490.w,
                        height: 980.h * 0.85,
                    padding: EdgeInsets.only(bottom: 25),
                    color: Color.fromRGBO(243, 243, 243, 1),
                    child: GridView.builder(
                        itemCount: _books.length,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 490.w,
                              mainAxisExtent: 220.h,
                              crossAxisSpacing: 10.w,
                              mainAxisSpacing: 7.h,
                        ),
                        itemBuilder: ((context, i) {
                          final book = _books[i];
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                      margin: EdgeInsets.only(top: 10.h),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                            width: 97.w,
                                            height: 120.h,
                                        margin: EdgeInsets.only(left: 40),
                                        child: Image.network(
                                          Api.image + book.image,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Container(
                                        width:
                                            490.w *
                                                0.6,
                                        height:
                                           980.h *
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
                                                  book.id.toString(),
                                              style: TextStyle(
                                                fontFamily: 'Gilroy-Light',
                                                    fontSize: 15.w,
                                                color: Color.fromRGBO(
                                                    76, 81, 97, 1),
                                              ),
                                            ),
                                            Text(
                                              book.nama_buku,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontFamily: 'Gilroy-ExtraBold',
                                                    fontSize: 20.w,
                                              ),
                                            ),
                                            Text(
                                              'Mulai : 07 September 2022',
                                              style: TextStyle(
                                                fontFamily: 'Gilroy-Light',
                                                    fontSize: 14.w,
                                                color: Color.fromRGBO(
                                                    76, 81, 97, 78),
                                              ),
                                            ),
                                            Text(
                                              'Berakhir : 11 September 2022',
                                              style: TextStyle(
                                                fontFamily: 'Gilroy-Light',
                                                    fontSize: 14.w,
                                                color: Color.fromRGBO(
                                                    76, 81, 97, 78),
                                              ),
                                            ),
                                            Container(
                                                  width: 490.w *
                                                  0.24,
                                                  height: 980.h *
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
                                                        fontSize: 13.w,
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
                                      490.w * 0.83,
                                  height:
                                     980.h * 0.07,
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                              margin:
                                                  EdgeInsets.only(left: 60.w),
                                          child: Text(
                                            'Denda : ',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy-Light',
                                                  fontSize: 13.w,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        Container(
                                              margin:
                                                  EdgeInsets.only(right: 60.w),
                                          child: Text(
                                            'Rp.50000',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy-Light',
                                                  fontSize: 13.w,
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
  
      },
    );
  }
}
