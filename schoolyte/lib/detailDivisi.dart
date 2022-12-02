import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:schoolyte/pembayaran.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model.dart';

class DetailDivisi extends StatefulWidget {
  Test divisi;
  DetailDivisi({super.key, required this.divisi});

  @override
  _DetailDivisiState createState() => new _DetailDivisiState(divisi);
}

class _DetailDivisiState extends State<DetailDivisi> {
  List<Test> _list = [];

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

  @override
  Test divisi;
  _DetailDivisiState(this.divisi);

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
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(75),
            child: AppBar(
              backgroundColor: Colors.white,
              title: Align(
                alignment: Alignment(-0.7, 0.0),
                child: Text(
                  'Divisi Humas ' + divisi.id.toString(),
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
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment(0.0, 0.0),
                    child: Image.asset(
                      'assets/images/divisi.png',
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.92,
                    height: 60,
                    margin: EdgeInsets.only(top: 15),
                    child: SingleChildScrollView(
                      child: Text(
                        'Divisi ini berfokus pada bidang kemanusiaan serta Memantapkan dan mengembangkan peran siswa di dalam OSIS sesuai dengan tugasnya masing-masing. Divisi ini berfokus pada bidang kemanusiaan serta Memantapkan dan mengembangkan peran siswa di dalam OSIS sesuai dengan tugasnya masing-masing',
                        style: TextStyle(
                          fontFamily: 'Gilroy-Light',
                          fontSize: 15,
                          color: Color.fromRGBO(76, 81, 97, 1),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.86,
                    height: 109,
                    margin: EdgeInsets.only(
                      top: 40,
                      bottom: 30,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Color.fromRGBO(243, 243, 243, 1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Daftar Osis',
                              style: TextStyle(
                                fontFamily: 'Gilroy-ExtraBold',
                                fontSize: 20,
                                color: Color.fromRGBO(76, 81, 97, 1),
                              ),
                            ),
                            Container(
                              width: 196,
                              height: 48,
                              child: Text(
                                'Untuk menjadi bagian dari OSIS ini, anda harus mendaftar terlebih dahulu',
                                style: TextStyle(
                                  fontFamily: 'Gilroy-Light',
                                  fontSize: 14,
                                  color: Color.fromRGBO(76, 81, 97, 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.32,
                            height: 49,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: Color.fromRGBO(242, 78, 26, 1),
                            ),
                            child: Center(
                              child: Text(
                                'Daftar Disini !!',
                                style: TextStyle(
                                  fontFamily: 'Gilroy-Light',
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment(-0.9, 0.0),
                    child: Text(
                      'Program Kerja',
                      style: TextStyle(
                        fontFamily: 'Gilroy-ExtraBold',
                        fontSize: 16,
                        color: Color.fromRGBO(76, 81, 97, 1),
                        decoration: TextDecoration.underline,
                        decorationColor: Color.fromRGBO(255, 199, 0, 1),
                        decorationThickness: 3,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    height: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    margin: EdgeInsets.only(
                      top: 20,
                      bottom: 10,
                    ),
                    child: SingleChildScrollView(
                      child: DataTable(
                        border: TableBorder.all(
                          color: Color.fromRGBO(0, 0, 0, 0.28),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        headingRowColor: MaterialStateColor.resolveWith(
                          (states) {
                            return Color.fromRGBO(217, 217, 217, 1);
                          },
                        ),
                        columns: [
                          DataColumn(
                              label: Text(
                            'No',
                            style: TextStyle(
                              fontFamily: 'Gilroy-Extrabold',
                              fontSize: 16,
                              color: Color.fromRGBO(76, 81, 97, 1),
                            ),
                          )),
                          DataColumn(
                              label: Text(
                            'Nama',
                            style: TextStyle(
                              fontFamily: 'Gilroy-Extrabold',
                              fontSize: 16,
                              color: Color.fromRGBO(76, 81, 97, 1),
                            ),
                          )),
                          DataColumn(
                            label: Text(
                              'Kelas',
                              style: TextStyle(
                                fontFamily: 'Gilroy-Extrabold',
                                fontSize: 16,
                                color: Color.fromRGBO(76, 81, 97, 1),
                              ),
                            ),
                          ),
                        ],
                        rows: _list
                            .map((data) => DataRow(
                                  cells: [
                                    DataCell(
                                      Text(
                                        data.id.toString(),
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                          fontSize: 13,
                                          color: Color.fromRGBO(76, 81, 97, 1),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        data.name,
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                          fontSize: 13,
                                          color: Color.fromRGBO(76, 81, 97, 1),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Container(
                                        width: data.id % 2 == 0 ? 97 : 84.21,
                                        height: 21,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: data.id % 2 == 0
                                              ? Color.fromRGBO(119, 115, 205, 1)
                                              : Color.fromRGBO(255, 199, 0, 1),
                                        ),
                                        child: Center(
                                          child: Text(
                                            data.id % 2 == 0
                                                ? 'Dilaksanakan'
                                                : 'Terlaksana',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy-Light',
                                              fontSize: 13,
                                              color:
                                                  data.id % 2 == 0
                                                  ? Colors.white
                                                  : Color.fromRGBO(
                                                      76, 81, 97, 1),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(-0.9, 0.0),
                    child: Text(
                      'Dokumentasi Kegiatan',
                      style: TextStyle(
                        fontFamily: 'Gilroy-ExtraBold',
                        fontSize: 16,
                        color: Color.fromRGBO(76, 81, 97, 1),
                        decoration: TextDecoration.underline,
                        decorationColor: Color.fromRGBO(255, 199, 0, 1),
                        decorationThickness: 3,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    height: 410,
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: GridView.builder(
                        itemCount: _list.length,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent:
                              MediaQuery.of(context).size.width * 0.95,
                          mainAxisExtent: 116,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemBuilder: ((context, i) {
                          return Container(
                            margin: EdgeInsets.all(3),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 132,
                                  height: 102,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  child: Image.asset(
                                    'assets/images/dokumentasi.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.63,
                                  height: 82,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Juara II Jambore Tingkat Jawa Timur',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-ExtraBold',
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        'Alhamdulillah, salah satu wakil dari SDIT Insan Mulia berhasil memenangkan lomba pildacil dalam kegiatan Jambore Ranting Tambun Utara. Dhafin berhasil menyabet juara 2 dalam lomba tersebut.',
                                        maxLines: 4,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                          fontSize: 13,
                                          color: Color.fromRGBO(76, 81, 97, 1),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        })),
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
