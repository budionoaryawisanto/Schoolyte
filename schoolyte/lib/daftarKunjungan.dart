import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'model.dart';
import 'package:schoolyte/scanner.dart';

class DaftarKunjungan extends StatefulWidget {
  @override
  _DaftarKunjunganState createState() => new _DaftarKunjunganState();
}

class _DaftarKunjunganState extends State<DaftarKunjungan> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController statusController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  List<Test> _list = [];

  var loading = false;

  Future fetchData() async {
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

  _logOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('slogin', false);
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  }

  sendData() {
    if (_formKey.currentState!.validate()) {}
    if (_formKey2.currentState!.validate()) {}
  }

  konfirmasi() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            child: Container(
              height: 357,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 177,
                    height: 177,
                    child: Image.asset(
                      'assets/images/alertDialog.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Text(
                    'Kamu Yakin ?',
                    style: TextStyle(
                      fontFamily: 'Gilroy-ExtraBold',
                      fontSize: 32,
                    ),
                  ),
                  Container(
                    width: 253,
                    height: 43,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 107,
                            height: 43,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                width: 1,
                                color: Color.fromRGBO(119, 115, 205, 1),
                              ),
                              color: Colors.white,
                            ),
                            child: Center(
                              child: Text(
                                'Tidak',
                                style: TextStyle(
                                  fontFamily: 'Gilroy-Light',
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 107,
                            height: 43,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color.fromRGBO(242, 78, 26, 1),
                            ),
                            child: Center(
                              child: Text(
                                'Ya',
                                style: TextStyle(
                                  fontFamily: 'Gilroy-Light',
                                  fontSize: 20,
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
          );
        });
  }

  String? _result;
  Future openScanner(BuildContext context) async {
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => Scanner()));
    setState(() {
      _result = result;
    });
    _list.forEach((e) {
      if (_result == e.username) {
        setState(() {
          namaController.text = e.name;
          statusController.text = e.username;
        });
      }
    });
  }

  List<Tab> myTabs = <Tab>[
    Tab(text: 'Kunjungan'),
    Tab(text: 'Lihat Kunjungan'),
  ];

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: myTabs.length,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(138),
            child: AppBar(
              backgroundColor: Color.fromRGBO(255, 217, 102, 1),
              title: Align(
                alignment: Alignment(-0.7, 0.0),
                child: Text(
                  'Daftar Kunjungan',
                  style: TextStyle(
                    fontFamily: 'Gilroy-ExtraBold',
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ),
              elevation: 0.0,
              iconTheme: IconThemeData(color: Colors.white),
              bottom: TabBar(
                padding: EdgeInsets.only(bottom: 10),
                indicatorColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding: EdgeInsets.only(top: 0),
                isScrollable: false,
                labelStyle: TextStyle(
                  fontFamily: 'Gilroy-ExtraBold',
                  fontSize: 20,
                ),
                unselectedLabelStyle: TextStyle(
                  fontFamily: 'Gilroy-Light',
                  fontSize: 20,
                ),
                tabs: myTabs,
              ),
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Align(
                  alignment: Alignment(1.0, 0.0),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: [
              loading
                  ? Center(
                      child: CircularProgressIndicator(
                          color: Color.fromRGBO(255, 217, 102, 1)),
                    )
                  : SafeArea(
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment(-0.7, 0.0),
                            child: Container(
                              margin: EdgeInsets.only(top: 50),
                              child: Text(
                                'Tambah Kunjungan',
                                style: TextStyle(
                                  fontFamily: 'Gilroy-ExtraBold',
                                  fontSize: 20,
                                  color: Color.fromRGBO(76, 81, 97, 1),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.87,
                            height: 150,
                            margin: EdgeInsets.only(top: 35),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.85,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Nama',
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                          fontSize: 18,
                                          color: Color.fromRGBO(76, 81, 97, 1),
                                        ),
                                      ),
                                      Text(
                                        '         : ',
                                        style: TextStyle(
                                          color: Color.fromRGBO(76, 81, 97, 1),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
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
                                              labelText: 'Nama Pengunjung',
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
                                                return 'Nama pengunjung tidak boleh kosong ! ';
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
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        ' Status',
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                          fontSize: 18,
                                          color: Color.fromRGBO(76, 81, 97, 1),
                                        ),
                                      ),
                                      Text(
                                        '        : ',
                                        style: TextStyle(
                                          color: Color.fromRGBO(76, 81, 97, 1),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        child: Form(
                                          key: _formKey2,
                                          child: TextFormField(
                                            controller: statusController,
                                            style: TextStyle(
                                              fontFamily: 'Gilroy-Light',
                                              fontSize: 16,
                                              color:
                                                  Color.fromRGBO(76, 81, 97, 1),
                                            ),
                                            textAlignVertical:
                                                TextAlignVertical(y: -0.7),
                                            decoration: InputDecoration(
                                              labelText: 'Status Pengunjung',
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
                                                return 'Status pengunjung tidak boleh kosong ! ';
                                              }
                                            },
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
                            margin: EdgeInsets.only(top: 50),
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    openScanner(context);
                                  },
                                  child: Container(
                                    width: 119,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
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
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.filter_center_focus_rounded,
                                          size: 24,
                                          color: Color.fromRGBO(76, 81, 97, 1),
                                        ),
                                        Text(
                                          'Scan',
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
                                ),
                                GestureDetector(
                                  onTap: () {
                                    sendData();
                                  },
                                  child: Container(
                                    width: 119,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: Colors.black,
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Selesai',
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                          fontSize: 15,
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
              loading
                  ? Center(
                      child: CircularProgressIndicator(
                          color: Color.fromRGBO(255, 217, 102, 1)),
                    )
                  : Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.79,
                      margin: EdgeInsets.symmetric(
                        vertical: 20,
                      ),
                      child: SingleChildScrollView(
                        child: Align(
                          alignment: Alignment.center,
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
                                'Status',
                                style: TextStyle(
                                  fontFamily: 'Gilroy-Extrabold',
                                  fontSize: 16,
                                  color: Color.fromRGBO(76, 81, 97, 1),
                                ),
                              )),
                              DataColumn(
                                  label: Text(
                                'Aksi',
                                style: TextStyle(
                                  fontFamily: 'Gilroy-Extrabold',
                                  fontSize: 16,
                                  color: Color.fromRGBO(76, 81, 97, 1),
                                ),
                              )),
                            ],
                            rows: _list
                                .map((data) => DataRow(
                                      cells: [
                                        DataCell(
                                          Text(
                                            data.id.toString(),
                                            style: TextStyle(
                                              fontFamily: 'Gilroy-Light',
                                              fontSize: 12,
                                              color:
                                                  Color.fromRGBO(76, 81, 97, 1),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            data.name,
                                            style: TextStyle(
                                              fontFamily: 'Gilroy-Light',
                                              fontSize: 12,
                                              color:
                                                  Color.fromRGBO(76, 81, 97, 1),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            'Siswa',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy-Light',
                                              fontSize: 12,
                                              color:
                                                  Color.fromRGBO(76, 81, 97, 1),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          GestureDetector(
                                            onTap: () {
                                              konfirmasi();
                                            },
                                            child: Icon(
                                              Icons.delete,
                                              color:
                                                  Color.fromRGBO(76, 81, 97, 1),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ))
                                .toList(),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
