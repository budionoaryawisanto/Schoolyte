import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'model.dart';
import 'package:date_time_picker/date_time_picker.dart';

class LaporanKeuangan extends StatefulWidget {
  @override
  _LaporanKeuanganState createState() => new _LaporanKeuanganState();
}

class _LaporanKeuanganState extends State<LaporanKeuangan> {
  List<Test> _rMoney = [];

  var loading = false;

  Future fetchData() async {
    setState(() {
      loading = true;
    });
    _rMoney.clear();
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        for (Map<String, dynamic> i in data) {
          _rMoney.add(Test.formJson(i));
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

  var filterTgl;

  @override
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
        child: Scaffold(
          backgroundColor: Color.fromRGBO(243, 243, 243, 1),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(75),
            child: AppBar(
              backgroundColor: Color.fromRGBO(255, 217, 102, 1),
              title: Align(
                alignment: Alignment(-0.7, 0.0),
                child: Text(
                  'Laporan Keuangan',
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
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.07,
                          margin: EdgeInsets.only(top: 15),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 0,
                                blurRadius: 1.5,
                                offset: Offset(0, 1),
                              )
                            ],
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.24,
                                height:
                                    MediaQuery.of(context).size.height * 0.047,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Saldo',
                                      style: TextStyle(
                                        fontFamily: 'Gilroy-Light',
                                        fontSize: 14,
                                        color: Color.fromRGBO(76, 81, 97, 1),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(right: 5),
                                          child: Icon(
                                            Icons.wallet_outlined,
                                            color:
                                                Color.fromRGBO(255, 199, 0, 1),
                                          ),
                                        ),
                                        Text(
                                          'Rp.30000',
                                          style: TextStyle(
                                            fontFamily: 'Gilroy-ExtraBold',
                                            fontSize: 16,
                                            color:
                                                Color.fromRGBO(76, 81, 97, 1),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              VerticalDivider(
                                color: Color.fromRGBO(0, 0, 0, 0.18),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.24,
                                height:
                                    MediaQuery.of(context).size.height * 0.047,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.add_box_rounded,
                                      color: Color.fromRGBO(255, 199, 0, 1),
                                      size: 21,
                                    ),
                                    Text(
                                      'Top Up',
                                      style: TextStyle(
                                        fontFamily: 'Gilroy-ExtraBold',
                                        fontSize: 16,
                                        color: Color.fromRGBO(76, 81, 97, 1),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              VerticalDivider(
                                color: Color.fromRGBO(0, 0, 0, 0.18),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.24,
                                height:
                                    MediaQuery.of(context).size.height * 0.047,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.ios_share_outlined,
                                      color: Color.fromRGBO(255, 199, 0, 1),
                                      size: 21,
                                    ),
                                    Text(
                                      'Tarik',
                                      style: TextStyle(
                                        fontFamily: 'Gilroy-ExtraBold',
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
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 70,
                          color: Colors.white,
                          margin: EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  width: 120,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        spreadRadius: 0,
                                        blurRadius: 1.5,
                                        offset: Offset(0, 1),
                                      )
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Semua',
                                      style: TextStyle(
                                        fontFamily: 'Gilroy-Light',
                                        fontSize: 15,
                                        color: Color.fromRGBO(76, 81, 97, 1),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.52,
                                child: DateTimePicker(
                                  type: DateTimePickerType.date,
                                  icon: Icon(Icons.date_range_rounded),
                                  dateMask: 'EEEE, d MMMM yyyy',
                                  initialValue: 'Pilih Tanggal',
                                  firstDate: DateTime(DateTime.now().year - 3,
                                      DateTime.now().month, DateTime.now().day),
                                  lastDate: DateTime.now(),
                                  style: TextStyle(
                                    fontFamily: 'Gilroy-Light',
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                  onChanged: (val) => setState(() {
                                    filterTgl = val;
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
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.7,
                          margin: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.black,
                            ),
                          ),
                          child: GridView.builder(
                              itemCount: _rMoney.length,
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent:
                                    MediaQuery.of(context).size.width,
                                mainAxisExtent: 82,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 1,
                              ),
                              itemBuilder: (context, i) {
                                final money = _rMoney[i];
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 15,
                                  ),
                                  color: Colors.white,
                                  child: Text(i.toString()),
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
