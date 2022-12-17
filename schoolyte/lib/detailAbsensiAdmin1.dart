import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'model.dart';
import 'detailAbsensiAdmin2.dart';

class DetailAbsensiAdmin1 extends StatefulWidget {
  @override
  _DetailAbsensiAdmin1State createState() => new _DetailAbsensiAdmin1State();
}

class _DetailAbsensiAdmin1State extends State<DetailAbsensiAdmin1> {
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
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Color.fromRGBO(180, 176, 255, 1),
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Color.fromRGBO(229, 229, 229, 1),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(75),
            child: AppBar(
              backgroundColor: Color.fromRGBO(180, 176, 255, 1),
              title: Align(
                alignment: Alignment(-0.7, 0.0),
                child: Text(
                  'Siswa',
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
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: loading
                ? Center(
                    child: CircularProgressIndicator(
                        color: Color.fromRGBO(119, 115, 255, 1)),
                  )
                : SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 220,
                          color: Colors.white,
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment(-0.85, 0.0),
                                child: Container(
                                  margin: EdgeInsets.only(top: 30),
                                  child: Text(
                                    'Pilih Kelas',
                                    style: TextStyle(
                                      fontFamily: 'Gilroy-ExtraBold',
                                      fontSize: 24,
                                      color: Color.fromRGBO(76, 81, 97, 1),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: 118,
                                margin: EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.244,
                                      height: 118,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(14),
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
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.244,
                                            height: 39,
                                            decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  119, 115, 205, 1),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(14),
                                                topRight: Radius.circular(14),
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'Kelas 10',
                                                style: TextStyle(
                                                  fontFamily:
                                                      'Gilroy-ExtraBold',
                                                  fontSize: 19,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.183,
                                            height: 61,
                                            margin: EdgeInsets.only(bottom: 8),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.183,
                                                  height: 24,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.person,
                                                        size: 24,
                                                        color: Color.fromRGBO(
                                                            180, 176, 255, 1),
                                                      ),
                                                      Text(
                                                        '120 Siswa',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-Light',
                                                          fontSize: 14,
                                                          color: Color.fromRGBO(
                                                              76, 81, 97, 1),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.183,
                                                  height: 24,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.dns,
                                                        size: 24,
                                                        color: Color.fromRGBO(
                                                            180, 176, 255, 1),
                                                      ),
                                                      Text(
                                                        '4 Kelas',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-Light',
                                                          fontSize: 14,
                                                          color: Color.fromRGBO(
                                                              76, 81, 97, 1),
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
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.244,
                                      height: 118,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(14),
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
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.244,
                                            height: 39,
                                            decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  119, 115, 205, 1),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(14),
                                                topRight: Radius.circular(14),
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'Kelas 11',
                                                style: TextStyle(
                                                  fontFamily:
                                                      'Gilroy-ExtraBold',
                                                  fontSize: 19,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.183,
                                            height: 61,
                                            margin: EdgeInsets.only(bottom: 8),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.183,
                                                  height: 24,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.person,
                                                        size: 24,
                                                        color: Color.fromRGBO(
                                                            180, 176, 255, 1),
                                                      ),
                                                      Text(
                                                        '120 Siswa',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-Light',
                                                          fontSize: 14,
                                                          color: Color.fromRGBO(
                                                              76, 81, 97, 1),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.183,
                                                  height: 24,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.dns,
                                                        size: 24,
                                                        color: Color.fromRGBO(
                                                            180, 176, 255, 1),
                                                      ),
                                                      Text(
                                                        '4 Kelas',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-Light',
                                                          fontSize: 14,
                                                          color: Color.fromRGBO(
                                                              76, 81, 97, 1),
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
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.244,
                                      height: 118,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(14),
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
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.244,
                                            height: 39,
                                            decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  119, 115, 205, 1),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(14),
                                                topRight: Radius.circular(14),
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'Kelas 12',
                                                style: TextStyle(
                                                  fontFamily:
                                                      'Gilroy-ExtraBold',
                                                  fontSize: 19,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.183,
                                            height: 61,
                                            margin: EdgeInsets.only(bottom: 8),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.183,
                                                  height: 24,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.person,
                                                        size: 24,
                                                        color: Color.fromRGBO(
                                                            180, 176, 255, 1),
                                                      ),
                                                      Text(
                                                        '120 Siswa',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-Light',
                                                          fontSize: 14,
                                                          color: Color.fromRGBO(
                                                              76, 81, 97, 1),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.183,
                                                  height: 24,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.dns,
                                                        size: 24,
                                                        color: Color.fromRGBO(
                                                            180, 176, 255, 1),
                                                      ),
                                                      Text(
                                                        '4 Kelas',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-Light',
                                                          fontSize: 14,
                                                          color: Color.fromRGBO(
                                                              76, 81, 97, 1),
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
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.65,
                          padding: EdgeInsets.all(20),
                          child: GridView.builder(
                              itemCount: 3,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                mainAxisExtent: 54,
                                mainAxisSpacing: 15,
                              ),
                              itemBuilder: (context, i) {
                                final kelas = _list[i];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DetailAbsensiAdmin2()));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(2),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
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
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Kelas 1${i} IPA ${kelas.id}',
                                          style: TextStyle(
                                            fontFamily: 'Gilroy-ExtraBold',
                                            fontSize: 16,
                                            color:
                                                Color.fromRGBO(76, 81, 97, 1),
                                          ),
                                        ),
                                        Icon(
                                          Icons.chevron_right_rounded,
                                          size: 24,
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
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
