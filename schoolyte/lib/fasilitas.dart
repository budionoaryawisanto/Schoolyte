import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:schoolyte/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'model.dart';

class FasilitasPage extends StatefulWidget {
  @override
  _FasilitasPageState createState() => new _FasilitasPageState();
}

class _FasilitasPageState extends State<FasilitasPage> {
  List<Users> _list = [];
  List<Users> _search = [];
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
          _list.add(Users.formJson(i));
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
    Tab(text: 'Fasilitas'),
    Tab(text: 'Dipinjam'),
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

  showDialogFunc(context, a) {
    return showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Material(
              type: MaterialType.transparency,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 757,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 339,
                      height: 226,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: new Image.asset(
                        'assets/images/fasilitas.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      width: 261,
                      child: Center(
                        child: Text(
                          'Lapangan Depan',
                          style: TextStyle(
                            fontFamily: 'Gilroy-ExtraBold',
                            fontSize: 32,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 339,
                      height: 88,
                      child: Text(
                        'Lapangan ini terletak pada belakang gerbang pintu masuk. Lapangan ini dapat digunakan untuk permainan futsal dan basket. Ukuran lapangan ini adalah 12m * 12m.',
                        style: TextStyle(
                          fontFamily: 'Gilroy-Light',
                          fontSize: 15,
                          color: Color.fromRGBO(76, 81, 97, 1),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 0.5,
                          color: Color.fromRGBO(237, 237, 237, 1),
                        ),
                      ),
                    ),
                    Container(
                      width: 268,
                      height: 128,
                      margin: EdgeInsets.only(right: 50),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Jadwal Peminjaman',
                            style: TextStyle(
                              fontFamily: 'Gilroy-Light',
                              fontSize: 16,
                              color: Color.fromRGBO(119, 115, 205, 1),
                            ),
                          ),
                          Text(
                            'Lebih Nyaman & Teratur dalam Penjadwalan Peminjaman',
                            style: TextStyle(
                              fontFamily: 'Gilroy-ExtraBold',
                              fontSize: 24,
                              color: Color.fromRGBO(76, 81, 97, 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 356,
                      height: 61,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromRGBO(237, 237, 237, 1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Senin, 17 Oktober 2022',
                                  style: TextStyle(
                                    fontFamily: 'Gilroy-ExtraBold',
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  '13.30 - 15.30',
                                  style: TextStyle(
                                    fontFamily: 'Gilroy-Light',
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 14,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Color.fromRGBO(255, 217, 102, 0.38)),
                            child: Center(
                              child: Text(
                                'Oleh: ' + a.name,
                                style: TextStyle(
                                  fontFamily: 'Gilroy-Light',
                                  fontSize: 10,
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
              ),
            ),
          );
        });
  }

  showDialogFuncSearch(context, b) {
    return showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Material(
              type: MaterialType.transparency,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 757,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 339,
                      height: 226,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: new Image.asset(
                        'assets/images/fasilitas.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      width: 261,
                      child: Center(
                        child: Text(
                          'Lapangan Depan',
                          style: TextStyle(
                            fontFamily: 'Gilroy-ExtraBold',
                            fontSize: 32,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 339,
                      height: 88,
                      child: Text(
                        'Lapangan ini terletak pada belakang gerbang pintu masuk. Lapangan ini dapat digunakan untuk permainan futsal dan basket. Ukuran lapangan ini adalah 12m * 12m.',
                        style: TextStyle(
                          fontFamily: 'Gilroy-Light',
                          fontSize: 15,
                          color: Color.fromRGBO(76, 81, 97, 1),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 0.5,
                          color: Color.fromRGBO(237, 237, 237, 1),
                        ),
                      ),
                    ),
                    Container(
                      width: 268,
                      height: 128,
                      margin: EdgeInsets.only(right: 50),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Jadwal Peminjaman',
                            style: TextStyle(
                              fontFamily: 'Gilroy-Light',
                              fontSize: 16,
                              color: Color.fromRGBO(119, 115, 205, 1),
                            ),
                          ),
                          Text(
                            'Lebih Nyaman & Teratur dalam Penjadwalan Peminjaman',
                            style: TextStyle(
                              fontFamily: 'Gilroy-ExtraBold',
                              fontSize: 24,
                              color: Color.fromRGBO(76, 81, 97, 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 356,
                      height: 61,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromRGBO(237, 237, 237, 1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Senin, 17 Oktober 2022',
                                  style: TextStyle(
                                    fontFamily: 'Gilroy-ExtraBold',
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  '13.30 - 15.30',
                                  style: TextStyle(
                                    fontFamily: 'Gilroy-Light',
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 14,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Color.fromRGBO(255, 217, 102, 0.38)),
                            child: Center(
                              child: Text(
                                'Oleh: ' + b.name,
                                style: TextStyle(
                                  fontFamily: 'Gilroy-Light',
                                  fontSize: 10,
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
              ),
            ),
          );
        });
  }

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
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(138),
            child: AppBar(
              backgroundColor: Color.fromRGBO(119, 115, 205, 1),
              title: Align(
                alignment: Alignment(-0.7, 0.0),
                child: Text(
                  'Fasilitas',
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
                          fontFamily: 'Gilroy-Light',
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
                          fontFamily: 'Gilroy-ExtraBold',
                          fontSize: 14,
                          color: Color.fromRGBO(76, 81, 91, 1)),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/fasilitas', (Route<dynamic> route) => false);
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
          body: TabBarView(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: 419,
                        height: 50,
                        margin: EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(243, 243, 243, 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 350,
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
                                            maxCrossAxisExtent: 183,
                                            mainAxisExtent: 212,
                                            crossAxisSpacing: 23,
                                            mainAxisSpacing: 5,
                                          ),
                                          itemBuilder: (context, i) {
                                            final b = _search[i];
                                            return TextButton(
                                              onPressed: () {
                                                showDialogFuncSearch(
                                                    context, b);
                                              },
                                              child: Container(
                                                width: 182,
                                                height: 212,
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 12,
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
                                                      width: 162,
                                                      height: 108,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: new Image.asset(
                                                        'assets/images/fasilitas.png',
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 131,
                                                      child: Text(
                                                        'Lapangan Depan',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-ExtraBold',
                                                          fontSize: 16,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 162,
                                                      child: Text(
                                                        b.username +
                                                            b.name +
                                                            b.email +
                                                            b.website +
                                                            b.phone,
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-Light',
                                                          fontSize: 10,
                                                          color: Color.fromRGBO(
                                                              76, 81, 97, 1),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
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
                                            maxCrossAxisExtent: 183,
                                            mainAxisExtent: 212,
                                            crossAxisSpacing: 23,
                                            mainAxisSpacing: 5,
                                          ),
                                          itemBuilder: (context, i) {
                                            final a = _list[i];
                                            return TextButton(
                                              onPressed: () {
                                                showDialogFunc(context, a);
                                              },
                                              child: Container(
                                                width: 182,
                                                height: 212,
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 12,
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
                                                      width: 162,
                                                      height: 108,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: new Image.asset(
                                                        'assets/images/fasilitas.png',
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 131,
                                                      child: Text(
                                                        'Lapangan Depan',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-ExtraBold',
                                                          fontSize: 16,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 162,
                                                      child: Text(
                                                        a.username +
                                                            a.name +
                                                            a.email +
                                                            a.website +
                                                            a.phone,
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-Light',
                                                          fontSize: 10,
                                                          color: Color.fromRGBO(
                                                              76, 81, 97, 1),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
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
                    height: MediaQuery.of(context).size.height,
                    padding: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(243, 243, 243, 1),
                    ),
                    child: GridView.builder(
                        itemCount: _list.length,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 491,
                          mainAxisExtent: 141,
                          mainAxisSpacing: 10,
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
                                  width: 155,
                                  height: 103,
                                  margin: EdgeInsets.only(left: 40),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Image.asset(
                                    'assets/images/fasilitas.png',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Container(
                                  width: 177,
                                  height: 94,
                                  margin: EdgeInsets.only(left: 10),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Lapangan Depan',
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-ExtraBold',
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text(
                                        'Selasa, 18 Oktober 2022',
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        '13.30 - 15.00',
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                          fontSize: 14,
                                        ),
                                      ),
                                      Container(
                                        width: a.id % 2 == 0 ? 114 : 53,
                                        height: 19,
                                        decoration: BoxDecoration(
                                          color: a.id % 2 == 0
                                              ? Color.fromRGBO(255, 217, 102, 1)
                                              : Color.fromRGBO(
                                                  217, 217, 217, 1),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Center(
                                          child: Text(
                                            a.id % 2 == 0
                                                ? 'Sedang Dipinjam'
                                                : 'Selesai',
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
            ],
          ),
        ),
      ),
    );
  }
}
