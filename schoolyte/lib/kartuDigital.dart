import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'model.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KartuDigital extends StatefulWidget {
  final profil;
  KartuDigital({super.key, required this.profil});

  @override
  _KartuDigitalState createState() => new _KartuDigitalState(profil);
}

class _KartuDigitalState extends State<KartuDigital> {
  List<Siswa> _list = [];
  var loading = false;
  var status;

  Future fetchData() async {
    setState(() {
      loading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    var id = prefs.getString('id');
    status = prefs.getString('status');
    _list.clear();
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  final profil;
  _KartuDigitalState(this.profil);

  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Color.fromRGBO(243, 243, 243, 1),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(75),
            child: AppBar(
              backgroundColor: Colors.white,
              title: Align(
                alignment: Alignment(-0.7, 0.0),
                child: Text(
                  'Kartu Pelajar Digital',
                  style: TextStyle(
                    fontFamily: 'Gilroy-ExtraBold',
                    fontSize: 24,
                    color: Color.fromRGBO(76, 81, 97, 1),
                  ),
                ),
              ),
              elevation: 0.0,
              iconTheme: IconThemeData(color: Color.fromRGBO(217, 217, 217, 1)),
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Align(
                  alignment: Alignment(1.0, 0.0),
                  child: Icon(
                    Icons.chevron_left_rounded,
                    color: Color.fromRGBO(217, 217, 217, 1),
                    size: 40,
                  ),
                ),
              ),
            ),
          ),
          body: loading
              ? Center(
                  child: CircularProgressIndicator(
                    color: Color.fromRGBO(76, 81, 97, 1),
                  ),
                )
              : Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 270,
                        margin: EdgeInsets.only(top: 35),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/kartudigital.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment(-0.7, -0.7),
                              child: Container(
                                width: 240,
                                height: 55,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 55,
                                      height: 55,
                                      child: ClipOval(
                                        child: Image.network(
                                          Api.image + profil.image,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 180,
                                      height: 55,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            profil.nama,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontFamily: 'Gilroy-ExtraBold',
                                              fontSize: 16,
                                              color:
                                                  Color.fromRGBO(76, 81, 97, 1),
                                            ),
                                          ),
                                          Text(
                                            profil.status,
                                            style: TextStyle(
                                              fontFamily: 'Gilroy-Light',
                                              fontSize: 15,
                                              color:
                                                  Color.fromRGBO(76, 81, 97, 1),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment(-0.6, 0.3),
                              child: Container(
                                width: 258,
                                height: 72,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          status.toLowerCase() == 'guru'
                                              ? 'NIP : '
                                              : status.toLowerCase() == 'siswa'
                                                  ? 'NISN : '
                                                  : 'NIK : ',
                                          style: TextStyle(
                                            fontFamily: 'Gilroy-ExtraBold',
                                            fontSize: 12,
                                            color:
                                                Color.fromRGBO(76, 81, 97, 1),
                                          ),
                                        ),
                                        Text(
                                          status.toLowerCase() == 'guru'
                                              ? profil.nip
                                              : status.toLowerCase() == 'siswa'
                                                  ? profil.nis
                                                  : profil.nik,
                                          style: TextStyle(
                                            fontFamily: 'Gilroy-Light',
                                            fontSize: 12,
                                            color:
                                                Color.fromRGBO(76, 81, 97, 1),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'TTL : ',
                                          style: TextStyle(
                                            fontFamily: 'Gilroy-ExtraBold',
                                            fontSize: 12,
                                            color:
                                                Color.fromRGBO(76, 81, 97, 1),
                                          ),
                                        ),
                                        Text(
                                          '${profil.tempat_lahir}, ${profil.tgl_lahir}',
                                          style: TextStyle(
                                            fontFamily: 'Gilroy-Light',
                                            fontSize: 12,
                                            color:
                                                Color.fromRGBO(76, 81, 97, 1),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Alamat : ',
                                          style: TextStyle(
                                            fontFamily: 'Gilroy-ExtraBold',
                                            fontSize: 12,
                                            color:
                                                Color.fromRGBO(76, 81, 97, 1),
                                          ),
                                        ),
                                        Text(
                                          profil.alamat,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontFamily: 'Gilroy-Light',
                                            fontSize: 12,
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
                            Align(
                              alignment: Alignment(0.75, -0.35),
                              child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Center(
                                          child: Material(
                                            type: MaterialType.transparency,
                                            child: QrImage(
                                              data:
                                                  status.toLowerCase() == 'guru'
                                                      ? profil.nip
                                                      : status.toLowerCase() ==
                                                              'guru'
                                                          ? profil.nis
                                                          : profil.nik,
                                              version: QrVersions.auto,
                                              size: 300,
                                              backgroundColor: Colors.white,
                                            ),
                                          ),
                                        );
                                      });
                                },
                                child: Container(
                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/borderbarcode.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Center(
                                    child: Container(
                                      width: 53.21,
                                      height: 53.21,
                                      child: QrImage(
                                        data: status.toLowerCase() == 'guru'
                                            ? profil.nip
                                            : status.toLowerCase() == 'siswa'
                                                ? profil.nis
                                                : profil.nik,
                                        version: QrVersions.auto,
                                        padding: EdgeInsets.zero,
                                      ),
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
      ),
    );
  }
}
