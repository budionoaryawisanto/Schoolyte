import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:schoolyte/kantin.dart';
import 'package:schoolyte/main.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:http/http.dart' as http;
import 'package:schoolyte/pembayaran.dart';
import 'package:schoolyte/scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model.dart';

class DetailMenu extends StatefulWidget {
  Stand kantin;
  DetailMenu({required this.kantin});
  @override
  _DetailMenuState createState() => new _DetailMenuState(kantin);
}

class _DetailMenuState extends State<DetailMenu> {
  List<Menu> _menu = [];
  var loading = false;
  var _count = [];

  Future fetchData() async {
    setState(() {
      loading = true;
    });
    _menu.clear();
    final response = await http.get(Uri.parse(Api.getMenu));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      for (Map<String, dynamic> i in data) {
        _menu.add(Menu.formJson(i));
      }
      _menu.forEach((menu) {
        _count.add(0);
      });
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Stand kantin;
  _DetailMenuState(this.kantin);

  int saldo = 40000;
  int total = 30000;
  var pay = false;

  String? _result;

  Future openScanner(BuildContext context) async {
    final result = Navigator.of(context)
        .pushNamedAndRemoveUntil('/scanner', (Route<dynamic> route) => false);
    _result = result as String?;
  }

  convertToIdr(dynamic number, int decimalDigit) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(number);
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
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(75),
              child: AppBar(
                backgroundColor: Colors.white,
                title: Align(
                  alignment: Alignment(-0.7, 0.0),
                  child: Text(
                    'Dapur ' +
                        kantin.nama_stand +
                        ', Kode : ${kantin.kode_stand}',
                    style: TextStyle(
                      fontFamily: 'Gilroy-ExtraBold',
                      fontSize: 20,
                      color: Color.fromRGBO(76, 81, 97, 1),
                    ),
                  ),
                ),
                elevation: 0.0,
                iconTheme:
                    IconThemeData(color: Color.fromRGBO(217, 217, 217, 1)),
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
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.83,
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
                                    'Menu',
                                    style: TextStyle(
                                      fontFamily: 'Gilroy-ExtraBold',
                                      fontSize: 20,
                                      color: Color.fromRGBO(76, 81, 97, 1),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.8,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 5,
                                  ),
                                  child: loading
                                      ? Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : GridView.builder(
                                          itemCount: _menu.length,
                                          gridDelegate:
                                              SliverGridDelegateWithMaxCrossAxisExtent(
                                            maxCrossAxisExtent: 217,
                                            mainAxisExtent: 116,
                                            mainAxisSpacing: 5,
                                            crossAxisSpacing: 10,
                                          ),
                                          itemBuilder: (context, i) {
                                            final menu = _menu[i];
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
                                                    child: new Image.network(
                                                      Api.image + menu.image,
                                                      fit: BoxFit.cover,
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
                                                          menu.nama_menu,
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
                                                          convertToIdr(
                                                              int.parse(
                                                                  menu.harga),
                                                              0),
                                                          maxLines: 1,
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
                                                                  if (_count[
                                                                          i] >=
                                                                      1) {
                                                                    setState(
                                                                        () {
                                                                      _count[
                                                                          i]--;
                                                                    });
                                                                    if (_count[
                                                                            i] ==
                                                                        0) {
                                                                      setState(
                                                                          () {
                                                                        pay =
                                                                            false;
                                                                      });
                                                                    }
                                                                  }
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
                                                                _count[i]
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
                                                                    _count[i]++;
                                                                    pay = true;
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
                            visible: pay,
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
