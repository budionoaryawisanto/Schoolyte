import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'model.dart';

class SumbangBuku extends StatefulWidget {
  @override
  _SumbangBukuState createState() => new _SumbangBukuState();
}

class _SumbangBukuState extends State<SumbangBuku> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController tahunController = TextEditingController();
  final TextEditingController penulisController = TextEditingController();
  final TextEditingController kategoriController = TextEditingController();
  final TextEditingController rincianController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();
  final _formKey4 = GlobalKey<FormState>();
  final _formKey5 = GlobalKey<FormState>();

  List<Test> _list = [];

  var loading = false;
  var count = 1;

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
            resizeToAvoidBottomInset: false,
            body: loading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.97,
                    color: Colors.white,
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
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.chevron_left,
                                  color: Color.fromRGBO(200, 200, 200, 1),
                                  size: 40,
                                ),
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Sumbang Buku',
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
                          height: MediaQuery.of(context).size.height * 0.866,
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.09),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.85,
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.15,
                                        child: Text(
                                          'Nama Buku',
                                          style: TextStyle(
                                            fontFamily: 'Gilroy-Light',
                                            fontSize: 18,
                                            color:
                                                Color.fromRGBO(76, 81, 97, 1),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        ' :      ',
                                        style: TextStyle(
                                          color: Color.fromRGBO(76, 81, 97, 1),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.038,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color:
                                              Color.fromRGBO(243, 243, 243, 1),
                                        ),
                                        child: Form(
                                          key: _formKey,
                                          child: TextFormField(
                                            controller: namaController,
                                            style: TextStyle(
                                              fontFamily: 'Gilroy-Light',
                                              fontSize: 16,
                                              color:
                                                  Color.fromRGBO(76, 81, 97, 1),
                                            ),
                                            textAlignVertical:
                                                TextAlignVertical(y: -0.7),
                                            decoration: InputDecoration(
                                              labelText: 'Nama',
                                              labelStyle: TextStyle(
                                                fontFamily: 'Gilroy-Light',
                                                fontSize: 16,
                                                color: Color.fromRGBO(
                                                    76, 81, 97, 0.54),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Nama buku tidak boleh kosong ! ';
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.85,
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  margin: EdgeInsets.only(top: 22),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.15,
                                        child: Text(
                                          'Tahun Terbit',
                                          style: TextStyle(
                                            fontFamily: 'Gilroy-Light',
                                            fontSize: 18,
                                            color:
                                                Color.fromRGBO(76, 81, 97, 1),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        ' :      ',
                                        style: TextStyle(
                                          color: Color.fromRGBO(76, 81, 97, 1),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.038,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color:
                                              Color.fromRGBO(243, 243, 243, 1),
                                        ),
                                        child: Form(
                                          key: _formKey2,
                                          child: TextFormField(
                                            controller: tahunController,
                                            style: TextStyle(
                                              fontFamily: 'Gilroy-Light',
                                              fontSize: 16,
                                              color:
                                                  Color.fromRGBO(76, 81, 97, 1),
                                            ),
                                            textAlignVertical:
                                                TextAlignVertical(y: -0.7),
                                            decoration: InputDecoration(
                                              labelText: 'Tahun',
                                              labelStyle: TextStyle(
                                                fontFamily: 'Gilroy-Light',
                                                fontSize: 16,
                                                color: Color.fromRGBO(
                                                    76, 81, 97, 0.54),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Tahun terbit tidak boleh kosong ! ';
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.85,
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  margin: EdgeInsets.only(top: 22),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.15,
                                        child: Text(
                                          'Penulis',
                                          style: TextStyle(
                                            fontFamily: 'Gilroy-Light',
                                            fontSize: 18,
                                            color:
                                                Color.fromRGBO(76, 81, 97, 1),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        ' :      ',
                                        style: TextStyle(
                                          color: Color.fromRGBO(76, 81, 97, 1),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.038,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color:
                                              Color.fromRGBO(243, 243, 243, 1),
                                        ),
                                        child: Form(
                                          key: _formKey3,
                                          child: TextFormField(
                                            controller: penulisController,
                                            style: TextStyle(
                                              fontFamily: 'Gilroy-Light',
                                              fontSize: 16,
                                              color:
                                                  Color.fromRGBO(76, 81, 97, 1),
                                            ),
                                            textAlignVertical:
                                                TextAlignVertical(y: -0.7),
                                            decoration: InputDecoration(
                                              labelText: 'Nama Penulis',
                                              labelStyle: TextStyle(
                                                fontFamily: 'Gilroy-Light',
                                                fontSize: 16,
                                                color: Color.fromRGBO(
                                                    76, 81, 97, 0.54),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Tahun terbit tidak boleh kosong ! ';
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.85,
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  margin: EdgeInsets.only(top: 22),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.15,
                                        child: Text(
                                          'Kategori',
                                          style: TextStyle(
                                            fontFamily: 'Gilroy-Light',
                                            fontSize: 18,
                                            color:
                                                Color.fromRGBO(76, 81, 97, 1),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        ' :      ',
                                        style: TextStyle(
                                          color: Color.fromRGBO(76, 81, 97, 1),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.038,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color:
                                              Color.fromRGBO(243, 243, 243, 1),
                                        ),
                                        child: Form(
                                          key: _formKey4,
                                          child: TextFormField(
                                            controller: kategoriController,
                                            style: TextStyle(
                                              fontFamily: 'Gilroy-Light',
                                              fontSize: 16,
                                              color:
                                                  Color.fromRGBO(76, 81, 97, 1),
                                            ),
                                            textAlignVertical:
                                                TextAlignVertical(y: -0.7),
                                            decoration: InputDecoration(
                                              labelText: 'Kategori Buku',
                                              labelStyle: TextStyle(
                                                fontFamily: 'Gilroy-Light',
                                                fontSize: 16,
                                                color: Color.fromRGBO(
                                                    76, 81, 97, 0.54),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Tahun terbit tidak boleh kosong ! ';
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.85,
                                  height:
                                      MediaQuery.of(context).size.height * 0.07,
                                  margin: EdgeInsets.only(top: 22),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.15,
                                        child: Text(
                                          'Rincian Buku',
                                          style: TextStyle(
                                            fontFamily: 'Gilroy-Light',
                                            fontSize: 18,
                                            color:
                                                Color.fromRGBO(76, 81, 97, 1),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        ' :      ',
                                        style: TextStyle(
                                          color: Color.fromRGBO(76, 81, 97, 1),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color:
                                              Color.fromRGBO(243, 243, 243, 1),
                                        ),
                                        child: Form(
                                          key: _formKey5,
                                          child: TextFormField(
                                            controller: rincianController,
                                            style: TextStyle(
                                              fontFamily: 'Gilroy-Light',
                                              fontSize: 16,
                                              color:
                                                  Color.fromRGBO(76, 81, 97, 1),
                                            ),
                                            textAlignVertical:
                                                TextAlignVertical(y: -0.7),
                                            decoration: InputDecoration(
                                              labelText: 'Keterangan Buku',
                                              labelStyle: TextStyle(
                                                fontFamily: 'Gilroy-Light',
                                                fontSize: 16,
                                                color: Color.fromRGBO(
                                                    76, 81, 97, 0.54),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Tahun terbit tidak boleh kosong ! ';
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.42,
                                  height: MediaQuery.of(context).size.height *
                                      0.042,
                                  margin: EdgeInsets.only(top: 22),
                                  child: Row(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.14,
                                        child: Text(
                                          'Jumlah Buku',
                                          style: TextStyle(
                                            fontFamily: 'Gilroy-Light',
                                            fontSize: 18,
                                            color:
                                                Color.fromRGBO(76, 81, 97, 1),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        '   :',
                                        style: TextStyle(
                                          color: Color.fromRGBO(76, 81, 97, 1),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.17,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.026,
                                        margin: EdgeInsets.only(left: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            GestureDetector(
                                              onTap: () => setState(() {
                                                count != 1 ? count-- : null;
                                              }),
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.052,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.0240,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          180),
                                                  border: Border.all(
                                                    width: 1,
                                                    color: Color.fromRGBO(
                                                        119, 115, 205, 1),
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Icon(
                                                    Icons.remove,
                                                    color: Color.fromRGBO(
                                                        119, 115, 205, 1),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              count.toString(),
                                              style: TextStyle(
                                                fontFamily: 'Gilroy-Light',
                                                fontSize: 16,
                                                color: Colors.black,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () => setState(() {
                                                count++;
                                              }),
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.052,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.0240,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          180),
                                                  border: Border.all(
                                                    width: 1,
                                                    color: Color.fromRGBO(
                                                        119, 115, 205, 1),
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Icon(
                                                    Icons.add,
                                                    color: Color.fromRGBO(
                                                        119, 115, 205, 1),
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
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
      ),
    );
  }
}
