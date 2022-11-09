import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import './launcher.dart';
import './landing.dart';
import './login.dart';
import './home.dart';
import './jadwal.dart';
import './rapor.dart';
import './absensi.dart';
import './perpustakaan.dart';
import './fasilitas.dart';
import './nilaiBelajar.dart';
import './kantin.dart';
import './berita.dart';
import './scanner.dart';
import './pembayaran.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LauncherPage(),
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => LoginPage(),
        '/landing': (BuildContext context) => LandingPage(),
        '/home': (BuildContext context) => HomePage(),
        '/jadwal': (BuildContext context) => JadwalPage(),
        '/rapor': (BuildContext context) => RaporPage(),
        '/absensi': (BuildContext context) => AbsensiPage(),
        '/perpustakaan': (BuildContext context) => PerpustakaanPage(),
        '/fasilitas': (BuildContext context) => FasilitasPage(),
        '/nilaiBelajar': (BuildContext context) => NilaiBelajarPage(),
        '/kantin': (BuildContext context) => KantinPage(),
        '/berita': (BuildContext context) => BeritaPage(),
        '/scanner': (BuildContext context) => Scanner(),
        '/pembayaran': (BuildContext context) => Pembayaran(),
      },
    );
  }
}
