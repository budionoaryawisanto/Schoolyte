import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'model.dart';
import 'package:date_time_picker/date_time_picker.dart';

class PeminjamanBuku extends StatefulWidget {
  @override
  _PeminjamanBukuState createState() => new _PeminjamanBukuState();
}

class _PeminjamanBukuState extends State<PeminjamanBuku> {
  List<Test> _list = [];
  List<Test> _search = [];
  List<Test> _searchDipinjam = [];
  List<Test> _searchSelesai = [];
  List<Test> _searchTelat = [];
  List<Test> _searchKehilangan = [];

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

  _logOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('slogin', false);
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  }

  List<Tab> myTabs = <Tab>[
    Tab(text: 'Menunggu'),
    Tab(text: 'Dipinjam'),
    Tab(text: 'Selesai'),
    Tab(text: 'Telat'),
    Tab(text: 'Kehilangan'),
  ];

  final TextEditingController searchMenungguController =
      TextEditingController();
  final TextEditingController searchDipinjamController =
      TextEditingController();
  final TextEditingController searchSelesaiController = TextEditingController();
  final TextEditingController searchTelatController = TextEditingController();
  final TextEditingController searchKehilanganController =
      TextEditingController();
  final TextEditingController sanksiController = TextEditingController();
  final TextEditingController telatController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  sendData() {
    print(tglDikembalikan);
    print(dropdownvalue);
    print(sanksi);
    print(telat);
  }

  onSearchMenunggu(String text) async {
    _search.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    _list.forEach((e) {
      if (e.name.toLowerCase().contains(text.toLowerCase()) ||
          e.id.toString().contains(text)) {
        _search.add(e);
      }
    });
  }

  onSearchDipinjam(String text) async {
    _searchDipinjam.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    _list.forEach((e) {
      if (e.name.toLowerCase().contains(text.toLowerCase()) ||
          e.id.toString().contains(text)) {
        _searchDipinjam.add(e);
      }
    });
  }

  onSearchSelesai(String text) async {
    _searchSelesai.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    _list.forEach((e) {
      if (e.name.toLowerCase().contains(text.toLowerCase()) ||
          e.id.toString().contains(text)) {
        _searchSelesai.add(e);
      }
    });
  }

  onSearchTelat(String text) async {
    _searchTelat.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    _list.forEach((e) {
      if (e.name.toLowerCase().contains(text.toLowerCase()) ||
          e.id.toString().contains(text)) {
        _searchTelat.add(e);
      }
    });
  }

  onSearchKehilangan(String text) async {
    _searchKehilangan.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    _list.forEach((e) {
      if (e.name.toLowerCase().contains(text.toLowerCase()) ||
          e.id.toString().contains(text)) {
        _searchKehilangan.add(e);
      }
    });
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

  var status = ['Telah Dikembalikan', 'Telat', 'Kehilangan'];
  var dropdownvalue = 'Telah Dikembalikan';
  var tglDikembalikan;
  var sanksi;
  var telat;

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
          backgroundColor: Color.fromRGBO(243, 243, 243, 1),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(138),
            child: AppBar(
              backgroundColor: Color.fromRGBO(255, 217, 102, 1),
              title: Align(
                alignment: Alignment(-0.7, 0.0),
                child: Text(
                  'Peminjaman Buku',
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
                isScrollable: true,
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
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 85,
                        color: Colors.white,
                        child: Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.88,
                            height: MediaQuery.of(context).size.height * 0.050,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(243, 243, 243, 1),
                              borderRadius: BorderRadius.circular(10),
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.73,
                                  child: Form(
                                    child: TextFormField(
                                      style: TextStyle(
                                        fontFamily: 'Gilroy-Light',
                                        fontSize: 16,
                                      ),
                                      textInputAction: TextInputAction.done,
                                      controller: searchMenungguController,
                                      autocorrect: true,
                                      onChanged: ((value) {
                                        setState(() {
                                          onSearchMenunggu(value);
                                        });
                                      }),
                                      decoration: new InputDecoration(
                                        icon: Icon(
                                          Icons.search,
                                          size: 24,
                                        ),
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        hintText: 'Cari Nama',
                                        hintStyle: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.cancel,
                                      size: 24,
                                      color: searchMenungguController
                                                  .text.length !=
                                              0
                                          ? Colors.red
                                          : Color.fromRGBO(76, 81, 97, 58)),
                                  onPressed: () {
                                    searchMenungguController.clear();
                                    onSearchMenunggu('');
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.725,
                          margin: EdgeInsets.only(top: 10),
                          child: loading
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : _search.length != 0 ||
                                      searchMenungguController.text.isNotEmpty
                                  ? GridView.builder(
                                      itemCount: _search.length,
                                      gridDelegate:
                                          SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent:
                                            MediaQuery.of(context).size.width,
                                        mainAxisExtent: 219,
                                        crossAxisSpacing: 15,
                                        mainAxisSpacing: 15,
                                      ),
                                      itemBuilder: (context, i) {
                                        final ms = _search[i];
                                        return Container(
                                          color: Colors.white,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 54,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          ms.name,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-ExtraBold',
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'Status : ',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Gilroy-ExtraBold',
                                                                fontSize: 14,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        76,
                                                                        81,
                                                                        97,
                                                                        1),
                                                              ),
                                                            ),
                                                            Text(
                                                              'Siswa',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Gilroy-Light',
                                                                fontSize: 14,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        76,
                                                                        81,
                                                                        97,
                                                                        1),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Text(
                                                          'Monday, 01 January 2022  16:09 WIB',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-Light',
                                                            fontSize: 14,
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
                                                    Container(
                                                      width: 65,
                                                      height: 26,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              konfirmasi();
                                                            },
                                                            child: Container(
                                                              width: 26,
                                                              height: 26,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            180),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.3),
                                                                    spreadRadius:
                                                                        0,
                                                                    blurRadius:
                                                                        1.5,
                                                                    offset:
                                                                        Offset(
                                                                            0,
                                                                            1),
                                                                  )
                                                                ],
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              child: Center(
                                                                child: Icon(
                                                                  Icons.close,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              print(
                                                                  'done click');
                                                            },
                                                            child: Container(
                                                              width: 26,
                                                              height: 26,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            180),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.3),
                                                                    spreadRadius:
                                                                        0,
                                                                    blurRadius:
                                                                        1.5,
                                                                    offset:
                                                                        Offset(
                                                                            0,
                                                                            1),
                                                                  )
                                                                ],
                                                                color: Color
                                                                    .fromRGBO(
                                                                        217,
                                                                        217,
                                                                        217,
                                                                        1),
                                                              ),
                                                              child: Center(
                                                                child: Icon(
                                                                  Icons.done,
                                                                  color: Colors
                                                                      .black,
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
                                              Divider(
                                                color: Color.fromRGBO(
                                                    0, 0, 0, 0.28),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.68,
                                                height: 122,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height: 100,
                                                      child: Image.asset(
                                                        'assets/images/samplebook.png',
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.47,
                                                      height: 122,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'ID Peminjaman : ' +
                                                                ms.id
                                                                    .toString(),
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-Light',
                                                              fontSize: 15,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      76,
                                                                      81,
                                                                      97,
                                                                      1),
                                                            ),
                                                          ),
                                                          Text(
                                                            'Ilmu Pengetahuan Alam',
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-ExtraBold',
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          Text(
                                                            'Mulai : Monday, 07 September 2022',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-Light',
                                                              fontSize: 13,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      76,
                                                                      81,
                                                                      97,
                                                                      0.78),
                                                            ),
                                                          ),
                                                          Text(
                                                            'Berakhir : Friday, 11 September 2022',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-Light',
                                                              fontSize: 13,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      76,
                                                                      81,
                                                                      97,
                                                                      0.78),
                                                            ),
                                                          ),
                                                          Text(
                                                            'Jumlah Buku : 1',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-Light',
                                                              fontSize: 13,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      76,
                                                                      81,
                                                                      97,
                                                                      0.78),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 135,
                                                            height: 19,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4),
                                                              color: Color
                                                                  .fromRGBO(
                                                                      217,
                                                                      217,
                                                                      217,
                                                                      1),
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                'Menunggu Konfirmasi',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-Light',
                                                                  fontSize: 13,
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
                                        );
                                      })
                                  : GridView.builder(
                                      itemCount: _list.length,
                                      gridDelegate:
                                          SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent:
                                            MediaQuery.of(context).size.width,
                                        mainAxisExtent: 219,
                                        crossAxisSpacing: 15,
                                        mainAxisSpacing: 15,
                                      ),
                                      itemBuilder: (context, i) {
                                        final m = _list[i];
                                        return Container(
                                          color: Colors.white,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 54,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          m.name,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-ExtraBold',
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'Status : ',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Gilroy-ExtraBold',
                                                                fontSize: 14,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        76,
                                                                        81,
                                                                        97,
                                                                        1),
                                                              ),
                                                            ),
                                                            Text(
                                                              'Siswa',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Gilroy-Light',
                                                                fontSize: 14,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        76,
                                                                        81,
                                                                        97,
                                                                        1),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Text(
                                                          'Monday, 01 January 2022  16:09 WIB',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-Light',
                                                            fontSize: 14,
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
                                                    Container(
                                                      width: 65,
                                                      height: 26,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              konfirmasi();
                                                            },
                                                            child: Container(
                                                              width: 26,
                                                              height: 26,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            180),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.3),
                                                                    spreadRadius:
                                                                        0,
                                                                    blurRadius:
                                                                        1.5,
                                                                    offset:
                                                                        Offset(
                                                                            0,
                                                                            1),
                                                                  )
                                                                ],
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              child: Center(
                                                                child: Icon(
                                                                  Icons.close,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              print(
                                                                  'done Click');
                                                            },
                                                            child: Container(
                                                              width: 26,
                                                              height: 26,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            180),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.3),
                                                                    spreadRadius:
                                                                        0,
                                                                    blurRadius:
                                                                        1.5,
                                                                    offset:
                                                                        Offset(
                                                                            0,
                                                                            1),
                                                                  )
                                                                ],
                                                                color: Color
                                                                    .fromRGBO(
                                                                        217,
                                                                        217,
                                                                        217,
                                                                        1),
                                                              ),
                                                              child: Center(
                                                                child: Icon(
                                                                  Icons.done,
                                                                  color: Colors
                                                                      .black,
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
                                              Divider(
                                                color: Color.fromRGBO(
                                                    0, 0, 0, 0.28),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.68,
                                                height: 122,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height: 100,
                                                      child: Image.asset(
                                                        'assets/images/samplebook.png',
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.47,
                                                      height: 122,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'ID Peminjaman : ' +
                                                                m.id.toString(),
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-Light',
                                                              fontSize: 15,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      76,
                                                                      81,
                                                                      97,
                                                                      1),
                                                            ),
                                                          ),
                                                          Text(
                                                            'Ilmu Pengetahuan Alam',
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-ExtraBold',
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          Text(
                                                            'Mulai : Monday, 07 September 2022',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-Light',
                                                              fontSize: 13,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      76,
                                                                      81,
                                                                      97,
                                                                      0.78),
                                                            ),
                                                          ),
                                                          Text(
                                                            'Berakhir : Friday, 11 September 2022',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-Light',
                                                              fontSize: 13,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      76,
                                                                      81,
                                                                      97,
                                                                      0.78),
                                                            ),
                                                          ),
                                                          Text(
                                                            'Jumlah Buku : 1',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-Light',
                                                              fontSize: 13,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      76,
                                                                      81,
                                                                      97,
                                                                      0.78),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 135,
                                                            height: 19,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4),
                                                              color: Color
                                                                  .fromRGBO(
                                                                      217,
                                                                      217,
                                                                      217,
                                                                      1),
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                'Menunggu Konfirmasi',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-Light',
                                                                  fontSize: 13,
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
                                        );
                                      }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 85,
                        color: Colors.white,
                        child: Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.88,
                            height: MediaQuery.of(context).size.height * 0.050,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(243, 243, 243, 1),
                              borderRadius: BorderRadius.circular(10),
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.73,
                                  child: Form(
                                    child: TextFormField(
                                      style: TextStyle(
                                        fontFamily: 'Gilroy-Light',
                                        fontSize: 16,
                                      ),
                                      textInputAction: TextInputAction.done,
                                      controller: searchDipinjamController,
                                      autocorrect: true,
                                      onChanged: ((value) {
                                        setState(() {
                                          onSearchDipinjam(value);
                                        });
                                      }),
                                      decoration: new InputDecoration(
                                        icon: Icon(
                                          Icons.search,
                                          size: 24,
                                        ),
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        hintText: 'Cari Nama',
                                        hintStyle: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.cancel,
                                      size: 24,
                                      color: searchDipinjamController
                                                  .text.length !=
                                              0
                                          ? Colors.red
                                          : Color.fromRGBO(76, 81, 97, 58)),
                                  onPressed: () {
                                    searchDipinjamController.clear();
                                    onSearchDipinjam('');
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.725,
                          margin: EdgeInsets.only(top: 10),
                          child: loading
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : _searchDipinjam.length != 0 ||
                                      searchDipinjamController.text.isNotEmpty
                                  ? GridView.builder(
                                      itemCount: _searchDipinjam.length,
                                      gridDelegate:
                                          SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent:
                                            MediaQuery.of(context).size.width,
                                        mainAxisExtent: 265,
                                        crossAxisSpacing: 15,
                                        mainAxisSpacing: 15,
                                      ),
                                      itemBuilder: (context, i) {
                                        final ds = _searchDipinjam[i];
                                        return Container(
                                          color: Colors.white,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 54,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          ds.name,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-ExtraBold',
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'Status : ',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Gilroy-ExtraBold',
                                                                fontSize: 14,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        76,
                                                                        81,
                                                                        97,
                                                                        1),
                                                              ),
                                                            ),
                                                            Text(
                                                              'Siswa',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Gilroy-Light',
                                                                fontSize: 14,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        76,
                                                                        81,
                                                                        97,
                                                                        1),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Text(
                                                          'Monday, 01 January 2022  16:09 WIB',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-Light',
                                                            fontSize: 14,
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
                                                    Container(
                                                      width: 111,
                                                      height: 19,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                        color: Color.fromRGBO(
                                                            255, 199, 0, 1),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          'Sedang Dipinjam',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-Light',
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Divider(
                                                color: Color.fromRGBO(
                                                    0, 0, 0, 0.28),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.68,
                                                height: 122,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height: 100,
                                                      child: Image.asset(
                                                        'assets/images/samplebook.png',
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.47,
                                                      height: 100,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'ID Peminjaman : ' +
                                                                ds.id
                                                                    .toString(),
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-Light',
                                                              fontSize: 15,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      76,
                                                                      81,
                                                                      97,
                                                                      1),
                                                            ),
                                                          ),
                                                          Text(
                                                            'Ilmu Pengetahuan Alam',
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-ExtraBold',
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          Text(
                                                            'Mulai : Monday, 07 September 2022',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-Light',
                                                              fontSize: 13,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      76,
                                                                      81,
                                                                      97,
                                                                      0.78),
                                                            ),
                                                          ),
                                                          Text(
                                                            'Berakhir : Friday, 11 September 2022',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-Light',
                                                              fontSize: 13,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      76,
                                                                      81,
                                                                      97,
                                                                      0.78),
                                                            ),
                                                          ),
                                                          Text(
                                                            'Jumlah Buku : 1',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-Light',
                                                              fontSize: 13,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      76,
                                                                      81,
                                                                      97,
                                                                      0.78),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(),
                                                  GestureDetector(
                                                    onTap: () {
                                                      showModalBottomSheet(
                                                        isScrollControlled:
                                                            true,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    20),
                                                            topRight:
                                                                Radius.circular(
                                                                    20),
                                                          ),
                                                        ),
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return Container(
                                                            height: 733,
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 20),
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        20),
                                                                topRight: Radius
                                                                    .circular(
                                                                        20),
                                                              ),
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Align(
                                                                  alignment:
                                                                      Alignment(
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      Container(
                                                                    width: 32,
                                                                    height: 2,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        width:
                                                                            1,
                                                                        color: Color.fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0.12),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                                  height: 219,
                                                                  color: Colors
                                                                      .white,
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceEvenly,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Container(
                                                                        width: MediaQuery.of(context)
                                                                            .size
                                                                            .width,
                                                                        height:
                                                                            54,
                                                                        padding:
                                                                            EdgeInsets.symmetric(horizontal: 20),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Column(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Text(
                                                                                  ds.name,
                                                                                  style: TextStyle(
                                                                                    fontFamily: 'Gilroy-ExtraBold',
                                                                                    fontSize: 16,
                                                                                  ),
                                                                                ),
                                                                                Row(
                                                                                  children: [
                                                                                    Text(
                                                                                      'Status : ',
                                                                                      style: TextStyle(
                                                                                        fontFamily: 'Gilroy-ExtraBold',
                                                                                        fontSize: 14,
                                                                                        color: Color.fromRGBO(76, 81, 97, 1),
                                                                                      ),
                                                                                    ),
                                                                                    Text(
                                                                                      'Siswa',
                                                                                      style: TextStyle(
                                                                                        fontFamily: 'Gilroy-Light',
                                                                                        fontSize: 14,
                                                                                        color: Color.fromRGBO(76, 81, 97, 1),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                Text(
                                                                                  'Monday, 01 January 2022  16:09 WIB',
                                                                                  style: TextStyle(
                                                                                    fontFamily: 'Gilroy-Light',
                                                                                    fontSize: 14,
                                                                                    color: Color.fromRGBO(76, 81, 97, 1),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            Container(
                                                                              width: 111,
                                                                              height: 19,
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(4),
                                                                                color: Color.fromRGBO(255, 199, 0, 1),
                                                                              ),
                                                                              child: Center(
                                                                                child: Text(
                                                                                  'Sedang Dipinjam',
                                                                                  style: TextStyle(
                                                                                    fontFamily: 'Gilroy-Light',
                                                                                    fontSize: 13,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Divider(
                                                                        color: Color.fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0.28),
                                                                      ),
                                                                      Container(
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.78,
                                                                        height:
                                                                            122,
                                                                        padding:
                                                                            EdgeInsets.symmetric(horizontal: 20),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Container(
                                                                              height: 100,
                                                                              child: Image.asset(
                                                                                'assets/images/samplebook.png',
                                                                                fit: BoxFit.fill,
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              width: MediaQuery.of(context).size.width * 0.47,
                                                                              height: 100,
                                                                              child: Column(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Text(
                                                                                    'ID Peminjaman : ' + ds.id.toString(),
                                                                                    style: TextStyle(
                                                                                      fontFamily: 'Gilroy-Light',
                                                                                      fontSize: 15,
                                                                                      color: Color.fromRGBO(76, 81, 97, 1),
                                                                                    ),
                                                                                  ),
                                                                                  Text(
                                                                                    'Ilmu Pengetahuan Alam',
                                                                                    maxLines: 2,
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                    style: TextStyle(
                                                                                      fontFamily: 'Gilroy-ExtraBold',
                                                                                      fontSize: 20,
                                                                                      color: Colors.black,
                                                                                    ),
                                                                                  ),
                                                                                  Text(
                                                                                    'Mulai : Monday, 07 September 2022',
                                                                                    style: TextStyle(
                                                                                      fontFamily: 'Gilroy-Light',
                                                                                      fontSize: 13,
                                                                                      color: Color.fromRGBO(76, 81, 97, 0.78),
                                                                                    ),
                                                                                  ),
                                                                                  Text(
                                                                                    'Berakhir : Friday, 11 September 2022',
                                                                                    style: TextStyle(
                                                                                      fontFamily: 'Gilroy-Light',
                                                                                      fontSize: 13,
                                                                                      color: Color.fromRGBO(76, 81, 97, 0.78),
                                                                                    ),
                                                                                  ),
                                                                                  Text(
                                                                                    'Jumlah Buku : 1',
                                                                                    style: TextStyle(
                                                                                      fontFamily: 'Gilroy-Light',
                                                                                      fontSize: 13,
                                                                                      color: Color.fromRGBO(76, 81, 97, 0.78),
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
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.9,
                                                                  height: 215,
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          top:
                                                                              10),
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Container(
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.9,
                                                                        height:
                                                                            40,
                                                                        child:
                                                                            Row(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Text(
                                                                              'Dikembalikan : ',
                                                                              style: TextStyle(
                                                                                fontFamily: 'Gilroy-Light',
                                                                                fontSize: 16,
                                                                                color: Colors.black,
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              width: MediaQuery.of(context).size.width * 0.6,
                                                                              margin: EdgeInsets.only(left: 15),
                                                                              child: DateTimePicker(
                                                                                type: DateTimePickerType.dateTimeSeparate,
                                                                                dateMask: 'd MMMM yyyy',
                                                                                initialValue: null,
                                                                                firstDate: DateTime.now(),
                                                                                lastDate: DateTime(DateTime.now().year + 1),
                                                                                selectableDayPredicate: (date) {
                                                                                  if (date.weekday == 6 || date.weekday == 7) {
                                                                                    return false;
                                                                                  }

                                                                                  return true;
                                                                                },
                                                                                onChanged: (val) => setState(() {
                                                                                  tglDikembalikan = val;
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
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.85,
                                                                        height:
                                                                            40,
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Text(
                                                                              'Telat',
                                                                              style: TextStyle(
                                                                                fontFamily: 'Gilroy-Light',
                                                                                fontSize: 18,
                                                                                color: Color.fromRGBO(76, 81, 97, 1),
                                                                              ),
                                                                            ),
                                                                            Text(
                                                                              '                  :     ',
                                                                              style: TextStyle(
                                                                                color: Color.fromRGBO(76, 81, 97, 1),
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              width: MediaQuery.of(context).size.width * 0.5,
                                                                              child: Form(
                                                                                key: _formKey2,
                                                                                child: TextFormField(
                                                                                  controller: telatController,
                                                                                  keyboardType: TextInputType.number,
                                                                                  style: TextStyle(
                                                                                    fontFamily: 'Gilroy-Light',
                                                                                    fontSize: 16,
                                                                                    color: Color.fromRGBO(76, 81, 97, 1),
                                                                                  ),
                                                                                  textAlignVertical: TextAlignVertical(y: -0.7),
                                                                                  decoration: InputDecoration(
                                                                                    labelText: 'Telat Pengembalian (Hari)',
                                                                                    labelStyle: TextStyle(
                                                                                      fontFamily: 'Gilroy-Light',
                                                                                      fontSize: 16,
                                                                                      color: Color.fromRGBO(76, 81, 97, 0.54),
                                                                                    ),
                                                                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                                                                                  ),
                                                                                  validator: (value) {
                                                                                    return null;
                                                                                  },
                                                                                  onChanged: (value) {
                                                                                    setState(() {
                                                                                      telat = value;
                                                                                    });
                                                                                  },
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.8,
                                                                        height:
                                                                            44,
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Text(
                                                                              'Status             :    ',
                                                                              style: TextStyle(fontFamily: 'Gilroy-Light', fontSize: 16),
                                                                            ),
                                                                            Container(
                                                                              width: 248,
                                                                              height: 44,
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(5),
                                                                                boxShadow: [
                                                                                  BoxShadow(
                                                                                    color: Colors.black.withOpacity(0.3),
                                                                                    spreadRadius: 0,
                                                                                    blurRadius: 1.5,
                                                                                    offset: Offset(0, 1),
                                                                                  )
                                                                                ],
                                                                                color: Colors.white,
                                                                              ),
                                                                              child: Center(
                                                                                child: DropdownButton(
                                                                                  value: dropdownvalue,
                                                                                  elevation: 0,
                                                                                  underline: SizedBox(),
                                                                                  style: TextStyle(
                                                                                    fontFamily: 'Gilroy-Light',
                                                                                    fontSize: 16,
                                                                                    color: Color.fromRGBO(76, 81, 97, 1),
                                                                                  ),
                                                                                  icon: Container(margin: EdgeInsets.only(left: 20), child: const Icon(Icons.keyboard_arrow_down)),
                                                                                  items: status.map((String items) {
                                                                                    return DropdownMenuItem(
                                                                                      value: items,
                                                                                      child: Text(items),
                                                                                    );
                                                                                  }).toList(),
                                                                                  onChanged: (String? newValue) {
                                                                                    setState(() {
                                                                                      dropdownvalue = newValue!;
                                                                                    });
                                                                                  },
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.85,
                                                                        height:
                                                                            40,
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Text(
                                                                              'Sanksi',
                                                                              style: TextStyle(
                                                                                fontFamily: 'Gilroy-Light',
                                                                                fontSize: 18,
                                                                                color: Color.fromRGBO(76, 81, 97, 1),
                                                                              ),
                                                                            ),
                                                                            Text(
                                                                              '              :     ',
                                                                              style: TextStyle(
                                                                                color: Color.fromRGBO(76, 81, 97, 1),
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              width: MediaQuery.of(context).size.width * 0.5,
                                                                              child: Form(
                                                                                key: _formKey,
                                                                                child: TextFormField(
                                                                                  controller: sanksiController,
                                                                                  keyboardType: TextInputType.number,
                                                                                  style: TextStyle(
                                                                                    fontFamily: 'Gilroy-Light',
                                                                                    fontSize: 16,
                                                                                    color: Color.fromRGBO(76, 81, 97, 1),
                                                                                  ),
                                                                                  textAlignVertical: TextAlignVertical(y: -0.7),
                                                                                  decoration: InputDecoration(
                                                                                    labelText: 'Jumlah sanksi (Rp)',
                                                                                    labelStyle: TextStyle(
                                                                                      fontFamily: 'Gilroy-Light',
                                                                                      fontSize: 16,
                                                                                      color: Color.fromRGBO(76, 81, 97, 0.54),
                                                                                    ),
                                                                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                                                                                  ),
                                                                                  validator: (value) {
                                                                                    return null;
                                                                                  },
                                                                                  onChanged: (value) {
                                                                                    setState(() {
                                                                                      sanksi = value;
                                                                                    });
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
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.9,
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          top:
                                                                              20),
                                                                  child: Text(
                                                                    '*Apabila terjadi keterlambatan dan kehilangan buku maka peminjaman akan dikenakan sanksi',
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'Gilroy-Light',
                                                                      fontSize:
                                                                          11,
                                                                      color: Color
                                                                          .fromRGBO(
                                                                              76,
                                                                              81,
                                                                              97,
                                                                              1),
                                                                    ),
                                                                  ),
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    sendData();
                                                                  },
                                                                  child: Align(
                                                                    alignment:
                                                                        Alignment(
                                                                            0.8,
                                                                            0.0),
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          110,
                                                                      height:
                                                                          35,
                                                                      margin: EdgeInsets
                                                                          .only(
                                                                              top: 60),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(7),
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Text(
                                                                          'Selesai',
                                                                          style:
                                                                              TextStyle(
                                                                            fontFamily:
                                                                                'Gilroy-Light',
                                                                            fontSize:
                                                                                15,
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                    child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.46,
                                                      height: 36,
                                                      margin: EdgeInsets.only(
                                                          right: 35),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                        color: Color.fromRGBO(
                                                            242, 78, 26, 1),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          'Konfirmasi Pengembalian',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-ExtraBold',
                                                            fontSize: 15,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      })
                                  : GridView.builder(
                                      itemCount: _list.length,
                                      gridDelegate:
                                          SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent:
                                            MediaQuery.of(context).size.width,
                                        mainAxisExtent: 265,
                                        crossAxisSpacing: 15,
                                        mainAxisSpacing: 15,
                                      ),
                                      itemBuilder: (context, i) {
                                        final d = _list[i];
                                        return Container(
                                          color: Colors.white,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 54,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          d.name,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-ExtraBold',
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'Status : ',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Gilroy-ExtraBold',
                                                                fontSize: 14,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        76,
                                                                        81,
                                                                        97,
                                                                        1),
                                                              ),
                                                            ),
                                                            Text(
                                                              'Siswa',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Gilroy-Light',
                                                                fontSize: 14,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        76,
                                                                        81,
                                                                        97,
                                                                        1),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Text(
                                                          'Monday, 01 January 2022  16:09 WIB',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-Light',
                                                            fontSize: 14,
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
                                                    Container(
                                                      width: 111,
                                                      height: 19,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                        color: Color.fromRGBO(
                                                            255, 199, 0, 1),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          'Sedang Dipinjam',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-Light',
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Divider(
                                                color: Color.fromRGBO(
                                                    0, 0, 0, 0.28),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.68,
                                                height: 122,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height: 100,
                                                      child: Image.asset(
                                                        'assets/images/samplebook.png',
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.47,
                                                      height: 100,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'ID Peminjaman : ' +
                                                                d.id.toString(),
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-Light',
                                                              fontSize: 15,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      76,
                                                                      81,
                                                                      97,
                                                                      1),
                                                            ),
                                                          ),
                                                          Text(
                                                            'Ilmu Pengetahuan Alam',
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-ExtraBold',
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          Text(
                                                            'Mulai : Monday, 07 September 2022',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-Light',
                                                              fontSize: 13,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      76,
                                                                      81,
                                                                      97,
                                                                      0.78),
                                                            ),
                                                          ),
                                                          Text(
                                                            'Berakhir : Friday, 11 September 2022',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-Light',
                                                              fontSize: 13,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      76,
                                                                      81,
                                                                      97,
                                                                      0.78),
                                                            ),
                                                          ),
                                                          Text(
                                                            'Jumlah Buku : 1',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-Light',
                                                              fontSize: 13,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      76,
                                                                      81,
                                                                      97,
                                                                      0.78),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(),
                                                  GestureDetector(
                                                    onTap: () {
                                                      showModalBottomSheet(
                                                        isScrollControlled:
                                                            true,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    20),
                                                            topRight:
                                                                Radius.circular(
                                                                    20),
                                                          ),
                                                        ),
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return Container(
                                                            height: 733,
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 20),
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        20),
                                                                topRight: Radius
                                                                    .circular(
                                                                        20),
                                                              ),
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Align(
                                                                  alignment:
                                                                      Alignment(
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      Container(
                                                                    width: 32,
                                                                    height: 2,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        width:
                                                                            1,
                                                                        color: Color.fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0.12),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                                  height: 219,
                                                                  color: Colors
                                                                      .white,
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceEvenly,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Container(
                                                                        width: MediaQuery.of(context)
                                                                            .size
                                                                            .width,
                                                                        height:
                                                                            54,
                                                                        padding:
                                                                            EdgeInsets.symmetric(horizontal: 20),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Column(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Text(
                                                                                  d.name,
                                                                                  style: TextStyle(
                                                                                    fontFamily: 'Gilroy-ExtraBold',
                                                                                    fontSize: 16,
                                                                                  ),
                                                                                ),
                                                                                Row(
                                                                                  children: [
                                                                                    Text(
                                                                                      'Status : ',
                                                                                      style: TextStyle(
                                                                                        fontFamily: 'Gilroy-ExtraBold',
                                                                                        fontSize: 14,
                                                                                        color: Color.fromRGBO(76, 81, 97, 1),
                                                                                      ),
                                                                                    ),
                                                                                    Text(
                                                                                      'Siswa',
                                                                                      style: TextStyle(
                                                                                        fontFamily: 'Gilroy-Light',
                                                                                        fontSize: 14,
                                                                                        color: Color.fromRGBO(76, 81, 97, 1),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                Text(
                                                                                  'Monday, 01 January 2022  16:09 WIB',
                                                                                  style: TextStyle(
                                                                                    fontFamily: 'Gilroy-Light',
                                                                                    fontSize: 14,
                                                                                    color: Color.fromRGBO(76, 81, 97, 1),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            Container(
                                                                              width: 111,
                                                                              height: 19,
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(4),
                                                                                color: Color.fromRGBO(255, 199, 0, 1),
                                                                              ),
                                                                              child: Center(
                                                                                child: Text(
                                                                                  'Sedang Dipinjam',
                                                                                  style: TextStyle(
                                                                                    fontFamily: 'Gilroy-Light',
                                                                                    fontSize: 13,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Divider(
                                                                        color: Color.fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0.28),
                                                                      ),
                                                                      Container(
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.78,
                                                                        height:
                                                                            122,
                                                                        padding:
                                                                            EdgeInsets.symmetric(horizontal: 20),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Container(
                                                                              height: 100,
                                                                              child: Image.asset(
                                                                                'assets/images/samplebook.png',
                                                                                fit: BoxFit.fill,
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              width: MediaQuery.of(context).size.width * 0.47,
                                                                              height: 100,
                                                                              child: Column(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Text(
                                                                                    'ID Peminjaman : ' + d.id.toString(),
                                                                                    style: TextStyle(
                                                                                      fontFamily: 'Gilroy-Light',
                                                                                      fontSize: 15,
                                                                                      color: Color.fromRGBO(76, 81, 97, 1),
                                                                                    ),
                                                                                  ),
                                                                                  Text(
                                                                                    'Ilmu Pengetahuan Alam',
                                                                                    maxLines: 2,
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                    style: TextStyle(
                                                                                      fontFamily: 'Gilroy-ExtraBold',
                                                                                      fontSize: 20,
                                                                                      color: Colors.black,
                                                                                    ),
                                                                                  ),
                                                                                  Text(
                                                                                    'Mulai : Monday, 07 September 2022',
                                                                                    style: TextStyle(
                                                                                      fontFamily: 'Gilroy-Light',
                                                                                      fontSize: 13,
                                                                                      color: Color.fromRGBO(76, 81, 97, 0.78),
                                                                                    ),
                                                                                  ),
                                                                                  Text(
                                                                                    'Berakhir : Friday, 11 September 2022',
                                                                                    style: TextStyle(
                                                                                      fontFamily: 'Gilroy-Light',
                                                                                      fontSize: 13,
                                                                                      color: Color.fromRGBO(76, 81, 97, 0.78),
                                                                                    ),
                                                                                  ),
                                                                                  Text(
                                                                                    'Jumlah Buku : 1',
                                                                                    style: TextStyle(
                                                                                      fontFamily: 'Gilroy-Light',
                                                                                      fontSize: 13,
                                                                                      color: Color.fromRGBO(76, 81, 97, 0.78),
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
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.9,
                                                                  height: 215,
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          top:
                                                                              10),
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Container(
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.9,
                                                                        height:
                                                                            40,
                                                                        child:
                                                                            Row(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Text(
                                                                              'Dikembalikan : ',
                                                                              style: TextStyle(
                                                                                fontFamily: 'Gilroy-Light',
                                                                                fontSize: 16,
                                                                                color: Colors.black,
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              width: MediaQuery.of(context).size.width * 0.6,
                                                                              margin: EdgeInsets.only(left: 15),
                                                                              child: DateTimePicker(
                                                                                type: DateTimePickerType.dateTimeSeparate,
                                                                                dateMask: 'd MMMM yyyy',
                                                                                initialValue: null,
                                                                                firstDate: DateTime.now(),
                                                                                lastDate: DateTime(DateTime.now().year + 1),
                                                                                selectableDayPredicate: (date) {
                                                                                  if (date.weekday == 6 || date.weekday == 7) {
                                                                                    return false;
                                                                                  }

                                                                                  return true;
                                                                                },
                                                                                onChanged: (val) => setState(() {
                                                                                  tglDikembalikan = val;
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
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.85,
                                                                        height:
                                                                            40,
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Text(
                                                                              'Telat',
                                                                              style: TextStyle(
                                                                                fontFamily: 'Gilroy-Light',
                                                                                fontSize: 18,
                                                                                color: Color.fromRGBO(76, 81, 97, 1),
                                                                              ),
                                                                            ),
                                                                            Text(
                                                                              '                  :     ',
                                                                              style: TextStyle(
                                                                                color: Color.fromRGBO(76, 81, 97, 1),
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              width: MediaQuery.of(context).size.width * 0.5,
                                                                              child: Form(
                                                                                key: _formKey2,
                                                                                child: TextFormField(
                                                                                  controller: telatController,
                                                                                  keyboardType: TextInputType.number,
                                                                                  style: TextStyle(
                                                                                    fontFamily: 'Gilroy-Light',
                                                                                    fontSize: 16,
                                                                                    color: Color.fromRGBO(76, 81, 97, 1),
                                                                                  ),
                                                                                  textAlignVertical: TextAlignVertical(y: -0.7),
                                                                                  decoration: InputDecoration(
                                                                                    labelText: 'Telat Pengembalian (Hari)',
                                                                                    labelStyle: TextStyle(
                                                                                      fontFamily: 'Gilroy-Light',
                                                                                      fontSize: 16,
                                                                                      color: Color.fromRGBO(76, 81, 97, 0.54),
                                                                                    ),
                                                                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                                                                                  ),
                                                                                  validator: (value) {
                                                                                    return null;
                                                                                  },
                                                                                  onChanged: (value) {
                                                                                    setState(() {
                                                                                      telat = value;
                                                                                    });
                                                                                  },
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.8,
                                                                        height:
                                                                            44,
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Text(
                                                                              'Status             :    ',
                                                                              style: TextStyle(fontFamily: 'Gilroy-Light', fontSize: 16),
                                                                            ),
                                                                            Container(
                                                                              width: 248,
                                                                              height: 44,
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(5),
                                                                                boxShadow: [
                                                                                  BoxShadow(
                                                                                    color: Colors.black.withOpacity(0.3),
                                                                                    spreadRadius: 0,
                                                                                    blurRadius: 1.5,
                                                                                    offset: Offset(0, 1),
                                                                                  )
                                                                                ],
                                                                                color: Colors.white,
                                                                              ),
                                                                              child: Center(
                                                                                child: DropdownButton(
                                                                                  value: dropdownvalue,
                                                                                  elevation: 0,
                                                                                  underline: SizedBox(),
                                                                                  style: TextStyle(
                                                                                    fontFamily: 'Gilroy-Light',
                                                                                    fontSize: 16,
                                                                                    color: Color.fromRGBO(76, 81, 97, 1),
                                                                                  ),
                                                                                  icon: Container(margin: EdgeInsets.only(left: 20), child: const Icon(Icons.keyboard_arrow_down)),
                                                                                  items: status.map((String items) {
                                                                                    return DropdownMenuItem(
                                                                                      value: items,
                                                                                      child: Text(items),
                                                                                    );
                                                                                  }).toList(),
                                                                                  onChanged: (String? newValue) {
                                                                                    setState(() {
                                                                                      dropdownvalue = newValue!;
                                                                                    });
                                                                                  },
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.85,
                                                                        height:
                                                                            40,
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Text(
                                                                              'Sanksi',
                                                                              style: TextStyle(
                                                                                fontFamily: 'Gilroy-Light',
                                                                                fontSize: 18,
                                                                                color: Color.fromRGBO(76, 81, 97, 1),
                                                                              ),
                                                                            ),
                                                                            Text(
                                                                              '              :     ',
                                                                              style: TextStyle(
                                                                                color: Color.fromRGBO(76, 81, 97, 1),
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              width: MediaQuery.of(context).size.width * 0.5,
                                                                              child: Form(
                                                                                key: _formKey,
                                                                                child: TextFormField(
                                                                                  controller: sanksiController,
                                                                                  keyboardType: TextInputType.number,
                                                                                  style: TextStyle(
                                                                                    fontFamily: 'Gilroy-Light',
                                                                                    fontSize: 16,
                                                                                    color: Color.fromRGBO(76, 81, 97, 1),
                                                                                  ),
                                                                                  textAlignVertical: TextAlignVertical(y: -0.7),
                                                                                  decoration: InputDecoration(
                                                                                    labelText: 'Jumlah sanksi (Rp)',
                                                                                    labelStyle: TextStyle(
                                                                                      fontFamily: 'Gilroy-Light',
                                                                                      fontSize: 16,
                                                                                      color: Color.fromRGBO(76, 81, 97, 0.54),
                                                                                    ),
                                                                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                                                                                  ),
                                                                                  validator: (value) {
                                                                                    return null;
                                                                                  },
                                                                                  onChanged: (value) {
                                                                                    setState(() {
                                                                                      sanksi = value;
                                                                                    });
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
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.9,
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          top:
                                                                              20),
                                                                  child: Text(
                                                                    '*Apabila terjadi keterlambatan dan kehilangan buku maka peminjaman akan dikenakan sanksi',
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'Gilroy-Light',
                                                                      fontSize:
                                                                          11,
                                                                      color: Color
                                                                          .fromRGBO(
                                                                              76,
                                                                              81,
                                                                              97,
                                                                              1),
                                                                    ),
                                                                  ),
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    sendData();
                                                                  },
                                                                  child: Align(
                                                                    alignment:
                                                                        Alignment(
                                                                            0.8,
                                                                            0.0),
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          110,
                                                                      height:
                                                                          35,
                                                                      margin: EdgeInsets
                                                                          .only(
                                                                              top: 60),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(7),
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Text(
                                                                          'Selesai',
                                                                          style:
                                                                              TextStyle(
                                                                            fontFamily:
                                                                                'Gilroy-Light',
                                                                            fontSize:
                                                                                15,
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                    child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.46,
                                                      height: 36,
                                                      margin: EdgeInsets.only(
                                                          right: 35),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                        color: Color.fromRGBO(
                                                            242, 78, 26, 1),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          'Konfirmasi Pengembalian',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-ExtraBold',
                                                            fontSize: 15,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 85,
                        color: Colors.white,
                        child: Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.88,
                            height: MediaQuery.of(context).size.height * 0.050,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(243, 243, 243, 1),
                              borderRadius: BorderRadius.circular(10),
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.73,
                                  child: Form(
                                    child: TextFormField(
                                      style: TextStyle(
                                        fontFamily: 'Gilroy-Light',
                                        fontSize: 16,
                                      ),
                                      textInputAction: TextInputAction.done,
                                      controller: searchSelesaiController,
                                      autocorrect: true,
                                      onChanged: ((value) {
                                        setState(() {
                                          onSearchSelesai(value);
                                        });
                                      }),
                                      decoration: new InputDecoration(
                                        icon: Icon(
                                          Icons.search,
                                          size: 24,
                                        ),
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        hintText: 'Cari Nama',
                                        hintStyle: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.cancel,
                                      size: 24,
                                      color:
                                          searchSelesaiController.text.length !=
                                                  0
                                              ? Colors.red
                                              : Color.fromRGBO(76, 81, 97, 58)),
                                  onPressed: () {
                                    searchSelesaiController.clear();
                                    onSearchSelesai('');
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.725,
                          margin: EdgeInsets.only(top: 10),
                          child: loading
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : _searchSelesai.length != 0 ||
                                      searchSelesaiController.text.isNotEmpty
                                  ? GridView.builder(
                                      itemCount: _searchSelesai.length,
                                      gridDelegate:
                                          SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent:
                                            MediaQuery.of(context).size.width,
                                        mainAxisExtent: 233,
                                        crossAxisSpacing: 15,
                                        mainAxisSpacing: 15,
                                      ),
                                      itemBuilder: (context, i) {
                                        final ss = _searchSelesai[i];
                                        return Container(
                                          color: Colors.white,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 54,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          ss.name,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-ExtraBold',
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'Status : ',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Gilroy-ExtraBold',
                                                                fontSize: 14,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        76,
                                                                        81,
                                                                        97,
                                                                        1),
                                                              ),
                                                            ),
                                                            Text(
                                                              'Siswa',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Gilroy-Light',
                                                                fontSize: 14,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        76,
                                                                        81,
                                                                        97,
                                                                        1),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Text(
                                                          'Monday, 01 January 2022  16:09 WIB',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-Light',
                                                            fontSize: 14,
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
                                                    Container(
                                                      width: 132,
                                                      height: 19,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                        color: Color.fromRGBO(
                                                            217, 217, 217, 1),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          'Selesai Dikembalikan',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-Light',
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Divider(
                                                color: Color.fromRGBO(
                                                    0, 0, 0, 0.28),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.72,
                                                height: 122,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height: 100,
                                                      child: Image.asset(
                                                        'assets/images/samplebook.png',
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.5,
                                                      height: 114,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'ID Peminjaman : ' +
                                                                ss.id
                                                                    .toString(),
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-Light',
                                                              fontSize: 15,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      76,
                                                                      81,
                                                                      97,
                                                                      1),
                                                            ),
                                                          ),
                                                          Text(
                                                            'Ilmu Pengetahuan Alam',
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-ExtraBold',
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          Text(
                                                            'Mulai : Monday, 07 September 2022',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-Light',
                                                              fontSize: 13,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      76,
                                                                      81,
                                                                      97,
                                                                      0.78),
                                                            ),
                                                          ),
                                                          Text(
                                                            'Berakhir : Friday, 11 September 2022',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-Light',
                                                              fontSize: 13,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      76,
                                                                      81,
                                                                      97,
                                                                      0.78),
                                                            ),
                                                          ),
                                                          Text(
                                                            'Jumlah Buku : 1',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-Light',
                                                              fontSize: 13,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      76,
                                                                      81,
                                                                      97,
                                                                      0.78),
                                                            ),
                                                          ),
                                                          Text(
                                                            'Dikembalikan : Friday, 11 September 2022',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-Light',
                                                              fontSize: 13,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      76,
                                                                      81,
                                                                      97,
                                                                      0.78),
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
                                      })
                                  : GridView.builder(
                                      itemCount: _list.length,
                                      gridDelegate:
                                          SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent:
                                            MediaQuery.of(context).size.width,
                                        mainAxisExtent: 233,
                                        crossAxisSpacing: 15,
                                        mainAxisSpacing: 15,
                                      ),
                                      itemBuilder: (context, i) {
                                        final s = _list[i];
                                        return Container(
                                          color: Colors.white,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 54,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          s.name,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-ExtraBold',
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'Status : ',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Gilroy-ExtraBold',
                                                                fontSize: 14,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        76,
                                                                        81,
                                                                        97,
                                                                        1),
                                                              ),
                                                            ),
                                                            Text(
                                                              'Siswa',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Gilroy-Light',
                                                                fontSize: 14,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        76,
                                                                        81,
                                                                        97,
                                                                        1),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Text(
                                                          'Monday, 01 January 2022  16:09 WIB',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-Light',
                                                            fontSize: 14,
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
                                                    Container(
                                                      width: 132,
                                                      height: 19,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                        color: Color.fromRGBO(
                                                            217, 217, 217, 1),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          'Selesai Dikembalikan',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-Light',
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Divider(
                                                color: Color.fromRGBO(
                                                    0, 0, 0, 0.28),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.72,
                                                height: 122,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height: 100,
                                                      child: Image.asset(
                                                        'assets/images/samplebook.png',
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.5,
                                                      height: 114,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'ID Peminjaman : ' +
                                                                s.id.toString(),
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-Light',
                                                              fontSize: 15,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      76,
                                                                      81,
                                                                      97,
                                                                      1),
                                                            ),
                                                          ),
                                                          Text(
                                                            'Ilmu Pengetahuan Alam',
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-ExtraBold',
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          Text(
                                                            'Mulai : Monday, 07 September 2022',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-Light',
                                                              fontSize: 13,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      76,
                                                                      81,
                                                                      97,
                                                                      0.78),
                                                            ),
                                                          ),
                                                          Text(
                                                            'Berakhir : Friday, 11 September 2022',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-Light',
                                                              fontSize: 13,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      76,
                                                                      81,
                                                                      97,
                                                                      0.78),
                                                            ),
                                                          ),
                                                          Text(
                                                            'Jumlah Buku : 1',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-Light',
                                                              fontSize: 13,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      76,
                                                                      81,
                                                                      97,
                                                                      0.78),
                                                            ),
                                                          ),
                                                          Text(
                                                            'Dikembalikan : Friday, 11 September 2022',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-Light',
                                                              fontSize: 13,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      76,
                                                                      81,
                                                                      97,
                                                                      0.78),
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
                                      }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 85,
                        color: Colors.white,
                        child: Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.88,
                            height: MediaQuery.of(context).size.height * 0.050,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(243, 243, 243, 1),
                              borderRadius: BorderRadius.circular(10),
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.73,
                                  child: Form(
                                    child: TextFormField(
                                      style: TextStyle(
                                        fontFamily: 'Gilroy-Light',
                                        fontSize: 16,
                                      ),
                                      textInputAction: TextInputAction.done,
                                      controller: searchTelatController,
                                      autocorrect: true,
                                      onChanged: ((value) {
                                        setState(() {
                                          onSearchTelat(value);
                                        });
                                      }),
                                      decoration: new InputDecoration(
                                        icon: Icon(
                                          Icons.search,
                                          size: 24,
                                        ),
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        hintText: 'Cari Nama',
                                        hintStyle: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.cancel,
                                      size: 24,
                                      color:
                                          searchTelatController.text.length != 0
                                              ? Colors.red
                                              : Color.fromRGBO(76, 81, 97, 58)),
                                  onPressed: () {
                                    searchTelatController.clear();
                                    onSearchTelat('');
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.725,
                          margin: EdgeInsets.only(top: 10),
                          child: loading
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : _searchTelat.length != 0 ||
                                      searchTelatController.text.isNotEmpty
                                  ? GridView.builder(
                                      itemCount: _searchTelat.length,
                                      gridDelegate:
                                          SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent:
                                            MediaQuery.of(context).size.width,
                                        mainAxisExtent: 274,
                                        crossAxisSpacing: 15,
                                        mainAxisSpacing: 15,
                                      ),
                                      itemBuilder: (context, i) {
                                        final st = _searchTelat[i];
                                        return Container(
                                          color: Colors.white,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 54,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          st.name,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-ExtraBold',
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'Status : ',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Gilroy-ExtraBold',
                                                                fontSize: 14,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        76,
                                                                        81,
                                                                        97,
                                                                        1),
                                                              ),
                                                            ),
                                                            Text(
                                                              'Siswa',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Gilroy-Light',
                                                                fontSize: 14,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        76,
                                                                        81,
                                                                        97,
                                                                        1),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Text(
                                                          'Monday, 01 January 2022  16:09 WIB',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-Light',
                                                            fontSize: 14,
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
                                                    Container(
                                                      width: 127,
                                                      height: 19,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                        color: Color.fromRGBO(
                                                            242, 78, 26, 1),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          'Telat Pengembalian',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-Light',
                                                            fontSize: 13,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Divider(
                                                color: Color.fromRGBO(
                                                    0, 0, 0, 0.28),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.77,
                                                height: 122,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height: 100,
                                                      child: Image.asset(
                                                        'assets/images/samplebook.png',
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.55,
                                                      height: 114,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'ID Peminjaman : ' +
                                                                st.id
                                                                    .toString(),
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-Light',
                                                              fontSize: 15,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      76,
                                                                      81,
                                                                      97,
                                                                      1),
                                                            ),
                                                          ),
                                                          Text(
                                                            'Ilmu Pengetahuan Alam',
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-ExtraBold',
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          Text(
                                                            'Mulai : Monday, 07 September 2022',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-Light',
                                                              fontSize: 13,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      76,
                                                                      81,
                                                                      97,
                                                                      0.78),
                                                            ),
                                                          ),
                                                          Text(
                                                            'Berakhir : Friday, 11 September 2022',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-Light',
                                                              fontSize: 13,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      76,
                                                                      81,
                                                                      97,
                                                                      0.78),
                                                            ),
                                                          ),
                                                          Text(
                                                            'Jumlah Buku : 1',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-Light',
                                                              fontSize: 13,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      76,
                                                                      81,
                                                                      97,
                                                                      0.78),
                                                            ),
                                                          ),
                                                          Text(
                                                            'Dikembalikan : Saturday, 12 September 2022',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-Light',
                                                              fontSize: 13,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      76,
                                                                      81,
                                                                      97,
                                                                      0.78),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Divider(
                                                color: Color.fromRGBO(
                                                    0, 0, 0, 0.28),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.83,
                                                height: 46,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Telat Pengembalian :',
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
                                                        Text(
                                                          '1 Hari',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-Light',
                                                            fontSize: 13,
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
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 50),
                                                          child: Text(
                                                            'Denda          :',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-Light',
                                                              fontSize: 13,
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          'Rp.5000',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-Light',
                                                            fontSize: 13,
                                                            color:
                                                                Color.fromRGBO(
                                                                    242,
                                                                    78,
                                                                    26,
                                                                    1),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      })
                                  : GridView.builder(
                                      itemCount: _list.length,
                                      gridDelegate:
                                          SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent:
                                            MediaQuery.of(context).size.width,
                                        mainAxisExtent: 274,
                                        crossAxisSpacing: 15,
                                        mainAxisSpacing: 15,
                                      ),
                                      itemBuilder: (context, i) {
                                        final s = _list[i];
                                        return Container(
                                          color: Colors.white,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 54,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          s.name,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-ExtraBold',
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'Status : ',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Gilroy-ExtraBold',
                                                                fontSize: 14,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        76,
                                                                        81,
                                                                        97,
                                                                        1),
                                                              ),
                                                            ),
                                                            Text(
                                                              'Siswa',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Gilroy-Light',
                                                                fontSize: 14,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        76,
                                                                        81,
                                                                        97,
                                                                        1),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Text(
                                                          'Monday, 01 January 2022  16:09 WIB',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-Light',
                                                            fontSize: 14,
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
                                                    Container(
                                                      width: 127,
                                                      height: 19,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                        color: Color.fromRGBO(
                                                            242, 78, 26, 1),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          'Telat Pengembalian',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-Light',
                                                            fontSize: 13,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Divider(
                                                color: Color.fromRGBO(
                                                    0, 0, 0, 0.28),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.77,
                                                height: 122,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height: 100,
                                                      child: Image.asset(
                                                        'assets/images/samplebook.png',
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.55,
                                                      height: 114,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'ID Peminjaman : ' +
                                                                s.id.toString(),
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-Light',
                                                              fontSize: 15,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      76,
                                                                      81,
                                                                      97,
                                                                      1),
                                                            ),
                                                          ),
                                                          Text(
                                                            'Ilmu Pengetahuan Alam',
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-ExtraBold',
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          Text(
                                                            'Mulai : Monday, 07 September 2022',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-Light',
                                                              fontSize: 13,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      76,
                                                                      81,
                                                                      97,
                                                                      0.78),
                                                            ),
                                                          ),
                                                          Text(
                                                            'Berakhir : Friday, 11 September 2022',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-Light',
                                                              fontSize: 13,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      76,
                                                                      81,
                                                                      97,
                                                                      0.78),
                                                            ),
                                                          ),
                                                          Text(
                                                            'Jumlah Buku : 1',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-Light',
                                                              fontSize: 13,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      76,
                                                                      81,
                                                                      97,
                                                                      0.78),
                                                            ),
                                                          ),
                                                          Text(
                                                            'Dikembalikan : Saturday, 12 September 2022',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-Light',
                                                              fontSize: 13,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      76,
                                                                      81,
                                                                      97,
                                                                      0.78),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Divider(
                                                color: Color.fromRGBO(
                                                    0, 0, 0, 0.28),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.83,
                                                height: 46,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Telat Pengembalian :',
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
                                                        Text(
                                                          '1 Hari',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-Light',
                                                            fontSize: 13,
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
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 50),
                                                          child: Text(
                                                            'Denda          :',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-Light',
                                                              fontSize: 13,
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          'Rp.5000',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-Light',
                                                            fontSize: 13,
                                                            color:
                                                                Color.fromRGBO(
                                                                    242,
                                                                    78,
                                                                    26,
                                                                    1),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 85,
                        color: Colors.white,
                        child: Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.88,
                            height: MediaQuery.of(context).size.height * 0.050,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(243, 243, 243, 1),
                              borderRadius: BorderRadius.circular(10),
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.73,
                                  child: Form(
                                    child: TextFormField(
                                      style: TextStyle(
                                        fontFamily: 'Gilroy-Light',
                                        fontSize: 16,
                                      ),
                                      textInputAction: TextInputAction.done,
                                      controller: searchKehilanganController,
                                      autocorrect: true,
                                      onChanged: ((value) {
                                        setState(() {
                                          onSearchKehilangan(value);
                                        });
                                      }),
                                      decoration: new InputDecoration(
                                        icon: Icon(
                                          Icons.search,
                                          size: 24,
                                        ),
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        hintText: 'Cari Nama',
                                        hintStyle: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.cancel,
                                      size: 24,
                                      color: searchKehilanganController
                                                  .text.length !=
                                              0
                                          ? Colors.red
                                          : Color.fromRGBO(76, 81, 97, 58)),
                                  onPressed: () {
                                    searchKehilanganController.clear();
                                    onSearchKehilangan('');
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.725,
                          margin: EdgeInsets.only(top: 10),
                          child: loading
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : _searchKehilangan.length != 0 ||
                                      searchKehilanganController.text.isNotEmpty
                                  ? GridView.builder(
                                      itemCount: _searchKehilangan.length,
                                      gridDelegate:
                                          SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent:
                                            MediaQuery.of(context).size.width,
                                        mainAxisExtent: 274,
                                        crossAxisSpacing: 15,
                                        mainAxisSpacing: 15,
                                      ),
                                      itemBuilder: (context, i) {
                                        final sk = _searchKehilangan[i];
                                        return Container(
                                          color: Colors.white,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 54,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          sk.name,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-ExtraBold',
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'Status : ',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Gilroy-ExtraBold',
                                                                fontSize: 14,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        76,
                                                                        81,
                                                                        97,
                                                                        1),
                                                              ),
                                                            ),
                                                            Text(
                                                              'Siswa',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Gilroy-Light',
                                                                fontSize: 14,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        76,
                                                                        81,
                                                                        97,
                                                                        1),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Text(
                                                          'Monday, 01 January 2022  16:09 WIB',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-Light',
                                                            fontSize: 14,
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
                                                    Container(
                                                      width: 127,
                                                      height: 19,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                        color: Color.fromRGBO(
                                                            242, 78, 26, 1),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          'Kehilangan Buku',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-Light',
                                                            fontSize: 13,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Divider(
                                                color: Color.fromRGBO(
                                                    0, 0, 0, 0.28),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.77,
                                                height: 122,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height: 100,
                                                      child: Image.asset(
                                                        'assets/images/samplebook.png',
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.55,
                                                      height: 114,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'ID Peminjaman : ' +
                                                                sk.id
                                                                    .toString(),
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-Light',
                                                              fontSize: 15,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      76,
                                                                      81,
                                                                      97,
                                                                      1),
                                                            ),
                                                          ),
                                                          Text(
                                                            'Ilmu Pengetahuan Alam',
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-ExtraBold',
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          Text(
                                                            'Mulai : Monday, 07 September 2022',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-Light',
                                                              fontSize: 13,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      76,
                                                                      81,
                                                                      97,
                                                                      0.78),
                                                            ),
                                                          ),
                                                          Text(
                                                            'Berakhir : Friday, 11 September 2022',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-Light',
                                                              fontSize: 13,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      76,
                                                                      81,
                                                                      97,
                                                                      0.78),
                                                            ),
                                                          ),
                                                          Text(
                                                            'Jumlah Buku : 1',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-Light',
                                                              fontSize: 13,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      76,
                                                                      81,
                                                                      97,
                                                                      0.78),
                                                            ),
                                                          ),
                                                          Text(
                                                            'Dikembalikan : Saturday, 12 September 2022',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-Light',
                                                              fontSize: 13,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      76,
                                                                      81,
                                                                      97,
                                                                      0.78),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Divider(
                                                color: Color.fromRGBO(
                                                    0, 0, 0, 0.28),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.83,
                                                height: 46,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Telat Pengembalian :',
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
                                                        Text(
                                                          '1 Hari',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-Light',
                                                            fontSize: 13,
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
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 50),
                                                          child: Text(
                                                            'Denda          :',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-Light',
                                                              fontSize: 13,
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          'Rp.5000',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-Light',
                                                            fontSize: 13,
                                                            color:
                                                                Color.fromRGBO(
                                                                    242,
                                                                    78,
                                                                    26,
                                                                    1),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      })
                                  : GridView.builder(
                                      itemCount: _list.length,
                                      gridDelegate:
                                          SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent:
                                            MediaQuery.of(context).size.width,
                                        mainAxisExtent: 274,
                                        crossAxisSpacing: 15,
                                        mainAxisSpacing: 15,
                                      ),
                                      itemBuilder: (context, i) {
                                        final k = _list[i];
                                        return Container(
                                          color: Colors.white,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 54,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          k.name,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-ExtraBold',
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'Status : ',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Gilroy-ExtraBold',
                                                                fontSize: 14,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        76,
                                                                        81,
                                                                        97,
                                                                        1),
                                                              ),
                                                            ),
                                                            Text(
                                                              'Siswa',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Gilroy-Light',
                                                                fontSize: 14,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        76,
                                                                        81,
                                                                        97,
                                                                        1),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Text(
                                                          'Monday, 01 January 2022  16:09 WIB',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-Light',
                                                            fontSize: 14,
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
                                                    Container(
                                                      width: 127,
                                                      height: 19,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                        color: Color.fromRGBO(
                                                            242, 78, 26, 1),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          'Kehilangan Buku',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-Light',
                                                            fontSize: 13,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Divider(
                                                color: Color.fromRGBO(
                                                    0, 0, 0, 0.28),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.77,
                                                height: 122,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height: 100,
                                                      child: Image.asset(
                                                        'assets/images/samplebook.png',
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.55,
                                                      height: 114,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'ID Peminjaman : ' +
                                                                k.id.toString(),
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-Light',
                                                              fontSize: 15,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      76,
                                                                      81,
                                                                      97,
                                                                      1),
                                                            ),
                                                          ),
                                                          Text(
                                                            'Ilmu Pengetahuan Alam',
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-ExtraBold',
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          Text(
                                                            'Mulai : Monday, 07 September 2022',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-Light',
                                                              fontSize: 13,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      76,
                                                                      81,
                                                                      97,
                                                                      0.78),
                                                            ),
                                                          ),
                                                          Text(
                                                            'Berakhir : Friday, 11 September 2022',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-Light',
                                                              fontSize: 13,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      76,
                                                                      81,
                                                                      97,
                                                                      0.78),
                                                            ),
                                                          ),
                                                          Text(
                                                            'Jumlah Buku : 1',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-Light',
                                                              fontSize: 13,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      76,
                                                                      81,
                                                                      97,
                                                                      0.78),
                                                            ),
                                                          ),
                                                          Text(
                                                            'Dikembalikan : Saturday, 12 September 2022',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-Light',
                                                              fontSize: 13,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      76,
                                                                      81,
                                                                      97,
                                                                      0.78),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Divider(
                                                color: Color.fromRGBO(
                                                    0, 0, 0, 0.28),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.83,
                                                height: 26,
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
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 50),
                                                          child: Text(
                                                            'Denda          :',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-Light',
                                                              fontSize: 13,
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          'Rp.5000',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-Light',
                                                            fontSize: 13,
                                                            color:
                                                                Color.fromRGBO(
                                                                    242,
                                                                    78,
                                                                    26,
                                                                    1),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                        ),
                      ),
                    ],
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
