import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:schoolyte/laporanKeuangan.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'fasilitas.dart';
import 'model.dart';
import 'package:schoolyte/absensi.dart';
import 'package:schoolyte/berita.dart';
import 'package:schoolyte/jadwal.dart';
import 'package:schoolyte/nilaiBelajar.dart';
import 'package:schoolyte/perpustakaan.dart';
import 'package:schoolyte/rapor.dart';
import 'package:schoolyte/kantin.dart';
import 'package:schoolyte/home.dart';
import 'osis.dart';
import 'pembayaranKoperasi.dart';
import 'ekstrakurikuler.dart';
import 'profil.dart';
import 'administrasi.dart';

class KoperasiPage extends StatefulWidget {
  @override
  _KoperasiPageState createState() => new _KoperasiPageState();
}

class _KoperasiPageState extends State<KoperasiPage> {
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

  var count = 0;

  List<Tab> myTabs = <Tab>[
    Tab(text: 'Produk'),
    Tab(text: 'Pesanan Saya'),
    Tab(text: 'Selesai'),
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
        statusBarColor: Color.fromRGBO(255, 204, 47, 1),
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
          backgroundColor: Color.fromRGBO(247, 247, 247, 1),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(138),
            child: AppBar(
              backgroundColor: Color.fromRGBO(255, 204, 47, 1),
              title: Align(
                alignment: Alignment(-0.7, 0.0),
                child: Text(
                  'Koperasi',
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
                isScrollable: true,
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
                          fontFamily: 'Gilroy-ExtraBold',
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
          body: TabBarView(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.07,
                        margin: EdgeInsets.only(top: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
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
                                width:
                                    MediaQuery.of(context).size.width * 0.306,
                                height:
                                    MediaQuery.of(context).size.height * 0.047,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Saldo',
                                      style: TextStyle(
                                        fontFamily: 'Gilroy-Light',
                                        fontSize: 14,
                                        color: Color.fromRGBO(76, 81, 97, 1),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(right: 5),
                                          child: Icon(
                                            Icons.wallet_outlined,
                                            color:
                                                Color.fromRGBO(255, 199, 0, 1),
                                          ),
                                        ),
                                        Text(
                                          status.toLowerCase() == 'admin'
                                              ? '-'
                                              : loadingUser
                                                  ? '--'
                                                  : convertToIdr(
                                                      int.parse(profil.saldo),
                                                      0),
                                          style: TextStyle(
                                            fontFamily: 'Gilroy-ExtraBold',
                                            fontSize: 16,
                                            color:
                                                Color.fromRGBO(76, 81, 97, 1),
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
                                width:
                                    MediaQuery.of(context).size.width * 0.142,
                                height:
                                    MediaQuery.of(context).size.height * 0.047,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.add_box_rounded,
                                      color: Color.fromRGBO(255, 199, 0, 1),
                                      size: 21,
                                    ),
                                    Text(
                                      'Top Up',
                                      style: TextStyle(
                                        fontFamily: 'Gilroy-ExtraBold',
                                        fontSize: 16,
                                        color: Color.fromRGBO(76, 81, 97, 1),
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
                                width:
                                    MediaQuery.of(context).size.width * 0.142,
                                height:
                                    MediaQuery.of(context).size.height * 0.047,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.ios_share_outlined,
                                      color: Color.fromRGBO(255, 199, 0, 1),
                                      size: 21,
                                    ),
                                    Text(
                                      'Tarik',
                                      style: TextStyle(
                                        fontFamily: 'Gilroy-ExtraBold',
                                        fontSize: 16,
                                        color: Color.fromRGBO(76, 81, 97, 1),
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
                        width: MediaQuery.of(context).size.width * 0.84,
                        margin: EdgeInsets.only(top: 20),
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.71,
                              height: 46,
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
                                    hintText: 'Mau cari produk apa hari ini?',
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
                          height: count > 0
                              ? MediaQuery.of(context).size.height * 0.58
                              : MediaQuery.of(context).size.height * 0.65,
                          margin: EdgeInsets.symmetric(vertical: 20),
                          child: loading
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : _search.length != 0 ||
                                      searchController.text.isNotEmpty
                                  ? Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: GridView.builder(
                                          itemCount: _search.length,
                                          padding: EdgeInsets.all(10),
                                          gridDelegate:
                                              SliverGridDelegateWithMaxCrossAxisExtent(
                                            maxCrossAxisExtent:
                                                MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.44,
                                            mainAxisExtent:
                                                MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.2,
                                            crossAxisSpacing: 10,
                                            mainAxisSpacing: 10,
                                          ),
                                          itemBuilder: (context, i) {
                                            final b = _search[i];
                                            return Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 10,
                                                vertical: 10,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
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
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: new Image.asset(
                                                      'assets/images/pensil.png',
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        child: Text(
                                                          'Pensil',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-ExtraBold',
                                                            fontSize: 16,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        'Rp.10000',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-Light',
                                                          fontSize: 12,
                                                          color: Color.fromRGBO(
                                                              242, 78, 26, 1),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Tersedia : ' +
                                                            b.id.toString(),
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-Light',
                                                          fontSize: 11,
                                                          color: Color.fromRGBO(
                                                              76, 81, 97, 1),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.15,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.024,
                                                        margin: EdgeInsets.only(
                                                            left: 20),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () =>
                                                                  setState(() {
                                                                count != 0
                                                                    ? count--
                                                                    : null;
                                                              }),
                                                              child: Container(
                                                                width: 20,
                                                                height: 20,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              180),
                                                                  border: Border
                                                                      .all(
                                                                    width: 1,
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            76,
                                                                            81,
                                                                            97,
                                                                            1),
                                                                  ),
                                                                ),
                                                                child: Center(
                                                                  child: Icon(
                                                                    Icons
                                                                        .remove,
                                                                    size: 16,
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            76,
                                                                            81,
                                                                            97,
                                                                            1),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Text(
                                                              count.toString(),
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Gilroy-Light',
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () =>
                                                                  setState(() {
                                                                count++;
                                                              }),
                                                              child: Container(
                                                                width: 20,
                                                                height: 20,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              180),
                                                                  border: Border
                                                                      .all(
                                                                    width: 1,
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            76,
                                                                            81,
                                                                            97,
                                                                            1),
                                                                  ),
                                                                ),
                                                                child: Center(
                                                                  child: Icon(
                                                                    Icons.add,
                                                                    size: 16,
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            76,
                                                                            81,
                                                                            97,
                                                                            1),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          }),
                                    )
                                  : Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: GridView.builder(
                                          itemCount: _list.length,
                                          padding: EdgeInsets.all(10),
                                          gridDelegate:
                                              SliverGridDelegateWithMaxCrossAxisExtent(
                                            maxCrossAxisExtent:
                                                MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.44,
                                            mainAxisExtent:
                                                MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.2,
                                            crossAxisSpacing: 10,
                                            mainAxisSpacing: 10,
                                          ),
                                          itemBuilder: (context, i) {
                                            final a = _list[i];
                                            return Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 10,
                                                vertical: 10,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
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
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: new Image.asset(
                                                      'assets/images/pensil.png',
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        child: Text(
                                                          'Pensil',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-ExtraBold',
                                                            fontSize: 16,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        'Rp.10000',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-Light',
                                                          fontSize: 12,
                                                          color: Color.fromRGBO(
                                                              242, 78, 26, 1),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Tersedia : ' +
                                                            a.id.toString(),
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-Light',
                                                          fontSize: 11,
                                                          color: Color.fromRGBO(
                                                              76, 81, 97, 1),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.15,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.024,
                                                        margin: EdgeInsets.only(
                                                            left: 20),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () =>
                                                                  setState(() {
                                                                count != 0
                                                                    ? count--
                                                                    : null;
                                                              }),
                                                              child: Container(
                                                                width: 20,
                                                                height: 20,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              180),
                                                                  border: Border
                                                                      .all(
                                                                    width: 1,
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            76,
                                                                            81,
                                                                            97,
                                                                            1),
                                                                  ),
                                                                ),
                                                                child: Center(
                                                                  child: Icon(
                                                                    Icons
                                                                        .remove,
                                                                    size: 16,
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            76,
                                                                            81,
                                                                            97,
                                                                            1),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Text(
                                                              count.toString(),
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Gilroy-Light',
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () =>
                                                                  setState(() {
                                                                count++;
                                                              }),
                                                              child: Container(
                                                                width: 20,
                                                                height: 20,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              180),
                                                                  border: Border
                                                                      .all(
                                                                    width: 1,
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            76,
                                                                            81,
                                                                            97,
                                                                            1),
                                                                  ),
                                                                ),
                                                                child: Center(
                                                                  child: Icon(
                                                                    Icons.add,
                                                                    size: 16,
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            76,
                                                                            81,
                                                                            97,
                                                                            1),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          }),
                                    ),
                        ),
                      ),
                      Visibility(
                        visible: count > 0 ? true : false,
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PembayaranKoperasi())),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.89,
                            height: 43,
                            padding: EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 20,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromRGBO(255, 199, 0, 1),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '3 item',
                                      style: TextStyle(
                                        fontFamily: 'Gilroy-Light',
                                        fontSize: 10,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      'Total Bayar',
                                      style: TextStyle(
                                        fontFamily: 'Gilroy-ExtraBold',
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Rp.30.000',
                                      style: TextStyle(
                                        fontFamily: 'Gilroy-ExtraBold',
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 5),
                                      child: Icon(
                                        Icons.shopping_bag,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
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
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.85,
                padding: EdgeInsets.all(10),
                child: GridView.builder(
                  itemCount: _list.length,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: MediaQuery.of(context).size.width,
                    mainAxisExtent: 262,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, i) {
                    final pesanan = _list[i];
                    return Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 0,
                            blurRadius: 1.5,
                            offset: Offset(0, 0),
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'No. Pesanan',
                                style: TextStyle(
                                  fontFamily: 'Gilroy-ExtraBold',
                                  fontSize: 13,
                                  color: Color.fromRGBO(76, 81, 97, 1),
                                ),
                              ),
                              Text(
                                pesanan.id.toString(),
                                style: TextStyle(
                                  fontFamily: 'Gilroy-Light',
                                  fontSize: 13,
                                  color: Color.fromRGBO(76, 81, 97, 1),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Waktu Pemesanan',
                                style: TextStyle(
                                  fontFamily: 'Gilroy-Light',
                                  fontSize: 13,
                                  color: Color.fromRGBO(76, 81, 97, 1),
                                ),
                              ),
                              Text(
                                'Senin, 11 Januari 2023',
                                style: TextStyle(
                                  fontFamily: 'Gilroy-Light',
                                  fontSize: 13,
                                  color: Color.fromRGBO(76, 81, 97, 1),
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            color: Color.fromRGBO(76, 81, 97, 1),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 80,
                            child: GridView.builder(
                              itemCount: 6,
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent:
                                    MediaQuery.of(context).size.width,
                                mainAxisExtent: 20,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                              ),
                              itemBuilder: (context, i) {
                                return Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(right: 5),
                                            child: Text(
                                              '1X',
                                              style: TextStyle(
                                                fontFamily: 'Gilroy-Extrabold',
                                                fontSize: 14,
                                                color: Color.fromRGBO(
                                                    242, 78, 26, 1),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'Pensil',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy-Extrabold',
                                              fontSize: 16,
                                              color:
                                                  Color.fromRGBO(76, 81, 97, 1),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        'Rp.10.000',
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Extrabold',
                                          fontSize: 16,
                                          color: Color.fromRGBO(242, 78, 26, 1),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          Divider(
                            color: Color.fromRGBO(76, 81, 97, 1),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Total Pembayaran',
                                style: TextStyle(
                                  fontFamily: 'Gilroy-Extrabold',
                                  fontSize: 16,
                                  color: Color.fromRGBO(76, 81, 97, 1),
                                ),
                              ),
                              Text(
                                'Rp.30.000',
                                style: TextStyle(
                                  fontFamily: 'Gilroy-Extrabold',
                                  fontSize: 16,
                                  color: Color.fromRGBO(242, 78, 26, 1),
                                ),
                              ),
                            ],
                          ),
                          Visibility(
                            visible: pesanan.id == 2 || pesanan.id == 4
                                ? false
                                : true,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                  width: 119,
                                  height: 36,
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: Color.fromRGBO(242, 78, 26, 1),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Selesai',
                                      style: TextStyle(
                                        fontFamily: 'Gilroy-ExtraBold',
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
                  },
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.85,
                padding: EdgeInsets.all(10),
                child: GridView.builder(
                  itemCount: _list.length,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: MediaQuery.of(context).size.width,
                    mainAxisExtent: 240,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, i) {
                    final pesanan = _list[i];
                    return Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 0,
                            blurRadius: 1.5,
                            offset: Offset(0, 0),
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'No. Pesanan',
                                style: TextStyle(
                                  fontFamily: 'Gilroy-ExtraBold',
                                  fontSize: 13,
                                  color: Color.fromRGBO(76, 81, 97, 1),
                                ),
                              ),
                              Text(
                                pesanan.id.toString(),
                                style: TextStyle(
                                  fontFamily: 'Gilroy-Light',
                                  fontSize: 13,
                                  color: Color.fromRGBO(76, 81, 97, 1),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Waktu Pemesanan',
                                style: TextStyle(
                                  fontFamily: 'Gilroy-Light',
                                  fontSize: 13,
                                  color: Color.fromRGBO(76, 81, 97, 1),
                                ),
                              ),
                              Text(
                                'Senin, 11 Januari 2023',
                                style: TextStyle(
                                  fontFamily: 'Gilroy-Light',
                                  fontSize: 13,
                                  color: Color.fromRGBO(76, 81, 97, 1),
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            color: Color.fromRGBO(76, 81, 97, 1),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 80,
                            child: GridView.builder(
                              itemCount: 6,
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent:
                                    MediaQuery.of(context).size.width,
                                mainAxisExtent: 20,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                              ),
                              itemBuilder: (context, i) {
                                return Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(right: 5),
                                            child: Text(
                                              '1X',
                                              style: TextStyle(
                                                fontFamily: 'Gilroy-Extrabold',
                                                fontSize: 14,
                                                color: Color.fromRGBO(
                                                    242, 78, 26, 1),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'Pensil',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy-Extrabold',
                                              fontSize: 16,
                                              color:
                                                  Color.fromRGBO(76, 81, 97, 1),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        'Rp.10.000',
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Extrabold',
                                          fontSize: 16,
                                          color: Color.fromRGBO(242, 78, 26, 1),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          Divider(
                            color: Color.fromRGBO(76, 81, 97, 1),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Total Pembayaran',
                                style: TextStyle(
                                  fontFamily: 'Gilroy-Extrabold',
                                  fontSize: 16,
                                  color: Color.fromRGBO(76, 81, 97, 1),
                                ),
                              ),
                              Text(
                                'Rp.30.000',
                                style: TextStyle(
                                  fontFamily: 'Gilroy-Extrabold',
                                  fontSize: 16,
                                  color: Color.fromRGBO(242, 78, 26, 1),
                                ),
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              width: 130,
                              height: 24,
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Color.fromRGBO(243, 243, 243, 1),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.wallet,
                                      size: 18,
                                      color: Color.fromRGBO(76, 81, 97, 1),
                                    ),
                                    Text(
                                      '-Rp. 300.000',
                                      style: TextStyle(
                                        fontFamily: 'Gilroy-ExtraBold',
                                        fontSize: 16,
                                        color: Color.fromRGBO(242, 78, 26, 1),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
      ),
    );
  }
}
