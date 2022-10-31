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

class KantinPage extends StatefulWidget {
  @override
  _KantinPageState createState() => new _KantinPageState();
}

class _KantinPageState extends State<KantinPage> {
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
    Tab(text: 'Menu'),
    Tab(text: 'Pesanan'),
    Tab(text: 'Riwayat'),
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
          e.id.toString().contains(text)) {
        _search.add(e);
      }
    });
  }

  var count = 0;
  refresh() {
    setState(() {});
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
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(138),
            child: AppBar(
              backgroundColor: Color.fromRGBO(119, 115, 205, 1),
              title: Align(
                alignment: Alignment(-0.7, 0.0),
                child: Text(
                  'Kantin',
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
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/nilaiBelajar', (Route<dynamic> route) => false);
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
                          fontFamily: 'Gilroy-ExtraBold',
                          fontSize: 14,
                          color: Color.fromRGBO(76, 81, 91, 1)),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/kantin', (Route<dynamic> route) => false);
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
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/berita', (Route<dynamic> route) => false);
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
                child: Column(
                  children: [
                    Container(
                      width: 135,
                      height: 46,
                      margin: EdgeInsets.only(
                        top: 10,
                        right: 280,
                      ),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 0,
                            blurRadius: 1.5,
                            offset: Offset(0, 0),
                          )
                        ],
                        color: Color.fromRGBO(243, 243, 243, 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Icon(
                              Icons.wallet,
                              size: 20,
                              color: Color.fromRGBO(98, 103, 117, 1),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(
                              'Rp.100.000',
                              style: TextStyle(
                                fontFamily: 'Gilroy-ExtraBold',
                                fontSize: 16,
                                color: Color.fromRGBO(76, 81, 97, 0.54),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
                                  hintText: 'Mau makan apa hari ini?',
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
                        height: MediaQuery.of(context).size.height * 0.66,
                        margin: EdgeInsets.all(20),
                        child: loading
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
                                      maxCrossAxisExtent: 140,
                                      mainAxisExtent: 275,
                                      crossAxisSpacing: 5,
                                      mainAxisSpacing: 5,
                                    ),
                                    itemBuilder: (context, i) {
                                      final b = _search[i];
                                      return TextButton(
                                        onPressed: () {
                                          showModalBottomSheet<void>(
                                            isScrollControlled: true,
                                            enableDrag: false,
                                            isDismissible: false,
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.97,
                                                color: Colors.white,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.9,
                                                      height: 50,
                                                      margin: EdgeInsets.only(
                                                          top: 20),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Icon(
                                                              Icons
                                                                  .chevron_left,
                                                              color:
                                                                  Colors.black,
                                                              size: 40,
                                                            ),
                                                          ),
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                'Dapur ' +
                                                                    b.name +
                                                                    ', Kode: ' +
                                                                    b.id.toString(),
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-ExtraBold',
                                                                  fontSize: 20,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                              Text(
                                                                'Makanan, Minuman, Gorengan, Snack',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-Light',
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .black,
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
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.85,
                                                      child:
                                                          SingleChildScrollView(
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              width: 150,
                                                              height: 29,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                top: 25,
                                                                left: 65,
                                                              ),
                                                              child: Text(
                                                                'Makanan',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-ExtraBold',
                                                                  fontSize: 20,
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                              height: 250,
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                horizontal: 20,
                                                                vertical: 5,
                                                              ),
                                                              child: loading
                                                                  ? Center(
                                                                      child:
                                                                          CircularProgressIndicator(),
                                                                    )
                                                                  : GridView
                                                                      .builder(
                                                                      itemCount:
                                                                          6,
                                                                      gridDelegate:
                                                                          SliverGridDelegateWithMaxCrossAxisExtent(
                                                                        maxCrossAxisExtent:
                                                                            217,
                                                                        mainAxisExtent:
                                                                            116,
                                                                        mainAxisSpacing:
                                                                            5,
                                                                        crossAxisSpacing:
                                                                            10,
                                                                      ),
                                                                      itemBuilder:
                                                                          (context,
                                                                              i) {
                                                                        return Container(
                                                                          margin:
                                                                              EdgeInsets.all(5),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            boxShadow: [
                                                                              BoxShadow(
                                                                                color: Colors.black.withOpacity(0.3),
                                                                                spreadRadius: 0,
                                                                                blurRadius: 1.5,
                                                                                offset: Offset(0, 0),
                                                                              )
                                                                            ],
                                                                            color:
                                                                                Colors.white,
                                                                            borderRadius:
                                                                                BorderRadius.circular(7),
                                                                          ),
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              Container(
                                                                                width: 89,
                                                                                height: 97,
                                                                                margin: EdgeInsets.only(left: 10),
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(5),
                                                                                ),
                                                                                child: new Image.asset(
                                                                                  'assets/images/mieayam.png',
                                                                                  fit: BoxFit.fill,
                                                                                ),
                                                                              ),
                                                                              Column(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                children: [
                                                                                  Container(
                                                                                    width: 80,
                                                                                    margin: EdgeInsets.only(left: 15),
                                                                                    child: Text(
                                                                                      'Mie Ayam',
                                                                                      maxLines: 2,
                                                                                      overflow: TextOverflow.ellipsis,
                                                                                      style: TextStyle(
                                                                                        fontFamily: 'Gilroy-ExtraBold',
                                                                                        fontSize: 13,
                                                                                        color: Colors.black,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    width: 80,
                                                                                    margin: EdgeInsets.only(left: 15),
                                                                                    child: Text(
                                                                                      'Rp.10.000',
                                                                                      maxLines: 2,
                                                                                      overflow: TextOverflow.ellipsis,
                                                                                      style: TextStyle(
                                                                                        fontFamily: 'Gilroy-Light',
                                                                                        fontSize: 10,
                                                                                        color: Color.fromRGBO(76, 81, 97, 1),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    width: 90,
                                                                                    child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                                      children: [
                                                                                        SizedBox(
                                                                                          width: 40,
                                                                                          height: 40,
                                                                                          child: TextButton(
                                                                                            onPressed: () {
                                                                                              setState(() {
                                                                                                if (count != 0) {
                                                                                                  count--;
                                                                                                } else {}
                                                                                              });
                                                                                            },
                                                                                            child: Container(
                                                                                              width: 20,
                                                                                              height: 20,
                                                                                              decoration: BoxDecoration(
                                                                                                border: Border.all(
                                                                                                  width: 1,
                                                                                                  color: Colors.black,
                                                                                                ),
                                                                                              ),
                                                                                              child: Center(
                                                                                                child: Icon(
                                                                                                  Icons.remove,
                                                                                                  color: Colors.black,
                                                                                                  size: 18,
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        Container(
                                                                                          child: Text(
                                                                                            count.toString(),
                                                                                            style: TextStyle(
                                                                                              fontFamily: 'Gilroy-ExtraBold',
                                                                                              fontSize: 14,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        SizedBox(
                                                                                          width: 40,
                                                                                          height: 40,
                                                                                          child: TextButton(
                                                                                            onPressed: () {
                                                                                              setState(() {
                                                                                                count++;
                                                                                              });
                                                                                              refresh();
                                                                                            },
                                                                                            child: Container(
                                                                                              width: 20,
                                                                                              height: 20,
                                                                                              decoration: BoxDecoration(
                                                                                                border: Border.all(
                                                                                                  width: 1,
                                                                                                  color: Colors.black,
                                                                                                ),
                                                                                              ),
                                                                                              child: Center(
                                                                                                child: Icon(
                                                                                                  Icons.add,
                                                                                                  color: Colors.black,
                                                                                                  size: 18,
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
                                                                            ],
                                                                          ),
                                                                        );
                                                                      },
                                                                    ),
                                                            ),
                                                            Container(
                                                              width: 150,
                                                              height: 29,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                top: 25,
                                                                left: 65,
                                                              ),
                                                              child: Text(
                                                                'Minuman',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-ExtraBold',
                                                                  fontSize: 20,
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                              height: 250,
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                horizontal: 20,
                                                                vertical: 5,
                                                              ),
                                                              child: loading
                                                                  ? Center(
                                                                      child:
                                                                          CircularProgressIndicator(),
                                                                    )
                                                                  : GridView
                                                                      .builder(
                                                                      itemCount:
                                                                          6,
                                                                      gridDelegate:
                                                                          SliverGridDelegateWithMaxCrossAxisExtent(
                                                                        maxCrossAxisExtent:
                                                                            217,
                                                                        mainAxisExtent:
                                                                            116,
                                                                        mainAxisSpacing:
                                                                            5,
                                                                        crossAxisSpacing:
                                                                            10,
                                                                      ),
                                                                      itemBuilder:
                                                                          (context,
                                                                              i) {
                                                                        return Container(
                                                                          margin:
                                                                              EdgeInsets.all(5),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            boxShadow: [
                                                                              BoxShadow(
                                                                                color: Colors.black.withOpacity(0.3),
                                                                                spreadRadius: 0,
                                                                                blurRadius: 1.5,
                                                                                offset: Offset(0, 0),
                                                                              )
                                                                            ],
                                                                            color:
                                                                                Colors.white,
                                                                            borderRadius:
                                                                                BorderRadius.circular(7),
                                                                          ),
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              Container(
                                                                                width: 89,
                                                                                height: 97,
                                                                                margin: EdgeInsets.only(left: 10),
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(5),
                                                                                ),
                                                                                child: new Image.asset(
                                                                                  'assets/images/esteh.png',
                                                                                  fit: BoxFit.fill,
                                                                                ),
                                                                              ),
                                                                              Column(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                children: [
                                                                                  Container(
                                                                                    width: 80,
                                                                                    margin: EdgeInsets.only(left: 15),
                                                                                    child: Text(
                                                                                      'Es Teh',
                                                                                      maxLines: 2,
                                                                                      overflow: TextOverflow.ellipsis,
                                                                                      style: TextStyle(
                                                                                        fontFamily: 'Gilroy-ExtraBold',
                                                                                        fontSize: 13,
                                                                                        color: Colors.black,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    width: 80,
                                                                                    margin: EdgeInsets.only(left: 15),
                                                                                    child: Text(
                                                                                      'Rp.3.000',
                                                                                      maxLines: 2,
                                                                                      overflow: TextOverflow.ellipsis,
                                                                                      style: TextStyle(
                                                                                        fontFamily: 'Gilroy-Light',
                                                                                        fontSize: 10,
                                                                                        color: Color.fromRGBO(76, 81, 97, 1),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    width: 90,
                                                                                    child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                                      children: [
                                                                                        SizedBox(
                                                                                          width: 40,
                                                                                          height: 40,
                                                                                          child: TextButton(
                                                                                            onPressed: () {
                                                                                              setState(() {
                                                                                                if (count != 0) {
                                                                                                  count--;
                                                                                                } else {}
                                                                                              });
                                                                                            },
                                                                                            child: Container(
                                                                                              width: 20,
                                                                                              height: 20,
                                                                                              decoration: BoxDecoration(
                                                                                                border: Border.all(
                                                                                                  width: 1,
                                                                                                  color: Colors.black,
                                                                                                ),
                                                                                              ),
                                                                                              child: Center(
                                                                                                child: Icon(
                                                                                                  Icons.remove,
                                                                                                  color: Colors.black,
                                                                                                  size: 18,
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        Container(
                                                                                          child: Text(
                                                                                            count.toString(),
                                                                                            style: TextStyle(
                                                                                              fontFamily: 'Gilroy-ExtraBold',
                                                                                              fontSize: 14,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        SizedBox(
                                                                                          width: 40,
                                                                                          height: 40,
                                                                                          child: TextButton(
                                                                                            onPressed: () {
                                                                                              setState(() {
                                                                                                count++;
                                                                                              });
                                                                                              refresh();
                                                                                            },
                                                                                            child: Container(
                                                                                              width: 20,
                                                                                              height: 20,
                                                                                              decoration: BoxDecoration(
                                                                                                border: Border.all(
                                                                                                  width: 1,
                                                                                                  color: Colors.black,
                                                                                                ),
                                                                                              ),
                                                                                              child: Center(
                                                                                                child: Icon(
                                                                                                  Icons.add,
                                                                                                  color: Colors.black,
                                                                                                  size: 18,
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
                                                                            ],
                                                                          ),
                                                                        );
                                                                      },
                                                                    ),
                                                            ),
                                                            Container(
                                                              width: 150,
                                                              height: 29,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                top: 25,
                                                                left: 65,
                                                              ),
                                                              child: Text(
                                                                'Jajanan',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-ExtraBold',
                                                                  fontSize: 20,
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                              height: 250,
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                horizontal: 20,
                                                                vertical: 5,
                                                              ),
                                                              child: loading
                                                                  ? Center(
                                                                      child:
                                                                          CircularProgressIndicator(),
                                                                    )
                                                                  : GridView
                                                                      .builder(
                                                                      itemCount:
                                                                          6,
                                                                      gridDelegate:
                                                                          SliverGridDelegateWithMaxCrossAxisExtent(
                                                                        maxCrossAxisExtent:
                                                                            217,
                                                                        mainAxisExtent:
                                                                            116,
                                                                        mainAxisSpacing:
                                                                            5,
                                                                        crossAxisSpacing:
                                                                            10,
                                                                      ),
                                                                      itemBuilder:
                                                                          (context,
                                                                              i) {
                                                                        return Container(
                                                                          margin:
                                                                              EdgeInsets.all(5),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            boxShadow: [
                                                                              BoxShadow(
                                                                                color: Colors.black.withOpacity(0.3),
                                                                                spreadRadius: 0,
                                                                                blurRadius: 1.5,
                                                                                offset: Offset(0, 0),
                                                                              )
                                                                            ],
                                                                            color:
                                                                                Colors.white,
                                                                            borderRadius:
                                                                                BorderRadius.circular(7),
                                                                          ),
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              Container(
                                                                                width: 89,
                                                                                height: 97,
                                                                                margin: EdgeInsets.only(left: 10),
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(5),
                                                                                ),
                                                                                child: new Image.asset(
                                                                                  'assets/images/mieayam.png',
                                                                                  fit: BoxFit.fill,
                                                                                ),
                                                                              ),
                                                                              Column(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                children: [
                                                                                  Container(
                                                                                    width: 80,
                                                                                    margin: EdgeInsets.only(left: 15),
                                                                                    child: Text(
                                                                                      'Tahu Isi',
                                                                                      maxLines: 2,
                                                                                      overflow: TextOverflow.ellipsis,
                                                                                      style: TextStyle(
                                                                                        fontFamily: 'Gilroy-ExtraBold',
                                                                                        fontSize: 13,
                                                                                        color: Colors.black,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    width: 80,
                                                                                    margin: EdgeInsets.only(left: 15),
                                                                                    child: Text(
                                                                                      'Rp.2.000',
                                                                                      maxLines: 2,
                                                                                      overflow: TextOverflow.ellipsis,
                                                                                      style: TextStyle(
                                                                                        fontFamily: 'Gilroy-Light',
                                                                                        fontSize: 10,
                                                                                        color: Color.fromRGBO(76, 81, 97, 1),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    width: 90,
                                                                                    child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                                      children: [
                                                                                        SizedBox(
                                                                                          width: 40,
                                                                                          height: 40,
                                                                                          child: TextButton(
                                                                                            onPressed: () {
                                                                                              setState(() {
                                                                                                if (count != 0) {
                                                                                                  count--;
                                                                                                } else {}
                                                                                              });
                                                                                            },
                                                                                            child: Container(
                                                                                              width: 20,
                                                                                              height: 20,
                                                                                              decoration: BoxDecoration(
                                                                                                border: Border.all(
                                                                                                  width: 1,
                                                                                                  color: Colors.black,
                                                                                                ),
                                                                                              ),
                                                                                              child: Center(
                                                                                                child: Icon(
                                                                                                  Icons.remove,
                                                                                                  color: Colors.black,
                                                                                                  size: 18,
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        Container(
                                                                                          child: Text(
                                                                                            count.toString(),
                                                                                            style: TextStyle(
                                                                                              fontFamily: 'Gilroy-ExtraBold',
                                                                                              fontSize: 14,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        SizedBox(
                                                                                          width: 40,
                                                                                          height: 40,
                                                                                          child: TextButton(
                                                                                            onPressed: () {
                                                                                              setState(() {
                                                                                                count++;
                                                                                              });
                                                                                              refresh();
                                                                                            },
                                                                                            child: Container(
                                                                                              width: 20,
                                                                                              height: 20,
                                                                                              decoration: BoxDecoration(
                                                                                                border: Border.all(
                                                                                                  width: 1,
                                                                                                  color: Colors.black,
                                                                                                ),
                                                                                              ),
                                                                                              child: Center(
                                                                                                child: Icon(
                                                                                                  Icons.add,
                                                                                                  color: Colors.black,
                                                                                                  size: 18,
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
                                                    Align(
                                                      alignment:
                                                          Alignment(0.0, 1.0),
                                                      child: Visibility(
                                                        visible: count > 0
                                                            ? true
                                                            : false,
                                                        child: Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.8,
                                                          height: 41,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color:
                                                                Color.fromRGBO(
                                                                    119,
                                                                    115,
                                                                    205,
                                                                    1),
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
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 119,
                                                height: 161,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: new Image.asset(
                                                  'assets/images/menu.png',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Container(
                                                width: 114,
                                                child: Text(
                                                  'Dapur ' + b.name,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontFamily:
                                                        'Gilroy-ExtraBold',
                                                    fontSize: 13,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: 114,
                                                child: Text(
                                                  'Kode: ' + b.id.toString(),
                                                  style: TextStyle(
                                                    fontFamily: 'Gilroy-Light',
                                                    fontSize: 10,
                                                    color: Color.fromRGBO(
                                                        76, 81, 97, 1),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: 114,
                                                child: Text(
                                                  'Makanan, Minuman, Gorengan, Snack',
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontFamily: 'Gilroy-Light',
                                                    fontSize: 10,
                                                    color: Color.fromRGBO(
                                                        76, 81, 97, 1),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: 31,
                                                height: 15,
                                                decoration: BoxDecoration(
                                                  color: b.id % 2 == 0
                                                      ? Color.fromRGBO(
                                                          255, 217, 102, 1)
                                                      : Color.fromRGBO(
                                                          217, 217, 217, 1),
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    b.id % 2 == 0
                                                        ? 'Buka'
                                                        : 'Tutup',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Gilroy-Light',
                                                      fontSize: 10,
                                                      color: Colors.black,
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
                                      maxCrossAxisExtent: 140,
                                      mainAxisExtent: 275,
                                      crossAxisSpacing: 5,
                                      mainAxisSpacing: 5,
                                    ),
                                    itemBuilder: (context, i) {
                                      final a = _list[i];
                                      return TextButton(
                                        onPressed: () {
                                          showModalBottomSheet<void>(
                                            isScrollControlled: true,
                                            enableDrag: false,
                                            isDismissible: false,                                   
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.97,
                                                color: Colors.white,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.9,
                                                      height: 50,
                                                      margin: EdgeInsets.only(
                                                          top: 20),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Icon(
                                                              Icons
                                                                  .chevron_left,
                                                              color:
                                                                  Colors.black,
                                                              size: 40,
                                                            ),
                                                          ),
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                'Dapur ' +
                                                                    a.name +
                                                                    ', Kode: ' +
                                                                    a.id.toString(),
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-ExtraBold',
                                                                  fontSize: 20,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                              Text(
                                                                'Makanan, Minuman, Gorengan, Snack',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-Light',
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .black,
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
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.85,
                                                      child:
                                                          SingleChildScrollView(
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                      width: 150,
                                                      height: 29,
                                                      margin: EdgeInsets.only(
                                                        top: 25,
                                                        left: 65,
                                                      ),
                                                      child: Text(
                                                        'Makanan',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-ExtraBold',
                                                                  fontSize: 20,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      height: 250,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        horizontal: 20,
                                                        vertical: 5,
                                                      ),
                                                              child: loading
                                                                  ? Center(
                                                                      child:
                                                                          CircularProgressIndicator(),
                                                                    )
                                                                  : GridView
                                                                      .builder(
                                                                      itemCount:
                                                                          6,
                                                                      gridDelegate:
                                                                          SliverGridDelegateWithMaxCrossAxisExtent(
                                                                        maxCrossAxisExtent:
                                                                            217,
                                                                        mainAxisExtent:
                                                                            116,
                                                                        mainAxisSpacing:
                                                                            5,
                                                                        crossAxisSpacing:
                                                                            10,
                                                                      ),
                                                                      itemBuilder:
                                                                          (context,
                                                                              i) {
                                                                        return Container(
                                                                          margin:
                                                                              EdgeInsets.all(5),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            boxShadow: [
                                                                              BoxShadow(
                                                                                color: Colors.black.withOpacity(0.3),
                                                                                spreadRadius: 0,
                                                                                blurRadius: 1.5,
                                                                                offset: Offset(0, 0),
                                                                              )
                                                                            ],
                                                                            color:
                                                                                Colors.white,
                                                                            borderRadius:
                                                                                BorderRadius.circular(7),
                                                                          ),
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              Container(
                                                                                width: 89,
                                                                                height: 97,
                                                                                margin: EdgeInsets.only(left: 10),
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(5),
                                                                                ),
                                                                                child: new Image.asset(
                                                                                  'assets/images/mieayam.png',
                                                                                  fit: BoxFit.fill,
                                                                                ),
                                                                              ),
                                                                              Column(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                children: [
                                                                                  Container(
                                                                                    width: 80,
                                                                                    margin: EdgeInsets.only(left: 15),
                                                                                    child: Text(
                                                                                      'Mie Ayam',
                                                                                      maxLines: 2,
                                                                                      overflow: TextOverflow.ellipsis,
                                                                                      style: TextStyle(
                                                                                        fontFamily: 'Gilroy-ExtraBold',
                                                                                        fontSize: 13,
                                                                                        color: Colors.black,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    width: 80,
                                                                                    margin: EdgeInsets.only(left: 15),
                                                                                    child: Text(
                                                                                      'Rp.10.000',
                                                                                      maxLines: 2,
                                                                                      overflow: TextOverflow.ellipsis,
                                                                                      style: TextStyle(
                                                                                        fontFamily: 'Gilroy-Light',
                                                                                        fontSize: 10,
                                                                                        color: Color.fromRGBO(76, 81, 97, 1),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    width: 90,
                                                                                    child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                                      children: [
                                                                                        SizedBox(
                                                                                          width: 40,
                                                                                          height: 40,
                                                                                          child: TextButton(
                                                                                            onPressed: () {
                                                                                              setState(() {
                                                                                                if (count != 0) {
                                                                                                  count--;
                                                                                                } else {}
                                                                                              });
                                                                                            },
                                                                                            child: Container(
                                                                                              width: 20,
                                                                                              height: 20,
                                                                                              decoration: BoxDecoration(
                                                                                                border: Border.all(
                                                                                                  width: 1,
                                                                                                  color: Colors.black,
                                                                                                ),
                                                                                              ),
                                                                                              child: Center(
                                                                                                child: Icon(
                                                                                                  Icons.remove,
                                                                                                  color: Colors.black,
                                                                                                  size: 18,
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        Container(
                                                                                          child: Text(
                                                                                            count.toString(),
                                                                                            style: TextStyle(
                                                                                              fontFamily: 'Gilroy-ExtraBold',
                                                                                              fontSize: 14,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        SizedBox(
                                                                                          width: 40,
                                                                                          height: 40,
                                                                                          child: TextButton(
                                                                                            onPressed: () {
                                                                                              setState(() {
                                                                                                count++;
                                                                                              });
                                                                                              refresh();
                                                                                            },
                                                                                            child: Container(
                                                                                              width: 20,
                                                                                              height: 20,
                                                                                              decoration: BoxDecoration(
                                                                                                border: Border.all(
                                                                                                  width: 1,
                                                                                                  color: Colors.black,
                                                                                                ),
                                                                                              ),
                                                                                              child: Center(
                                                                                                child: Icon(
                                                                                                  Icons.add,
                                                                                                  color: Colors.black,
                                                                                                  size: 18,
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
                                                                            ],
                                                                          ),
                                                                        );
                                                                      },
                                                                    ),
                                                            ),
                                                            Container(
                                                              width: 150,
                                                              height: 29,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                top: 25,
                                                                left: 65,
                                                              ),
                                                              child: Text(
                                                                'Minuman',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-ExtraBold',
                                                                  fontSize: 20,
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                              height: 250,
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                horizontal: 20,
                                                                vertical: 5,
                                                              ),
                                                              child: loading
                                                                  ? Center(
                                                                      child:
                                                                          CircularProgressIndicator(),
                                                                    )
                                                                  : GridView
                                                                      .builder(
                                                                      itemCount:
                                                                          6,
                                                                      gridDelegate:
                                                                          SliverGridDelegateWithMaxCrossAxisExtent(
                                                                        maxCrossAxisExtent:
                                                                            217,
                                                                        mainAxisExtent:
                                                                            116,
                                                                        mainAxisSpacing:
                                                                            5,
                                                                        crossAxisSpacing:
                                                                            10,
                                                                      ),
                                                                      itemBuilder:
                                                                          (context,
                                                                              i) {
                                                                        return Container(
                                                                          margin:
                                                                              EdgeInsets.all(5),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            boxShadow: [
                                                                              BoxShadow(
                                                                                color: Colors.black.withOpacity(0.3),
                                                                                spreadRadius: 0,
                                                                                blurRadius: 1.5,
                                                                                offset: Offset(0, 0),
                                                                              )
                                                                            ],
                                                                            color:
                                                                                Colors.white,
                                                                            borderRadius:
                                                                                BorderRadius.circular(7),
                                                                          ),
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              Container(
                                                                                width: 89,
                                                                                height: 97,
                                                                                margin: EdgeInsets.only(left: 10),
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(5),
                                                                                ),
                                                                                child: new Image.asset(
                                                                                  'assets/images/esteh.png',
                                                                                  fit: BoxFit.fill,
                                                                                ),
                                                                              ),
                                                                              Column(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                children: [
                                                                                  Container(
                                                                                    width: 80,
                                                                                    margin: EdgeInsets.only(left: 15),
                                                                                    child: Text(
                                                                                      'Es Teh',
                                                                                      maxLines: 2,
                                                                                      overflow: TextOverflow.ellipsis,
                                                                                      style: TextStyle(
                                                                                        fontFamily: 'Gilroy-ExtraBold',
                                                                                        fontSize: 13,
                                                                                        color: Colors.black,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    width: 80,
                                                                                    margin: EdgeInsets.only(left: 15),
                                                                                    child: Text(
                                                                                      'Rp.3.000',
                                                                                      maxLines: 2,
                                                                                      overflow: TextOverflow.ellipsis,
                                                                                      style: TextStyle(
                                                                                        fontFamily: 'Gilroy-Light',
                                                                                        fontSize: 10,
                                                                                        color: Color.fromRGBO(76, 81, 97, 1),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    width: 90,
                                                                                    child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                                      children: [
                                                                                        SizedBox(
                                                                                          width: 40,
                                                                                          height: 40,
                                                                                          child: TextButton(
                                                                                            onPressed: () {
                                                                                              setState(() {
                                                                                                if (count != 0) {
                                                                                                  count--;
                                                                                                } else {}
                                                                                              });
                                                                                            },
                                                                                            child: Container(
                                                                                              width: 20,
                                                                                              height: 20,
                                                                                              decoration: BoxDecoration(
                                                                                                border: Border.all(
                                                                                                  width: 1,
                                                                                                  color: Colors.black,
                                                                                                ),
                                                                                              ),
                                                                                              child: Center(
                                                                                                child: Icon(
                                                                                                  Icons.remove,
                                                                                                  color: Colors.black,
                                                                                                  size: 18,
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        Container(
                                                                                          child: Text(
                                                                                            count.toString(),
                                                                                            style: TextStyle(
                                                                                              fontFamily: 'Gilroy-ExtraBold',
                                                                                              fontSize: 14,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        SizedBox(
                                                                                          width: 40,
                                                                                          height: 40,
                                                                                          child: TextButton(
                                                                                            onPressed: () {
                                                                                              setState(() {
                                                                                                count++;
                                                                                              });
                                                                                              refresh();
                                                                                            },
                                                                                            child: Container(
                                                                                              width: 20,
                                                                                              height: 20,
                                                                                              decoration: BoxDecoration(
                                                                                                border: Border.all(
                                                                                                  width: 1,
                                                                                                  color: Colors.black,
                                                                                                ),
                                                                                              ),
                                                                                              child: Center(
                                                                                                child: Icon(
                                                                                                  Icons.add,
                                                                                                  color: Colors.black,
                                                                                                  size: 18,
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
                                                                            ],
                                                                          ),
                                                                        );
                                                                      },
                                                                    ),
                                                            ),
                                                            Container(
                                                              width: 150,
                                                              height: 29,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                top: 25,
                                                                left: 65,
                                                              ),
                                                              child: Text(
                                                                'Jajanan',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-ExtraBold',
                                                                  fontSize: 20,
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                              height: 250,
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                horizontal: 20,
                                                                vertical: 5,
                                                              ),
                                                  
                                                      child: loading
                                                          ? Center(
                                                              child:
                                                                  CircularProgressIndicator(),
                                                            )
                                                          : GridView.builder(
                                                              itemCount: 6,
                                                              gridDelegate:
                                                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                                                maxCrossAxisExtent:
                                                                    217,
                                                                mainAxisExtent:
                                                                    116,
                                                                mainAxisSpacing:
                                                                    5,
                                                                crossAxisSpacing:
                                                                    10,
                                                              ),
                                                              itemBuilder:
                                                                  (context, i) {
                                                                return Container(
                                                                  margin:
                                                                      EdgeInsets
                                                                          .all(
                                                                              5),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                        color: Colors
                                                                            .black
                                                                            .withOpacity(0.3),
                                                                        spreadRadius:
                                                                            0,
                                                                        blurRadius:
                                                                            1.5,
                                                                        offset: Offset(
                                                                            0,
                                                                            0),
                                                                      )
                                                                    ],
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(7),
                                                                  ),
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              Container(
                                                                                width: 89,
                                                                                height: 97,
                                                                                margin: EdgeInsets.only(left: 10),
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(5),
                                                                                ),
                                                                                child: new Image.asset(
                                                                                  'assets/images/mieayam.png',
                                                                                  fit: BoxFit.fill,
                                                                                ),
                                                                              ),
                                                                              Column(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                children: [
                                                                                  Container(
                                                                                    width: 80,
                                                                                    margin: EdgeInsets.only(left: 15),
                                                                                    child: Text(
                                                                                      'Tahu Isi',
                                                                                      maxLines: 2,
                                                                                      overflow: TextOverflow.ellipsis,
                                                                                      style: TextStyle(
                                                                                        fontFamily: 'Gilroy-ExtraBold',
                                                                                        fontSize: 13,
                                                                                        color: Colors.black,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    width: 80,
                                                                                    margin: EdgeInsets.only(left: 15),
                                                                                    child: Text(
                                                                                      'Rp.2.000',
                                                                                      maxLines: 2,
                                                                                      overflow: TextOverflow.ellipsis,
                                                                                      style: TextStyle(
                                                                                        fontFamily: 'Gilroy-Light',
                                                                                        fontSize: 10,
                                                                                        color: Color.fromRGBO(76, 81, 97, 1),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    width: 90,
                                                                                    child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                                      children: [
                                                                                        SizedBox(
                                                                                          width: 40,
                                                                                          height: 40,
                                                                                          child: TextButton(
                                                                                            onPressed: () {
                                                                                              setState(() {
                                                                                                if (count != 0) {
                                                                                                  count--;
                                                                                                } else {}
                                                                                              });
                                                                                            },
                                                                                            child: Container(
                                                                                              width: 20,
                                                                                              height: 20,
                                                                                              decoration: BoxDecoration(
                                                                                                border: Border.all(
                                                                                                  width: 1,
                                                                                                  color: Colors.black,
                                                                                                ),
                                                                                              ),
                                                                                              child: Center(
                                                                                                child: Icon(
                                                                                                  Icons.remove,
                                                                                                  color: Colors.black,
                                                                                                  size: 18,
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        Container(
                                                                                          child: Text(
                                                                                            count.toString(),
                                                                                            style: TextStyle(
                                                                                              fontFamily: 'Gilroy-ExtraBold',
                                                                                              fontSize: 14,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        SizedBox(
                                                                                          width: 40,
                                                                                          height: 40,
                                                                                          child: TextButton(
                                                                                            onPressed: () {
                                                                                              setState(() {
                                                                                                count++;
                                                                                              });
                                                                                              refresh();
                                                                                            },
                                                                                            child: Container(
                                                                                              width: 20,
                                                                                              height: 20,
                                                                                              decoration: BoxDecoration(
                                                                                                border: Border.all(
                                                                                                  width: 1,
                                                                                                  color: Colors.black,
                                                                                                ),
                                                                                              ),
                                                                                              child: Center(
                                                                                                child: Icon(
                                                                                                  Icons.add,
                                                                                                  color: Colors.black,
                                                                                                  size: 18,
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
                                                    Align(
                                                      alignment:
                                                          Alignment(0.0, 1.0),
                                                      child: Visibility(
                                                        visible: count > 0
                                                            ? true
                                                            : false,
                                                        child: Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.8,
                                                          height: 41,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color:
                                                                Color.fromRGBO(
                                                                    119,
                                                                    115,
                                                                    205,
                                                                    1),
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
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 119,
                                                height: 161,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: new Image.asset(
                                                  'assets/images/menu.png',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Container(
                                                width: 114,
                                                child: Text(
                                                  'Dapur ' + a.name,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontFamily:
                                                        'Gilroy-ExtraBold',
                                                    fontSize: 13,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: 114,
                                                child: Text(
                                                  'Kode: ' + a.id.toString(),
                                                  style: TextStyle(
                                                    fontFamily: 'Gilroy-Light',
                                                    fontSize: 10,
                                                    color: Color.fromRGBO(
                                                        76, 81, 97, 1),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: 114,
                                                child: Text(
                                                  'Makanan, Minuman, Gorengan, Snack',
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontFamily: 'Gilroy-Light',
                                                    fontSize: 10,
                                                    color: Color.fromRGBO(
                                                        76, 81, 97, 1),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: 31,
                                                height: 15,
                                                decoration: BoxDecoration(
                                                  color: a.id % 2 == 0
                                                      ? Color.fromRGBO(
                                                          255, 217, 102, 1)
                                                      : Color.fromRGBO(
                                                          217, 217, 217, 1),
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    a.id % 2 == 0
                                                        ? 'Buka'
                                                        : 'Tutup',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Gilroy-Light',
                                                      fontSize: 10,
                                                      color: Colors.black,
                                                    ),
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
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    padding: EdgeInsets.only(bottom: 25),
                    color: Color.fromRGBO(243, 243, 243, 1),
                    child: GridView.builder(
                        itemCount: _list.length,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 491,
                          mainAxisExtent: 138,
                          mainAxisSpacing: 6,
                        ),
                        itemBuilder: ((context, i) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 74,
                                  height: 100,
                                  margin: EdgeInsets.only(left: 40),
                                  child: Image.asset(
                                    'assets/images/samplebook.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  width: 279,
                                  height: 100,
                                  margin: EdgeInsets.only(left: 40),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
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
                                        ),
                                      ),
                                      Text(
                                        'Berakhir : 11 September 2022',
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                          fontSize: 14,
                                        ),
                                      ),
                                      Container(
                                        width: 114,
                                        height: 19,
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
                    height: MediaQuery.of(context).size.height,
                    padding: EdgeInsets.only(bottom: 25),
                    color: Color.fromRGBO(243, 243, 243, 1),
                    child: GridView.builder(
                        itemCount: _list.length,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 491,
                          mainAxisExtent: 138,
                          mainAxisSpacing: 6,
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
                                  width: 74,
                                  height: 100,
                                  margin: EdgeInsets.only(left: 40),
                                  child: Image.asset(
                                    'assets/images/samplebook.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  width: 279,
                                  height: 100,
                                  margin: EdgeInsets.only(left: 40),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Ilmu Pengetahuan Alam',
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-ExtraBold',
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text(
                                        'Berakhir : 11 September 2022',
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        a.id % 2 == 0
                                            ? 'Kembali : 12 September 2022'
                                            : 'Kembali : 11 September 2022',
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                          fontSize: 14,
                                        ),
                                      ),
                                      Container(
                                        width: 126,
                                        height: 15,
                                        decoration: BoxDecoration(
                                          color: a.id % 2 == 0
                                              ? Color.fromRGBO(242, 78, 26, 1)
                                              : Color.fromRGBO(
                                                  217, 217, 217, 1),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Center(
                                          child: Text(
                                            a.id % 2 == 0
                                                ? 'Telat Pengembalian'
                                                : 'Sudah Dikembalikan',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy-Light',
                                              fontSize: 13,
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