import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:schoolyte/berita.dart';
import 'package:schoolyte/fasilitas.dart';
import 'package:schoolyte/jadwal.dart';
import 'package:schoolyte/nilaiBelajar.dart';
import 'package:schoolyte/perpustakaan.dart';
import 'package:schoolyte/rapor.dart';
import 'package:schoolyte/kantin.dart';
import 'package:schoolyte/home.dart';
import 'koperasi.dart';
import 'model.dart';
import 'osis.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:async/async.dart';
import 'ekstrakurikuler.dart';
import 'profil.dart';
import 'administrasi.dart';
import 'package:geolocator/geolocator.dart';

class AbsensiPegawaiPage extends StatefulWidget {
  @override
  _AbsensiPegawaiPageState createState() => new _AbsensiPegawaiPageState();
}

class _AbsensiPegawaiPageState extends State<AbsensiPegawaiPage> {
  List<AbsensiSiswa> _absensi = [];
  var loading = false;

  Future fetchData() async {
    setState(() {
      loading = true;
    });
    _absensi.clear();
    final response = await http.get(Uri.parse(Api.getAbsenSiswa));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        for (Map<String, dynamic> i in data) {
          _absensi.add(AbsensiSiswa.formJson(i));
          loading = false;
        }
      });
    } else {
      print('gagal mendapatkan data');
    }
  }

  Future saveAbsensi() async {
    setState(() {
      loading = true;
    });
    try {
      var stream = http.ByteStream(DelegatingStream(image!.openRead()));
      var length = await image!.length();
      var uri = Uri.parse(Api.createAbsenSiswa);
      var request = http.MultipartRequest("POST", uri);
      request.fields['siswa_id'] = '1';
      request.fields['kelas_id'] = '1';
      request.fields['status_absen'] = dropdownvalue;
      request.fields['tgl_absen'] = tglAbsen.toString();
      request.fields['wkt_absen'] = waktuAbsen.toString();

      request.files.add(http.MultipartFile("image", stream, length,
          filename: path.basename(image!.path)));
      var response = await request.send();
      if (response.statusCode == 200) {
        setState(() {
          loading = false;
        });
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Container(
                  height: 357,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 177,
                        height: 177,
                        child: Image.asset(
                          'assets/images/dialog.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                      Text(
                        'Absen Sukses',
                        style: TextStyle(
                          fontFamily: 'Gilroy-ExtraBold',
                          fontSize: 32,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                        },
                        child: Container(
                          width: 107,
                          height: 43,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color.fromRGBO(119, 115, 205, 1),
                          ),
                          child: Center(
                            child: Text(
                              'OK',
                              style: TextStyle(
                                fontFamily: 'Gilroy-Light',
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
      } else {
        return;
      }
    } catch (e) {
      debugPrint("Error $e");
    }
  }

  failed() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            child: Container(
              height: 357,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 177,
                    height: 177,
                    child: Image.asset(
                      'assets/images/alertDialog.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Text(
                    'Gagal',
                    style: TextStyle(
                      fontFamily: 'Gilroy-ExtraBold',
                      fontSize: 32,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 107,
                      height: 43,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color.fromRGBO(242, 78, 26, 1),
                      ),
                      child: Center(
                        child: Text(
                          'OK',
                          style: TextStyle(
                            fontFamily: 'Gilroy-Light',
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

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

  File? image;
  Future getImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? imagePicked =
        await _picker.pickImage(source: ImageSource.camera);

    image = File(imagePicked!.path);
    setState(() {});
  }

  void liveLocation() {
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.best,
      distanceFilter: 5,
    );

    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position? position) {
      lat = position?.latitude.toString();
      long = position?.longitude.toString();
    });
  }

  Future<Position> _getCurrentLocation() async {
    DartPluginRegistrant.ensureInitialized();
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Tidak dapat melacak lokasi');
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      return Future.error('Izin lokasi ditolak');
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Izin lokasi berstatus nonaktif permanen');
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  var status = ['Hadir', 'Alpha', 'Izin', 'Sakit'];
  var dropdownvalue = 'Hadir';
  final waktuAbsen = DateFormat().add_Hm().format(DateTime.now());
  var tglAbsen;
  var lat;
  var long;

  List<Tab> myTabs = <Tab>[
    Tab(text: 'Check-In'),
    Tab(text: 'Check-Out'),
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Color.fromRGBO(180, 176, 255, 1),
        systemNavigationBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: DefaultTabController(
          length: myTabs.length,
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
                    color: Colors.white,
                  ),
                ),
              ),
              elevation: 0.0,
              iconTheme: IconThemeData(color: Colors.white),
              backgroundColor: Color.fromRGBO(180, 176, 255, 1),
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RaporPage()));
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AbsensiPegawaiPage()));
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: new Image.asset(
                      'assets/images/infoabsen.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.06,
                    color: Colors.white,
                    child: TabBar(
                      padding: EdgeInsets.only(bottom: 10),
                      indicatorColor: Color.fromRGBO(76, 81, 97, 1),
                      indicatorSize: TabBarIndicatorSize.label,
                      labelColor: Color.fromRGBO(76, 81, 97, 1),
                      unselectedLabelColor: Color.fromRGBO(76, 81, 97, 1),
                      labelStyle: TextStyle(
                        fontFamily: 'Gilroy-ExtraBold',
                        fontSize: 20,
                        color: Color.fromRGBO(76, 81, 97, 1),
                      ),
                      unselectedLabelStyle: TextStyle(
                        fontFamily: 'Gilroy-Light',
                        fontSize: 20,
                        color: Color.fromRGBO(76, 81, 97, 1),
                      ),
                      tabs: myTabs,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 650,
                    child: TabBarView(
                      children: [
                        Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: MediaQuery.of(context).size.height * 0.3,
                              margin: EdgeInsets.only(top: 25),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(9),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        0.064,
                                    alignment: AlignmentDirectional.centerStart,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(9),
                                        topRight: Radius.circular(9),
                                      ),
                                      color: Color.fromRGBO(119, 115, 205, 1),
                                    ),
                                    child: Container(
                                      margin: EdgeInsets.only(left: 25),
                                      child: Text(
                                        'Lakukan Check-In !',
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-ExtraBold',
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    margin: EdgeInsets.only(
                                      left: 40,
                                      top: 15,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          child: Text(
                                            'Bukti Kehadiran  : ',
                                            style: TextStyle(
                                                fontFamily: 'Gilroy-Light',
                                                fontSize: 16),
                                          ),
                                        ),
                                        image != null
                                            ? TextButton(
                                                onPressed: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return Center(
                                                          child: Material(
                                                            type: MaterialType
                                                                .transparency,
                                                            child:
                                                                new Image.file(
                                                                    image!),
                                                          ),
                                                        );
                                                      });
                                                },
                                                child: Container(
                                                  width: 145,
                                                  height: 33,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.3),
                                                        spreadRadius: 0,
                                                        blurRadius: 1.5,
                                                        offset: Offset(0, 0),
                                                      )
                                                    ],
                                                    color: Colors.white,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.done,
                                                        color: Color.fromRGBO(
                                                            76, 81, 97, 1),
                                                        size: 20,
                                                      ),
                                                      Text(
                                                        'Lihat Foto',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-Light',
                                                          fontSize: 15,
                                                          color: Color.fromRGBO(
                                                              76, 81, 97, 1),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : TextButton(
                                                onPressed: () async {
                                                  await getImage();
                                                },
                                                child: Container(
                                                  width: 145,
                                                  height: 33,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.3),
                                                        spreadRadius: 0,
                                                        blurRadius: 1.5,
                                                        offset: Offset(0, 0),
                                                      )
                                                    ],
                                                    color: Colors.white,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.photo_camera,
                                                        color: Color.fromRGBO(
                                                            76, 81, 97, 1),
                                                        size: 20,
                                                      ),
                                                      Text(
                                                        'Tambah Foto',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-Light',
                                                          fontSize: 15,
                                                          color: Color.fromRGBO(
                                                              76, 81, 97, 1),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                        image != null
                                            ? Container(
                                                child: TextButton(
                                                  child: Icon(
                                                    Icons.delete,
                                                    color: Color.fromRGBO(
                                                        76, 81, 97, 1),
                                                    size: 20,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      image = null;
                                                    });
                                                  },
                                                ),
                                              )
                                            : Container(),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    margin: EdgeInsets.only(
                                      left: 40,
                                      top: 10,
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Pilih Kehadiran    :  ',
                                          style: TextStyle(
                                              fontFamily: 'Gilroy-Light',
                                              fontSize: 16),
                                        ),
                                        Container(
                                          width: 90,
                                          height: 26,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.3),
                                                spreadRadius: 0,
                                                blurRadius: 1.5,
                                                offset: Offset(0, 0),
                                              )
                                            ],
                                            color: Color.fromRGBO(
                                                243, 243, 243, 1),
                                          ),
                                          child: Center(
                                            child: DropdownButton(
                                              value: dropdownvalue,
                                              elevation: 0,
                                              underline: SizedBox(),
                                              style: TextStyle(
                                                fontFamily: 'Gilroy-Light',
                                                fontSize: 16,
                                                color: Color.fromRGBO(
                                                    76, 81, 97, 1),
                                              ),
                                              icon: const Icon(
                                                  Icons.keyboard_arrow_down),
                                              items: status.map((String items) {
                                                return DropdownMenuItem(
                                                  value: items,
                                                  child: Text(items),
                                                );
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  dropdownvalue = newValue!;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    margin: EdgeInsets.only(
                                      left: 30,
                                      bottom: 25,
                                      top: 10,
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.52,
                                          child: DateTimePicker(
                                            type: DateTimePickerType.date,
                                            icon:
                                                Icon(Icons.date_range_rounded),
                                            dateMask: 'EEEE, d MMMM yyyy',
                                            initialValue: '',
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime.now(),
                                            selectableDayPredicate: (date) {
                                              if (date.weekday == 6 ||
                                                  date.weekday == 7) {
                                                return false;
                                              }
                                              return true;
                                            },
                                            style: TextStyle(
                                              fontFamily: 'Gilroy-Light',
                                              fontSize: 16,
                                              color: Colors.black,
                                            ),
                                            onChanged: (val) => setState(() {
                                              tglAbsen = val;
                                            }),
                                            validator: (val) {
                                              return null;
                                            },
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.22,
                                          margin: EdgeInsets.only(left: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Icon(
                                                Icons.schedule_rounded,
                                                color: Color.fromRGBO(
                                                    76, 81, 97, 1),
                                              ),
                                              Text(
                                                waktuAbsen,
                                                style: TextStyle(
                                                  fontFamily: 'Gilroy-Light',
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.215,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.031,
                                        margin: EdgeInsets.only(right: 15),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(9),
                                          color: Colors.black,
                                        ),
                                        child: Center(
                                          child: GestureDetector(
                                            onTap: () {
                                              print(image);
                                              print(dropdownvalue);
                                              print(waktuAbsen);
                                            },
                                            child: Text(
                                              'Selesai',
                                              style: TextStyle(
                                                fontFamily: 'Gilroy-Light',
                                                fontSize: 15,
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
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.29,
                              color: Colors.white,
                              margin: EdgeInsets.only(top: 18),
                              padding: EdgeInsets.all(10),
                              child: GridView.builder(
                                itemCount: 7,
                                padding: EdgeInsets.all(10),
                                gridDelegate:
                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent:
                                      MediaQuery.of(context).size.width * 0.9,
                                  mainAxisExtent: 71,
                                  mainAxisSpacing: 18,
                                  crossAxisSpacing: 18,
                                ),
                                itemBuilder: (context, i) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Monday, 01 January 2022',
                                              style: TextStyle(
                                                fontFamily: 'Gilroy-Light',
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              '07:15 WIB',
                                              style: TextStyle(
                                                fontFamily: 'Gilroy-Light',
                                                fontSize: 14,
                                                color: Color.fromRGBO(
                                                    76, 81, 97, 1),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return Center(
                                                        child: Material(
                                                          type: MaterialType
                                                              .transparency,
                                                          child: image != null
                                                              ? Image.file(
                                                                  image!)
                                                              : Image.asset(
                                                                  'assets/images/hi1.png'),
                                                        ),
                                                      );
                                                    });
                                              },
                                              child: Container(
                                                width: 80,
                                                height: 23,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  color: Color.fromRGBO(
                                                      243, 243, 243, 1),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.3),
                                                      spreadRadius: 0,
                                                      blurRadius: 1.5,
                                                      offset: Offset(0, 1),
                                                    )
                                                  ],
                                                ),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.play_arrow,
                                                      size: 18,
                                                      color: Colors.black,
                                                    ),
                                                    Text(
                                                      'Lihat Foto',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Gilroy-Light',
                                                        fontSize: 12,
                                                        color: Color.fromRGBO(
                                                            76, 81, 97, 0.54),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(left: 15),
                                              child: Text(
                                                'Hadir',
                                                style: TextStyle(
                                                  fontFamily:
                                                      'Gilroy-ExtraBold',
                                                  fontSize: 12,
                                                  color: Color.fromRGBO(
                                                      76, 81, 97, 1),
                                                ),
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
                        Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: MediaQuery.of(context).size.height * 0.3,
                              margin: EdgeInsets.only(top: 25),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(9),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        0.064,
                                    alignment: AlignmentDirectional.centerStart,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(9),
                                        topRight: Radius.circular(9),
                                      ),
                                      color: Color.fromRGBO(119, 115, 205, 1),
                                    ),
                                    child: Container(
                                      margin: EdgeInsets.only(left: 25),
                                      child: Text(
                                        'Lakukan Check-Out !',
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-ExtraBold',
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    margin: EdgeInsets.only(
                                      left: 40,
                                      top: 15,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          child: Text(
                                            'Bukti Kehadiran  : ',
                                            style: TextStyle(
                                                fontFamily: 'Gilroy-Light',
                                                fontSize: 16),
                                          ),
                                        ),
                                        image != null
                                            ? TextButton(
                                                onPressed: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return Center(
                                                          child: Material(
                                                            type: MaterialType
                                                                .transparency,
                                                            child:
                                                                new Image.file(
                                                                    image!),
                                                          ),
                                                        );
                                                      });
                                                },
                                                child: Container(
                                                  width: 145,
                                                  height: 33,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.3),
                                                        spreadRadius: 0,
                                                        blurRadius: 1.5,
                                                        offset: Offset(0, 0),
                                                      )
                                                    ],
                                                    color: Colors.white,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.done,
                                                        color: Color.fromRGBO(
                                                            76, 81, 97, 1),
                                                        size: 20,
                                                      ),
                                                      Text(
                                                        'Lihat Foto',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-Light',
                                                          fontSize: 15,
                                                          color: Color.fromRGBO(
                                                              76, 81, 97, 1),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : TextButton(
                                                onPressed: () async {
                                                  await getImage();
                                                },
                                                child: Container(
                                                  width: 145,
                                                  height: 33,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.3),
                                                        spreadRadius: 0,
                                                        blurRadius: 1.5,
                                                        offset: Offset(0, 0),
                                                      )
                                                    ],
                                                    color: Colors.white,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.photo_camera,
                                                        color: Color.fromRGBO(
                                                            76, 81, 97, 1),
                                                        size: 20,
                                                      ),
                                                      Text(
                                                        'Tambah Foto',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-Light',
                                                          fontSize: 15,
                                                          color: Color.fromRGBO(
                                                              76, 81, 97, 1),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                        image != null
                                            ? Container(
                                                child: TextButton(
                                                  child: Icon(
                                                    Icons.delete,
                                                    color: Color.fromRGBO(
                                                        76, 81, 97, 1),
                                                    size: 20,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      image = null;
                                                    });
                                                  },
                                                ),
                                              )
                                            : Container(),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    margin: EdgeInsets.only(
                                      left: 40,
                                      top: 10,
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Pilih Kehadiran    :  ',
                                          style: TextStyle(
                                              fontFamily: 'Gilroy-Light',
                                              fontSize: 16),
                                        ),
                                        Container(
                                          width: 90,
                                          height: 26,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.3),
                                                spreadRadius: 0,
                                                blurRadius: 1.5,
                                                offset: Offset(0, 0),
                                              )
                                            ],
                                            color: Color.fromRGBO(
                                                243, 243, 243, 1),
                                          ),
                                          child: Center(
                                            child: DropdownButton(
                                              value: dropdownvalue,
                                              elevation: 0,
                                              underline: SizedBox(),
                                              style: TextStyle(
                                                fontFamily: 'Gilroy-Light',
                                                fontSize: 16,
                                                color: Color.fromRGBO(
                                                    76, 81, 97, 1),
                                              ),
                                              icon: const Icon(
                                                  Icons.keyboard_arrow_down),
                                              items: status.map((String items) {
                                                return DropdownMenuItem(
                                                  value: items,
                                                  child: Text(items),
                                                );
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  dropdownvalue = newValue!;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    margin: EdgeInsets.only(
                                      left: 30,
                                      bottom: 25,
                                      top: 10,
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.52,
                                          child: DateTimePicker(
                                            type: DateTimePickerType.date,
                                            icon:
                                                Icon(Icons.date_range_rounded),
                                            dateMask: 'EEEE, d MMMM yyyy',
                                            initialValue: '',
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime.now(),
                                            selectableDayPredicate: (date) {
                                              if (date.weekday == 6 ||
                                                  date.weekday == 7) {
                                                return false;
                                              }
                                              return true;
                                            },
                                            style: TextStyle(
                                              fontFamily: 'Gilroy-Light',
                                              fontSize: 16,
                                              color: Colors.black,
                                            ),
                                            onChanged: (val) => setState(() {
                                              tglAbsen = val;
                                            }),
                                            validator: (val) {
                                              return null;
                                            },
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.22,
                                          margin: EdgeInsets.only(left: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Icon(
                                                Icons.schedule_rounded,
                                                color: Color.fromRGBO(
                                                    76, 81, 97, 1),
                                              ),
                                              Text(
                                                waktuAbsen,
                                                style: TextStyle(
                                                  fontFamily: 'Gilroy-Light',
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.215,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.031,
                                        margin: EdgeInsets.only(right: 15),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(9),
                                          color: Colors.black,
                                        ),
                                        child: Center(
                                          child: GestureDetector(
                                            onTap: () {
                                              print(image);
                                              print(dropdownvalue);
                                              print(waktuAbsen);
                                            },
                                            child: Text(
                                              'Selesai',
                                              style: TextStyle(
                                                fontFamily: 'Gilroy-Light',
                                                fontSize: 15,
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
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.29,
                              color: Colors.white,
                              margin: EdgeInsets.only(top: 18),
                              padding: EdgeInsets.all(10),
                              child: GridView.builder(
                                itemCount: 7,
                                padding: EdgeInsets.all(10),
                                gridDelegate:
                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent:
                                      MediaQuery.of(context).size.width * 0.9,
                                  mainAxisExtent: 71,
                                  mainAxisSpacing: 18,
                                  crossAxisSpacing: 18,
                                ),
                                itemBuilder: (context, i) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Monday, 01 January 2022',
                                              style: TextStyle(
                                                fontFamily: 'Gilroy-Light',
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              '16:09 WIB',
                                              style: TextStyle(
                                                fontFamily: 'Gilroy-Light',
                                                fontSize: 14,
                                                color: Color.fromRGBO(
                                                    76, 81, 97, 1),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return Center(
                                                        child: Material(
                                                          type: MaterialType
                                                              .transparency,
                                                          child: image != null
                                                              ? Image.file(
                                                                  image!)
                                                              : Image.asset(
                                                                  'assets/images/hi1.png'),
                                                        ),
                                                      );
                                                    });
                                              },
                                              child: Container(
                                                width: 80,
                                                height: 23,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  color: Color.fromRGBO(
                                                      243, 243, 243, 1),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.3),
                                                      spreadRadius: 0,
                                                      blurRadius: 1.5,
                                                      offset: Offset(0, 1),
                                                    )
                                                  ],
                                                ),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.play_arrow,
                                                      size: 18,
                                                      color: Colors.black,
                                                    ),
                                                    Text(
                                                      'Lihat Foto',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Gilroy-Light',
                                                        fontSize: 12,
                                                        color: Color.fromRGBO(
                                                            76, 81, 97, 0.54),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(left: 15),
                                              child: Text(
                                                'Hadir',
                                                style: TextStyle(
                                                  fontFamily:
                                                      'Gilroy-ExtraBold',
                                                  fontSize: 12,
                                                  color: Color.fromRGBO(
                                                      76, 81, 97, 1),
                                                ),
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
