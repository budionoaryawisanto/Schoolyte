import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'model.dart';

class DetailNilaiBelajarAdminProfil extends StatefulWidget {
  Test profil;
  DetailNilaiBelajarAdminProfil({super.key, required this.profil});
  @override
  _DetailNilaiBelajarAdminProfilState createState() =>
      new _DetailNilaiBelajarAdminProfilState(profil);
}

class _DetailNilaiBelajarAdminProfilState
    extends State<DetailNilaiBelajarAdminProfil> {
  List<Test> _siswa = [];

  var loading = false;

  Future<Null> fetchData() async {
    setState(() {
      loading = true;
    });
    _siswa.clear();
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        for (Map<String, dynamic> i in data) {
          _siswa.add(Test.formJson(i));
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

  var mapel = ['Matematika', 'Bahasa Indonesia', 'Bahasa Inggris'];

  List<Tab> myTabs = <Tab>[
    Tab(text: 'Pengetahuan'),
    Tab(text: 'Keterampilan'),
  ];

  @override
  Test profil;
  _DetailNilaiBelajarAdminProfilState(this.profil);
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Color.fromRGBO(255, 217, 102, 1),
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: DefaultTabController(
          length: myTabs.length,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(75),
              child: AppBar(
                backgroundColor: Color.fromRGBO(255, 217, 102, 1),
                title: Align(
                  alignment: Alignment(-0.7, 0.0),
                  child: Text(
                    'Nilai Belajar',
                    style: TextStyle(
                      fontFamily: 'Gilroy-ExtraBold',
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
                elevation: 0.0,
                iconTheme: IconThemeData(color: Colors.white),
                leading: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Align(
                    alignment: Alignment(1.0, 0.0),
                    child: Icon(
                      Icons.chevron_left_rounded,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
              ),
            ),
            body: loading
                ? Center(
                    child: CircularProgressIndicator(
                        color: Color.fromRGBO(255, 217, 102, 1)),
                  )
                : Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.85,
                            height: 115,
                            margin: EdgeInsets.only(
                              top: 20,
                              bottom: 20,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipOval(
                                  child: Image.asset(
                                    'assets/images/profil.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.55,
                                  height: 102,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        profil.name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-ExtraBold',
                                          fontSize: 22,
                                        ),
                                      ),
                                      Text(
                                        'NIS : ${profil.phone}',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                          fontSize: 16,
                                          color: Color.fromRGBO(76, 81, 97, 1),
                                        ),
                                      ),
                                      Text(
                                        'Kelas : X IPA ${profil.id}',
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                          fontSize: 16,
                                          color: Color.fromRGBO(76, 81, 97, 1),
                                        ),
                                      ),
                                      Text(
                                        'Tahun Ajaran : 2020/2021',
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                          fontSize: 16,
                                          color: Color.fromRGBO(76, 81, 97, 1),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Color.fromRGBO(217, 217, 217, 1),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 79,
                            child: Center(
                              child: TabBar(
                                padding: EdgeInsets.only(bottom: 10),
                                indicatorColor: Color.fromRGBO(76, 81, 97, 1),
                                indicatorSize: TabBarIndicatorSize.label,
                                labelColor: Color.fromRGBO(76, 81, 97, 1),
                                unselectedLabelColor:
                                    Color.fromRGBO(76, 81, 97, 1),
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
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.63,
                            child: TabBarView(
                              children: [
                                SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Align(
                                        alignment: Alignment(-0.9, 0.0),
                                        child: Text(
                                          'Semester Ganjil',
                                          style: TextStyle(
                                            fontFamily: 'Gilroy-ExtraBold',
                                            fontSize: 18,
                                            color:
                                                Color.fromRGBO(76, 81, 97, 1),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 335,
                                        margin: EdgeInsets.only(
                                          bottom: 20,
                                        ),
                                        child: GridView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: mapel.length,
                                          padding: EdgeInsets.all(10),
                                          gridDelegate:
                                              SliverGridDelegateWithMaxCrossAxisExtent(
                                            maxCrossAxisExtent: 330,
                                            mainAxisExtent: 461,
                                            mainAxisSpacing: 10,
                                          ),
                                          itemBuilder: (context, i) {
                                            return Container(
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.2),
                                                    spreadRadius: 0,
                                                    blurRadius: 1.5,
                                                    offset: Offset(0, 0),
                                                  )
                                                ],
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    height: 47,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 40,
                                                      vertical: 10,
                                                    ),
                                                    child: Text(
                                                      mapel[i],
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Gilroy-ExtraBold',
                                                        fontSize: 20,
                                                        color: Color.fromRGBO(
                                                            76, 81, 97, 1),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 0.25,
                                                          color: Color.fromRGBO(
                                                              76,
                                                              81,
                                                              97,
                                                              0.37)),
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    height: 198,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 40,
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              child: Text(
                                                                'Tugas 1',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-light',
                                                                  fontSize: 16,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          76,
                                                                          81,
                                                                          97,
                                                                          1),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                '88',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-ExtraBold',
                                                                  fontSize: 16,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          76,
                                                                          81,
                                                                          97,
                                                                          1),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              child: Text(
                                                                'Tugas 2',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-light',
                                                                  fontSize: 16,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          76,
                                                                          81,
                                                                          97,
                                                                          1),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                '88',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-ExtraBold',
                                                                  fontSize: 16,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          76,
                                                                          81,
                                                                          97,
                                                                          1),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              child: Text(
                                                                'Tugas 3',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-light',
                                                                  fontSize: 16,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          76,
                                                                          81,
                                                                          97,
                                                                          1),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                '88',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-ExtraBold',
                                                                  fontSize: 16,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          76,
                                                                          81,
                                                                          97,
                                                                          1),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              child: Text(
                                                                'UTS',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-light',
                                                                  fontSize: 16,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          76,
                                                                          81,
                                                                          97,
                                                                          1),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                '-',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-ExtraBold',
                                                                  fontSize: 16,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          76,
                                                                          81,
                                                                          97,
                                                                          1),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              child: Text(
                                                                'UAS',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-light',
                                                                  fontSize: 16,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          76,
                                                                          81,
                                                                          97,
                                                                          1),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                '-',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-ExtraBold',
                                                                  fontSize: 16,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          76,
                                                                          81,
                                                                          97,
                                                                          1),
                                                                ),
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
                                                    height: 47,
                                                    padding: EdgeInsets.only(
                                                      left: 120,
                                                      right: 70,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(10),
                                                        bottomRight:
                                                            Radius.circular(10),
                                                      ),
                                                      color: Color.fromRGBO(
                                                          243, 243, 243, 1),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Total (rata-rata)',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-ExtraBold',
                                                            fontSize: 16,
                                                            color:
                                                                Color.fromRGBO(
                                                                    76,
                                                                    81,
                                                                    97,
                                                                    1),
                                                          ),
                                                        ),
                                                        Text(
                                                          '88',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-ExtraBold',
                                                            fontSize: 16,
                                                            color:
                                                                Color.fromRGBO(
                                                                    76,
                                                                    81,
                                                                    97,
                                                                    1),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment(-0.9, 0.0),
                                        child: Text(
                                          'Semester Genap',
                                          style: TextStyle(
                                            fontFamily: 'Gilroy-ExtraBold',
                                            fontSize: 18,
                                            color:
                                                Color.fromRGBO(76, 81, 97, 1),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 335,
                                        margin: EdgeInsets.only(
                                          bottom: 10,
                                        ),
                                        child: GridView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: mapel.length,
                                          padding: EdgeInsets.all(10),
                                          gridDelegate:
                                              SliverGridDelegateWithMaxCrossAxisExtent(
                                            maxCrossAxisExtent: 330,
                                            mainAxisExtent: 461,
                                            mainAxisSpacing: 10,
                                          ),
                                          itemBuilder: (context, i) {
                                            return Container(
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.2),
                                                    spreadRadius: 0,
                                                    blurRadius: 1.5,
                                                    offset: Offset(0, 0),
                                                  )
                                                ],
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    height: 47,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 40,
                                                      vertical: 10,
                                                    ),
                                                    child: Text(
                                                      mapel[i],
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Gilroy-ExtraBold',
                                                        fontSize: 20,
                                                        color: Color.fromRGBO(
                                                            76, 81, 97, 1),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 0.25,
                                                          color: Color.fromRGBO(
                                                              76,
                                                              81,
                                                              97,
                                                              0.37)),
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    height: 198,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 40,
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              child: Text(
                                                                'Tugas 1',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-light',
                                                                  fontSize: 16,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          76,
                                                                          81,
                                                                          97,
                                                                          1),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                '88',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-ExtraBold',
                                                                  fontSize: 16,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          76,
                                                                          81,
                                                                          97,
                                                                          1),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              child: Text(
                                                                'Tugas 2',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-light',
                                                                  fontSize: 16,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          76,
                                                                          81,
                                                                          97,
                                                                          1),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                '88',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-ExtraBold',
                                                                  fontSize: 16,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          76,
                                                                          81,
                                                                          97,
                                                                          1),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              child: Text(
                                                                'Tugas 3',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-light',
                                                                  fontSize: 16,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          76,
                                                                          81,
                                                                          97,
                                                                          1),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                '88',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-ExtraBold',
                                                                  fontSize: 16,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          76,
                                                                          81,
                                                                          97,
                                                                          1),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              child: Text(
                                                                'UTS',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-light',
                                                                  fontSize: 16,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          76,
                                                                          81,
                                                                          97,
                                                                          1),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                '-',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-ExtraBold',
                                                                  fontSize: 16,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          76,
                                                                          81,
                                                                          97,
                                                                          1),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              child: Text(
                                                                'UAS',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-light',
                                                                  fontSize: 16,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          76,
                                                                          81,
                                                                          97,
                                                                          1),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                '-',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-ExtraBold',
                                                                  fontSize: 16,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          76,
                                                                          81,
                                                                          97,
                                                                          1),
                                                                ),
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
                                                    height: 47,
                                                    padding: EdgeInsets.only(
                                                      left: 120,
                                                      right: 70,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(10),
                                                        bottomRight:
                                                            Radius.circular(10),
                                                      ),
                                                      color: Color.fromRGBO(
                                                          243, 243, 243, 1),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Total (rata-rata)',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-ExtraBold',
                                                            fontSize: 16,
                                                            color:
                                                                Color.fromRGBO(
                                                                    76,
                                                                    81,
                                                                    97,
                                                                    1),
                                                          ),
                                                        ),
                                                        Text(
                                                          '88',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-ExtraBold',
                                                            fontSize: 16,
                                                            color:
                                                                Color.fromRGBO(
                                                                    76,
                                                                    81,
                                                                    97,
                                                                    1),
                                                          ),
                                                        ),
                                                      ],
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
                                SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Align(
                                        alignment: Alignment(-0.9, 0.0),
                                        child: Text(
                                          'Semester Ganjil',
                                          style: TextStyle(
                                            fontFamily: 'Gilroy-ExtraBold',
                                            fontSize: 18,
                                            color:
                                                Color.fromRGBO(76, 81, 97, 1),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 335,
                                        margin: EdgeInsets.only(
                                          bottom: 20,
                                        ),
                                        child: GridView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: mapel.length,
                                          padding: EdgeInsets.all(10),
                                          gridDelegate:
                                              SliverGridDelegateWithMaxCrossAxisExtent(
                                            maxCrossAxisExtent: 330,
                                            mainAxisExtent: 461,
                                            mainAxisSpacing: 10,
                                          ),
                                          itemBuilder: (context, i) {
                                            return Container(
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.2),
                                                    spreadRadius: 0,
                                                    blurRadius: 1.5,
                                                    offset: Offset(0, 0),
                                                  )
                                                ],
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    height: 47,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 40,
                                                      vertical: 10,
                                                    ),
                                                    child: Text(
                                                      mapel[i],
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Gilroy-ExtraBold',
                                                        fontSize: 20,
                                                        color: Color.fromRGBO(
                                                            76, 81, 97, 1),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 0.25,
                                                          color: Color.fromRGBO(
                                                              76,
                                                              81,
                                                              97,
                                                              0.37)),
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    height: 198,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 40,
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              child: Text(
                                                                'Tugas Keterampilan 1',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-light',
                                                                  fontSize: 16,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          76,
                                                                          81,
                                                                          97,
                                                                          1),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                '88',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-ExtraBold',
                                                                  fontSize: 16,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          76,
                                                                          81,
                                                                          97,
                                                                          1),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              child: Text(
                                                                'Tugas Keterampilan 2',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-light',
                                                                  fontSize: 16,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          76,
                                                                          81,
                                                                          97,
                                                                          1),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                '88',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-ExtraBold',
                                                                  fontSize: 16,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          76,
                                                                          81,
                                                                          97,
                                                                          1),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              child: Text(
                                                                'Tugas Keterampilan 3',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-light',
                                                                  fontSize: 16,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          76,
                                                                          81,
                                                                          97,
                                                                          1),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                '88',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-ExtraBold',
                                                                  fontSize: 16,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          76,
                                                                          81,
                                                                          97,
                                                                          1),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              child: Text(
                                                                'UTS',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-light',
                                                                  fontSize: 16,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          76,
                                                                          81,
                                                                          97,
                                                                          1),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                '-',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-ExtraBold',
                                                                  fontSize: 16,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          76,
                                                                          81,
                                                                          97,
                                                                          1),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              child: Text(
                                                                'UAS',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-light',
                                                                  fontSize: 16,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          76,
                                                                          81,
                                                                          97,
                                                                          1),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                '-',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-ExtraBold',
                                                                  fontSize: 16,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          76,
                                                                          81,
                                                                          97,
                                                                          1),
                                                                ),
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
                                                    height: 47,
                                                    padding: EdgeInsets.only(
                                                      left: 120,
                                                      right: 70,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(10),
                                                        bottomRight:
                                                            Radius.circular(10),
                                                      ),
                                                      color: Color.fromRGBO(
                                                          243, 243, 243, 1),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Total (rata-rata)',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-ExtraBold',
                                                            fontSize: 16,
                                                            color:
                                                                Color.fromRGBO(
                                                                    76,
                                                                    81,
                                                                    97,
                                                                    1),
                                                          ),
                                                        ),
                                                        Text(
                                                          '88',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-ExtraBold',
                                                            fontSize: 16,
                                                            color:
                                                                Color.fromRGBO(
                                                                    76,
                                                                    81,
                                                                    97,
                                                                    1),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment(-0.9, 0.0),
                                        child: Text(
                                          'Semester Genap',
                                          style: TextStyle(
                                            fontFamily: 'Gilroy-ExtraBold',
                                            fontSize: 18,
                                            color:
                                                Color.fromRGBO(76, 81, 97, 1),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 335,
                                        margin: EdgeInsets.only(
                                          bottom: 10,
                                        ),
                                        child: GridView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: mapel.length,
                                          padding: EdgeInsets.all(10),
                                          gridDelegate:
                                              SliverGridDelegateWithMaxCrossAxisExtent(
                                            maxCrossAxisExtent: 330,
                                            mainAxisExtent: 461,
                                            mainAxisSpacing: 10,
                                          ),
                                          itemBuilder: (context, i) {
                                            return Container(
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.2),
                                                    spreadRadius: 0,
                                                    blurRadius: 1.5,
                                                    offset: Offset(0, 0),
                                                  )
                                                ],
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    height: 47,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 40,
                                                      vertical: 10,
                                                    ),
                                                    child: Text(
                                                      mapel[i],
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Gilroy-ExtraBold',
                                                        fontSize: 20,
                                                        color: Color.fromRGBO(
                                                            76, 81, 97, 1),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 0.25,
                                                          color: Color.fromRGBO(
                                                              76,
                                                              81,
                                                              97,
                                                              0.37)),
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    height: 198,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 40,
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              child: Text(
                                                                'Tugas Keterampilan 1',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-light',
                                                                  fontSize: 16,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          76,
                                                                          81,
                                                                          97,
                                                                          1),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                '88',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-ExtraBold',
                                                                  fontSize: 16,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          76,
                                                                          81,
                                                                          97,
                                                                          1),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              child: Text(
                                                                'Tugas Keterampilan 2',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-light',
                                                                  fontSize: 16,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          76,
                                                                          81,
                                                                          97,
                                                                          1),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                '88',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-ExtraBold',
                                                                  fontSize: 16,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          76,
                                                                          81,
                                                                          97,
                                                                          1),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              child: Text(
                                                                'Tugas Keterampilan 3',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-light',
                                                                  fontSize: 16,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          76,
                                                                          81,
                                                                          97,
                                                                          1),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                '88',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-ExtraBold',
                                                                  fontSize: 16,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          76,
                                                                          81,
                                                                          97,
                                                                          1),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              child: Text(
                                                                'UTS',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-light',
                                                                  fontSize: 16,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          76,
                                                                          81,
                                                                          97,
                                                                          1),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                '-',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-ExtraBold',
                                                                  fontSize: 16,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          76,
                                                                          81,
                                                                          97,
                                                                          1),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              child: Text(
                                                                'UAS',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-light',
                                                                  fontSize: 16,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          76,
                                                                          81,
                                                                          97,
                                                                          1),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                '-',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-ExtraBold',
                                                                  fontSize: 16,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          76,
                                                                          81,
                                                                          97,
                                                                          1),
                                                                ),
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
                                                    height: 47,
                                                    padding: EdgeInsets.only(
                                                      left: 120,
                                                      right: 70,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(10),
                                                        bottomRight:
                                                            Radius.circular(10),
                                                      ),
                                                      color: Color.fromRGBO(
                                                          243, 243, 243, 1),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Total (rata-rata)',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-ExtraBold',
                                                            fontSize: 16,
                                                            color:
                                                                Color.fromRGBO(
                                                                    76,
                                                                    81,
                                                                    97,
                                                                    1),
                                                          ),
                                                        ),
                                                        Text(
                                                          '88',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-ExtraBold',
                                                            fontSize: 16,
                                                            color:
                                                                Color.fromRGBO(
                                                                    76,
                                                                    81,
                                                                    97,
                                                                    1),
                                                          ),
                                                        ),
                                                      ],
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
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
