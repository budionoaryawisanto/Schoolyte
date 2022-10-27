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
        '/login': (BuildContext context) => new LoginPage(),
        '/landing': (BuildContext context) => new LandingPage(),
        '/home': (BuildContext context) => new HomePage(),
        '/jadwal': (BuildContext context) => new JadwalPage(),
        '/rapor': (BuildContext context) => new RaporPage(),
        '/absensi': (BuildContext context) => new AbsensiPage(),
        '/perpustakaan': (BuildContext context) => new PerpustakaanPage(),
        '/fasilitas': (BuildContext context) => new FasilitasPage(),
        '/nilaiBelajar': (BuildContext context) => new NilaiBelajarPage(),
        '/kantin': (BuildContext context) => new KantinPage(),
        '/berita': (BuildContext context) => new BeritaPage(),
      },
    );
  }
}
