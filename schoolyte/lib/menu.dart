import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:schoolyte/kantin.dart';
import 'package:schoolyte/main.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:http/http.dart' as http;
import 'package:schoolyte/pembayaran.dart';
import 'package:schoolyte/scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => new _MenuState();
}

class _MenuState extends State<Menu> {
  List<Test> _list = [];
  List<Test> _kantin = [];

  var loading = false;
  var count = 0;

  Future<Null> fetchData() async {
    setState(() {
      loading = true;
    });
    _list.clear();
    _kantin.clear();
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      getNamaKantin();
      setState(() {
        for (Map<String, dynamic> i in data) {
          _list.add(Test.formJson(i));
          loading = false;
        }
      });
    }
  }

  getNamaKantin() async {
    final prefs = await SharedPreferences.getInstance();
    var namaKantin = prefs.getString('nama kantin');
    _list.forEach((e) {
      if (e.name.toLowerCase().contains(namaKantin!.toLowerCase())) {
        _kantin.add(e);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    getNamaKantin();
  }

  @override
  int saldo = 40000;
  int total = 30000;

  String? _result;

  Future openScanner(BuildContext context) async {
    final result = Navigator.of(context)
        .pushNamedAndRemoveUntil('/scanner', (Route<dynamic> route) => false);
    _result = result as String?;
  }

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
            body: loading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.97,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 50,
                          margin: EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.chevron_left,
                                  color: Color.fromRGBO(76, 81, 97, 1),
                                  size: 40,
                                ),
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Dapur ' +
                                        _kantin[0].name +
                                        ', Kode: ' +
                                        _kantin[0].id.toString(),
                                    style: TextStyle(
                                      fontFamily: 'Gilroy-ExtraBold',
                                      fontSize: 20,
                                      color: Color.fromRGBO(76, 81, 97, 1),
                                    ),
                                  ),
                                  Text(
                                    'Makanan, Minuman, Gorengan, Snack',
                                    style: TextStyle(
                                      fontFamily: 'Gilroy-Light',
                                      fontSize: 16,
                                      color: Color.fromRGBO(76, 81, 97, 1),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.85,
                          child: SingleChildScrollView(
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
                                      fontFamily: 'Gilroy-ExtraBold',
                                      fontSize: 20,
                                      color: Color.fromRGBO(76, 81, 97, 1),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 250,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 5,
                                  ),
                                  child: loading
                                      ? Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : GridView.builder(
                                          itemCount: 6,
                                          gridDelegate:
                                              SliverGridDelegateWithMaxCrossAxisExtent(
                                            maxCrossAxisExtent: 217,
                                            mainAxisExtent: 116,
                                            mainAxisSpacing: 5,
                                            crossAxisSpacing: 10,
                                          ),
                                          itemBuilder: (context, i) {
                                            return Container(
                                              margin: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
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
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                              ),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 89,
                                                    height: 97,
                                                    margin: EdgeInsets.only(
                                                        left: 10),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    child: new Image.asset(
                                                      'assets/images/mieayam.png',
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Container(
                                                        width: 80,
                                                        margin: EdgeInsets.only(
                                                            left: 15),
                                                        child: Text(
                                                          'Mie Ayam',
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-ExtraBold',
                                                            fontSize: 13,
                                                            color:
                                                                Color.fromRGBO(
                                                                    76,
                                                                    81,
                                                                    97,
                                                                    1),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 80,
                                                        margin: EdgeInsets.only(
                                                            left: 15),
                                                        child: Text(
                                                          'Rp.10.000',
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-Light',
                                                            fontSize: 10,
                                                            color:
                                                                Color.fromRGBO(
                                                                    76,
                                                                    81,
                                                                    97,
                                                                    1),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 90,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              width: 40,
                                                              height: 40,
                                                              child: TextButton(
                                                                onPressed: () {
                                                                  setState(() {
                                                                    if (count !=
                                                                        0) {
                                                                      count--;
                                                                    } else {}
                                                                  });
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: 20,
                                                                  height: 20,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    border:
                                                                        Border
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
                                                                      color: Color
                                                                          .fromRGBO(
                                                                              76,
                                                                              81,
                                                                              97,
                                                                              1),
                                                                      size: 18,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                count
                                                                    .toString(),
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-ExtraBold',
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
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: 20,
                                                                  height: 20,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    border:
                                                                        Border
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
                                                                      color: Color
                                                                          .fromRGBO(
                                                                              76,
                                                                              81,
                                                                              97,
                                                                              1),
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
                                  margin: EdgeInsets.only(
                                    top: 25,
                                    left: 65,
                                  ),
                                  child: Text(
                                    'Minuman',
                                    style: TextStyle(
                                      fontFamily: 'Gilroy-ExtraBold',
                                      fontSize: 20,
                                      color: Color.fromRGBO(76, 81, 97, 1),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 250,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 5,
                                  ),
                                  child: loading
                                      ? Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : GridView.builder(
                                          itemCount: 6,
                                          gridDelegate:
                                              SliverGridDelegateWithMaxCrossAxisExtent(
                                            maxCrossAxisExtent: 217,
                                            mainAxisExtent: 116,
                                            mainAxisSpacing: 5,
                                            crossAxisSpacing: 10,
                                          ),
                                          itemBuilder: (context, i) {
                                            return Container(
                                              margin: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
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
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                              ),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 89,
                                                    height: 97,
                                                    margin: EdgeInsets.only(
                                                        left: 10),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    child: new Image.asset(
                                                      'assets/images/esteh.png',
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Container(
                                                        width: 80,
                                                        margin: EdgeInsets.only(
                                                            left: 15),
                                                        child: Text(
                                                          'Es Teh',
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-ExtraBold',
                                                            fontSize: 13,
                                                            color:
                                                                Color.fromRGBO(
                                                                    76,
                                                                    81,
                                                                    97,
                                                                    1),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 80,
                                                        margin: EdgeInsets.only(
                                                            left: 15),
                                                        child: Text(
                                                          'Rp.3.000',
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-Light',
                                                            fontSize: 10,
                                                            color:
                                                                Color.fromRGBO(
                                                                    76,
                                                                    81,
                                                                    97,
                                                                    1),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 90,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              width: 40,
                                                              height: 40,
                                                              child: TextButton(
                                                                onPressed: () {
                                                                  setState(() {
                                                                    if (count !=
                                                                        0) {
                                                                      count--;
                                                                    } else {}
                                                                  });
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: 20,
                                                                  height: 20,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      width: 1,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                  child: Center(
                                                                    child: Icon(
                                                                      Icons
                                                                          .remove,
                                                                      color: Colors
                                                                          .black,
                                                                      size: 18,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                count
                                                                    .toString(),
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-ExtraBold',
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
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: 20,
                                                                  height: 20,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      width: 1,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                  child: Center(
                                                                    child: Icon(
                                                                      Icons.add,
                                                                      color: Colors
                                                                          .black,
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
                                  margin: EdgeInsets.only(
                                    top: 25,
                                    left: 65,
                                  ),
                                  child: Text(
                                    'Jajanan',
                                    style: TextStyle(
                                      fontFamily: 'Gilroy-ExtraBold',
                                      fontSize: 20,
                                      color: Color.fromRGBO(76, 81, 97, 1),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 250,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 5,
                                  ),
                                  child: loading
                                      ? Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : GridView.builder(
                                          itemCount: 6,
                                          gridDelegate:
                                              SliverGridDelegateWithMaxCrossAxisExtent(
                                            maxCrossAxisExtent: 217,
                                            mainAxisExtent: 116,
                                            mainAxisSpacing: 5,
                                            crossAxisSpacing: 10,
                                          ),
                                          itemBuilder: (context, i) {
                                            return Container(
                                              margin: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
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
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                              ),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 89,
                                                    height: 97,
                                                    margin: EdgeInsets.only(
                                                        left: 10),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    child: new Image.asset(
                                                      'assets/images/mieayam.png',
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Container(
                                                        width: 80,
                                                        margin: EdgeInsets.only(
                                                            left: 15),
                                                        child: Text(
                                                          'Tahu Isi',
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-ExtraBold',
                                                            fontSize: 13,
                                                            color:
                                                                Color.fromRGBO(
                                                                    76,
                                                                    81,
                                                                    97,
                                                                    1),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 80,
                                                        margin: EdgeInsets.only(
                                                            left: 15),
                                                        child: Text(
                                                          'Rp.2.000',
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-Light',
                                                            fontSize: 10,
                                                            color:
                                                                Color.fromRGBO(
                                                                    76,
                                                                    81,
                                                                    97,
                                                                    1),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 90,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              width: 40,
                                                              height: 40,
                                                              child: TextButton(
                                                                onPressed: () {
                                                                  setState(() {
                                                                    if (count !=
                                                                        0) {
                                                                      count--;
                                                                    } else {}
                                                                  });
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: 20,
                                                                  height: 20,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    border:
                                                                        Border
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
                                                                      color: Color
                                                                          .fromRGBO(
                                                                              76,
                                                                              81,
                                                                              97,
                                                                              1),
                                                                      size: 18,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                count
                                                                    .toString(),
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-ExtraBold',
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
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: 20,
                                                                  height: 20,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    border:
                                                                        Border
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
                                                                      color: Color
                                                                          .fromRGBO(
                                                                              76,
                                                                              81,
                                                                              97,
                                                                              1),
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
                          alignment: Alignment(0.0, 1.0),
                          child: Visibility(
                            visible: count > 0 ? true : false,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: 41,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color.fromRGBO(119, 115, 205, 1),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Text(
                                      'Total Bayar',
                                      style: TextStyle(
                                        fontFamily: 'Gilroy-ExtraBold',
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 20),
                                        child: Text(
                                          'Rp. ' + total.toString(),
                                          style: TextStyle(
                                            fontFamily: 'Gilroy-ExtraBold',
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Pembayaran()));
                                        },
                                        child: Container(
                                          width: 99,
                                          height: 35,
                                          margin: EdgeInsets.only(right: 10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                          ),
                                          child: Center(
                                            child: Text(
                                              'Bayar',
                                              style: TextStyle(
                                                fontFamily: 'Gilroy-ExtraBold',
                                                fontSize: 16,
                                                color: Color.fromRGBO(
                                                    119, 115, 205, 1),
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
                          ),
                        ),
                      ],
                    ),
                  ))),
      ),
    );
  }
}
