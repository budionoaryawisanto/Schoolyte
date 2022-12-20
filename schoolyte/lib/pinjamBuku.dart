import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'model.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'model.dart';

class PinjamBuku extends StatefulWidget {
  Book book;
  PinjamBuku({super.key, required this.book});

  @override
  _PinjamBukuState createState() => new _PinjamBukuState(book);
}

class _PinjamBukuState extends State<PinjamBuku> {
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

  var start;
  var end;
  var jumlahBuku = 1;

  @override
  Book book;
  _PinjamBukuState(this.book);

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
                  'Pinjam Buku',
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
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Center(
                              child: Material(
                                type: MaterialType.transparency,
                                child: Image.network(
                                  Api.image + book.image,
                                ),
                              ),
                            );
                          });
                    },
                    child: Container(
                      width: 167,
                      height: 226,
                      child: Image.network(
                        Api.image + book.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.67,
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          book.nama_buku,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Gilroy-ExtraBold',
                            fontSize: 32,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Tahun terbit: ' + book.tahun_terbit,
                          style: TextStyle(
                            fontFamily: 'Gilroy-Light',
                            fontSize: 13,
                            color: Color.fromRGBO(76, 81, 97, 1),
                          ),
                        ),
                        Text(
                          'Oleh: ' + book.nama_penulis,
                          style: TextStyle(
                            fontFamily: 'Gilroy-Light',
                            fontSize: 13,
                            color: Color.fromRGBO(76, 81, 97, 1),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.12,
                          height: MediaQuery.of(context).size.height * 0.018,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: book.jumlah_buku != '0'
                                ? Color.fromRGBO(119, 115, 205, 1)
                                : Color.fromRGBO(217, 217, 217, 1),
                          ),
                          child: Center(
                            child: Text(
                              book.jumlah_buku != '0'
                                  ? 'Tersedia : ' + book.jumlah_buku.toString()
                                  : 'Habis',
                              style: TextStyle(
                                fontFamily: 'Gilroy-Light',
                                fontSize: 10,
                                color: book.jumlah_buku != '0'
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.24,
                    child: SingleChildScrollView(
                      child: Text(
                        book.rincian_buku,
                        style: TextStyle(
                          fontFamily: 'Gilroy-Light',
                          fontSize: 12,
                          color: Color.fromRGBO(76, 81, 97, 1),
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    color: Color.fromRGBO(0, 0, 0, 0.22),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.045,
                    child: Row(
                      children: [
                        Text(
                          'Mulai       : ',
                          style: TextStyle(
                            fontFamily: 'Gilroy-Light',
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.65,
                          margin: EdgeInsets.only(left: 15),
                          child: DateTimePicker(
                            type: DateTimePickerType.dateTimeSeparate,
                            dateMask: 'd MMMM yyyy',
                            initialValue: DateTime.now().toString(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(DateTime.now().year + 1),
                            selectableDayPredicate: (date) {
                              if (date.weekday == 6 || date.weekday == 7) {
                                return false;
                              }

                              return true;
                            },
                            onChanged: (val) => setState(() {
                              start = val;
                            }),
                            validator: (val) {
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.045,
                    child: Row(
                      children: [
                        Text(
                          'Berakhir  : ',
                          style: TextStyle(
                            fontFamily: 'Gilroy-Light',
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.65,
                          margin: EdgeInsets.only(left: 15),
                          child: DateTimePicker(
                            type: DateTimePickerType.dateTimeSeparate,
                            dateMask: 'd MMMM yyyy',
                            initialValue: DateTime.now().toString(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(DateTime.now().year + 1),
                            selectableDayPredicate: (date) {
                              if (date.weekday == 6 || date.weekday == 7) {
                                return false;
                              }

                              return true;
                            },
                            onChanged: (val) => setState(() {
                              end = val;
                            }),
                            validator: (val) {
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.033,
                    margin: EdgeInsets.only(top: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Jumlah Buku : ',
                          style: TextStyle(
                            fontFamily: 'Gilroy-Light',
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.17,
                          height: MediaQuery.of(context).size.height * 0.026,
                          margin: EdgeInsets.only(left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () => setState(() {
                                  jumlahBuku != 1 ? jumlahBuku : null;
                                }),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.052,
                                  height: MediaQuery.of(context).size.height *
                                      0.0240,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(180),
                                    border: Border.all(
                                      width: 1,
                                      color: Color.fromRGBO(119, 115, 205, 1),
                                    ),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.remove,
                                      color: Color.fromRGBO(119, 115, 205, 1),
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                jumlahBuku.toString(),
                                style: TextStyle(
                                  fontFamily: 'Gilroy-Light',
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => setState(() {
                                  jumlahBuku++;
                                }),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.052,
                                  height: MediaQuery.of(context).size.height *
                                      0.0240,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(180),
                                    border: Border.all(
                                      width: 1,
                                      color: Color.fromRGBO(119, 115, 205, 1),
                                    ),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.add,
                                      color: Color.fromRGBO(119, 115, 205, 1),
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
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.04,
                    margin: EdgeInsets.only(
                      top: 40,
                      bottom: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.38,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromRGBO(217, 217, 217, 1),
                            ),
                            child: Center(
                              child: Text(
                                'Batal',
                                style: TextStyle(
                                  fontFamily: 'Gilroy-Light',
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => print('clicked'),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.38,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black,
                            ),
                            child: Center(
                              child: Text(
                                'Pinjam Buku',
                                style: TextStyle(
                                  fontFamily: 'Gilroy-Light',
                                  fontSize: 18,
                                  color: Colors.white,
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
      ),
    );
  }
}
