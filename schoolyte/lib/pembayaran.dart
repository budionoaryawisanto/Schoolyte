import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:schoolyte/kantin.dart';
import 'package:http/http.dart' as http;
import 'package:schoolyte/scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model.dart';

class Pembayaran extends StatefulWidget {
  @override
  _PembayaranState createState() => new _PembayaranState();
}

class _PembayaranState extends State<Pembayaran> {
  List<Test> _list = [];
  List<Test> _kantin = [];
  var loading = false;

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

  TextEditingController catatanController = TextEditingController();

  String? _result;

  Future openScanner(BuildContext context) async {
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => Scanner()));
    setState(() {
      _result = result;
    });
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
                      color: Color.fromRGBO(243, 243, 243, 1),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 100,
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    _result != null
                                        ? Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    KantinPage()))
                                        : Navigator.pop(context);
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
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.40,
                            padding: EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 25,
                            ),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(243, 243, 243, 1),
                            ),
                            child: loading
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : GridView.builder(
                                    itemCount: 5,
                                    gridDelegate:
                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 400,
                                      mainAxisExtent: 105,
                                      mainAxisSpacing: 15,
                                      crossAxisSpacing: 15,
                                    ),
                                    itemBuilder: (context, i) {
                                      return Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.3),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 82,
                                              height: 83,
                                              child: new Image.asset(
                                                'assets/images/mieayam.png',
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.60,
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              margin: EdgeInsets.only(left: 10),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    child: Text(
                                                      '1x Mie Ayam Jakarta',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Gilroy-ExtraBold',
                                                        fontSize: 16,
                                                        color: Color.fromRGBO(
                                                            76, 81, 97, 1),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 10),
                                                          child: Text(
                                                            'Rp.10.000',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-Light',
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
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 100,
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: Text(
                                    'Catatan: ',
                                    style: TextStyle(
                                      fontFamily: 'Gilroy-Light',
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  margin: EdgeInsets.only(left: 10),
                                  child: TextFormField(
                                    style: TextStyle(
                                      fontFamily: 'Gilroy-Light',
                                      fontSize: 18,
                                    ),
                                    textInputAction: TextInputAction.done,
                                    controller: catatanController,
                                    autocorrect: true,
                                    decoration: new InputDecoration(
                                      // enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      hintText: 'Masukan pesan anda disini',
                                      hintStyle: TextStyle(
                                        fontFamily: 'Gilroy-Light',
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            width: MediaQuery.of(context).size.width,
                            height: 100,
                            color: Colors.white,
                            margin: EdgeInsets.only(top: 15),
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Container(
                              child: Text(
                                'Saldo Anda:  ' + saldo.toString(),
                                style: TextStyle(
                                  fontFamily: 'Gilroy-ExtraBold',
                                  fontSize: 20,
                                  color: Color.fromRGBO(76, 81, 97, 1),
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: _result != null
                                ? Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    height: 58,
                                    margin: EdgeInsets.only(top: 180),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Berhasil',
                                      ),
                                    ),
                                  )
                                : Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    height: 58,
                                    margin: EdgeInsets.only(top: 180),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.6,
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                            ),
                                            color: Colors.white,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Total Bayar',
                                                style: TextStyle(
                                                  fontFamily:
                                                      'Gilroy-ExtraBold',
                                                  fontSize: 16,
                                                  color: Color.fromRGBO(
                                                      76, 81, 97, 1),
                                                ),
                                              ),
                                              Text(
                                                'Rp. ' + total.toString(),
                                                style: TextStyle(
                                                  fontFamily: 'Gilroy-Light',
                                                  fontSize: 16,
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
                                              0.3,
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                            ),
                                            color: Color.fromRGBO(
                                                119, 115, 205, 1),
                                          ),
                                          child: Center(
                                            child: GestureDetector(
                                              onTap: () => openScanner(context),
                                              child: Text(
                                                'Bayar',
                                                style: TextStyle(
                                                  fontFamily:
                                                      'Gilroy-ExtraBold',
                                                  fontSize: 20,
                                                  color: Color.fromRGBO(
                                                      243, 243, 243, 1),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  )),
      ),
    );
  }
}
