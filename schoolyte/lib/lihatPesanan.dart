import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'model.dart';
import 'package:path/path.dart' as path;
import 'package:async/async.dart';

class LihatPesanan extends StatefulWidget {
  @override
  _LihatPesananState createState() => new _LihatPesananState();
}

class _LihatPesananState extends State<LihatPesanan> {
  List<Stand> _stand = [];
  List<Stand> _search = [];
  List<Menu> _menu = [];
  List<Siswa> _siswa = [];
  List<Guru> _guru = [];
  List<Admin> _admin = [];
  List<Pesanan> _pesanan = [];
  List<Pesanan> _pesananUser = [];
  List<RiwayatPesanan> _riwayat = [];
  List<RiwayatPesanan> _riwayatUser = [];
  List<Menu> _menuFilterPesanan = [];
  List<Menu> _menuFilterRiwayat = [];
  List<Stand> _standFilterPesanan = [];
  List<Stand> _standFilterRiwayat = [];

  late final profil;
  var loading = false;
  var loadingUser = false;
  var loadingPesanan = false;
  var loadingMenu = false;
  var loadingRiwayat = false;
  var id;
  var status;
  var statusUser;

  Future fetchDataStand() async {
    setState(() {
      loading = true;
    });
    _stand.clear();
    final response = await http.get(Uri.parse(Api.getStand));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      for (Map<String, dynamic> i in data) {
        _stand.add(Stand.formJson(i));
      }
      setState(() {
        loading = false;
      });
      await fetchDataMenu();
    }
  }

  Future fetchDataPesanan() async {
    setState(() {
      loadingPesanan = true;
    });
    _pesanan.clear();
    _pesananUser.clear();
    _menuFilterPesanan.clear();
    _standFilterPesanan.clear();
    final response = await http.get(Uri.parse(Api.getPesanan));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      for (Map<String, dynamic> i in data) {
        _pesanan.add(Pesanan.formJson(i));
      }
      for (var y = 0; y < _pesanan.length; y++) {
        if (_pesanan[y].kode_stand == '1') {
          _pesananUser.add(_pesanan[y]);
        }
      }
      for (var x = 0; x < _pesananUser.length; x++) {
        for (var i = 0; i < _menu.length; i++) {
          if (_menu[i].id.toString() == _pesananUser[x].menu_id) {
            _menuFilterPesanan.add(_menu[i]);
          }
        }
        for (var i = 0; i < _stand.length; i++) {
          if (_stand[i].id.toString() == _pesananUser[x].stand_id) {
            _standFilterPesanan.add(_stand[i]);
          }
        }
      }
      setState(() {
        loadingPesanan = false;
      });
      await fetchDataRiwayat();
    }
  }

  Future fetchDataRiwayat() async {
    setState(() {
      loadingRiwayat = true;
    });
    _riwayat.clear();
    _riwayatUser.clear();
    _standFilterRiwayat.clear();
    _menuFilterRiwayat.clear();
    final response = await http.get(Uri.parse(Api.getRiwayat));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      for (Map<String, dynamic> i in data) {
        _riwayat.add(RiwayatPesanan.formJson(i));
      }
      for (var y = 0; y < _riwayat.length; y++) {
        if (_riwayat[y].kode_stand == '1') {
          _riwayatUser.add(_riwayat[y]);
        }
      }
      for (var x = 0; x < _riwayatUser.length; x++) {
        for (var i = 0; i < _menu.length; i++) {
          if (_menu[i].id.toString() == _riwayatUser[x].menu_id) {
            _menuFilterRiwayat.add(_menu[i]);
          }
        }
        for (var i = 0; i < _stand.length; i++) {
          if (_stand[i].id.toString() == _riwayatUser[x].stand_id) {
            _standFilterRiwayat.add(_stand[i]);
          }
        }
      }
      setState(() {
        loadingRiwayat = false;
      });
    }
  }

  Future fetchDataMenu() async {
    setState(() {
      loadingMenu = true;
    });
    _menu.clear();
    final response = await http.get(Uri.parse(Api.getMenu));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      for (Map<String, dynamic> i in data) {
        _menu.add(Menu.formJson(i));
      }
      setState(() {
        loadingMenu = false;
      });
      await fetchDataPesanan();
    }
  }

  Future fetchDataSiswa() async {
    final prefs = await SharedPreferences.getInstance();
    id = prefs.getString('id');
    status = prefs.getString('status');
    statusUser = prefs.getString('status user');
    setState(() {
      loadingUser = true;
    });
    _siswa.clear();
    final response = await http.get(Uri.parse(Api.getSiswa));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        for (Map<String, dynamic> i in data) {
          _siswa.add(Siswa.formJson(i));
        }
      });
      await getProfil();
    }
  }

  Future fetchDataGuru() async {
    setState(() {
      loadingUser = true;
    });
    _guru.clear();
    final response = await http.get(Uri.parse(Api.getGuru));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        for (Map<String, dynamic> i in data) {
          _guru.add(Guru.formJson(i));
        }
      });
      await getProfil();
    }
  }

  Future fetchDataAdmin() async {
    setState(() {
      loadingUser = true;
    });
    _admin.clear();
    final response = await http.get(Uri.parse(Api.getAdmin));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        for (Map<String, dynamic> i in data) {
          _admin.add(Admin.formJson(i));
        }
      });
      await getProfil();
    }
  }

  getProfil() async {
    final prefs = await SharedPreferences.getInstance();
    id = prefs.getString('id');
    status = prefs.getString('status');
    statusUser = prefs.getString('status user');
    if (status!.toLowerCase() == 'siswa') {
      _siswa.forEach((siswa) {
        if (siswa.id.toString() == id) {
          setState(() {
            profil = siswa;
            loadingUser = false;
          });
        }
      });
    } else if (status.toLowerCase() == 'guru') {
      _guru.forEach((guru) {
        if (guru.id.toString() == id) {
          setState(() {
            profil = guru;
            loadingUser = false;
          });
        }
      });
    } else if (status.toLowerCase() == 'admin') {
      _admin.forEach((admin) {
        if (admin.id.toString() == id) {
          setState(() {
            profil = admin;
            loadingUser = false;
          });
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDataSiswa();
    fetchDataGuru();
    fetchDataAdmin();
    fetchDataStand();
  }

  updateData(Pesanan pesananUser) async {
    setState(() {
      loading = true;
    });
    var request = http.MultipartRequest(
        'POST', Uri.parse(Api.getPesanan + pesananUser.id.toString()));
    request.fields.addAll({'status': 'Selesai'});
    var response = await request.send();
    if (response.statusCode == 200) {
      setState(() {
        loading = false;
      });
      sucsess();
    } else {
      failed();
      setState(() {
        loading = false;
      });
    }
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
              height: 357.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 177.w,
                    height: 177.h,
                    child: Image.asset(
                      'assets/images/alertDialog.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Text(
                    'Kamu Yakin ?',
                    style: TextStyle(
                      fontFamily: 'Gilroy-ExtraBold',
                      fontSize: 32.w,
                    ),
                  ),
                  Container(
                    width: 253.w,
                    height: 43.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 107.w,
                            height: 43.h,
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
                                  fontSize: 20.w,
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 107.w,
                            height: 43.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color.fromRGBO(242, 78, 26, 1),
                            ),
                            child: Center(
                              child: Text(
                                'Ya',
                                style: TextStyle(
                                  fontFamily: 'Gilroy-Light',
                                  fontSize: 20.w,
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

  failed() {
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
                    'Gagal',
                    style: TextStyle(
                      fontFamily: 'Gilroy-ExtraBold',
                      fontSize: 32,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 107,
                      height: 43,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color.fromRGBO(242, 78, 26, 1),
                      ),
                      child: Center(
                        child: Text(
                          'OK',
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
          );
        });
  }

  sucsess() {
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
                      'assets/images/dialog.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Text(
                    'Sukses',
                    style: TextStyle(
                      fontFamily: 'Gilroy-ExtraBold',
                      fontSize: 32,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LihatPesanan()));
                    },
                    child: Container(
                      width: 107,
                      height: 43,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color.fromRGBO(119, 115, 205, 1),
                      ),
                      child: Center(
                        child: Text(
                          'OK',
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
          );
        });
  }

  List<Tab> myTabs = <Tab>[
    Tab(text: 'Terima Pesanan'),
    Tab(text: 'Selesai'),
  ];

  convertToIdr(dynamic number, int decimalDigit) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(number);
  }

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
    return ScreenUtilInit(
      designSize: const Size(490, 980),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: DefaultTabController(
            length: myTabs.length,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.white,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(138.h),
                child: AppBar(
                  backgroundColor: Color.fromRGBO(255, 217, 102, 1),
                  title: Align(
                    alignment: Alignment(-0.7, 0.0),
                    child: Text(
                      'Lihat Pesanan',
                      style: TextStyle(
                        fontFamily: 'Gilroy-ExtraBold',
                        fontSize: 24.w,
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
                      fontSize: 20.w,
                    ),
                    unselectedLabelStyle: TextStyle(
                      fontFamily: 'Gilroy-Light',
                      fontSize: 20.w,
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
                  SingleChildScrollView(
                    child: Container(
                        width: 490.w,
                        height: 980.h * 0.84,
                        color: Color.fromRGBO(243, 243, 243, 1),
                        child: Stack(
                          children: [
                            loadingPesanan
                                ? Center(
                                    child: CircularProgressIndicator(
                                        color: Color.fromRGBO(76, 81, 97, 1)),
                                  )
                                : GridView.builder(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 15.w,
                                      vertical: 20.h,
                                    ),
                                    itemCount: _pesananUser.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                      mainAxisExtent: 225.h,
                                      mainAxisSpacing: 15.w,
                                    ),
                                    itemBuilder: ((context, i) {
                                      final pesanan = _pesananUser[i];
                                      final stand = _standFilterPesanan[i];
                                      final menu = _menuFilterPesanan[i];
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 5,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.3),
                                              spreadRadius: 0,
                                              blurRadius: 1.5,
                                              offset: Offset(0, 0),
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(7),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 437.w,
                                              height: 32.h,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'No Pesanan :',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-ExtraBold',
                                                          fontSize: 13.w,
                                                          color: Color.fromRGBO(
                                                              76, 81, 97, 1),
                                                        ),
                                                      ),
                                                      Text(
                                                        pesanan.no_pemesanan,
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-Light',
                                                          fontSize: 13.w,
                                                          color: Color.fromRGBO(
                                                              76, 81, 97, 1),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Waktu Pemesanan',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-Light',
                                                          fontSize: 13.w,
                                                          color: Color.fromRGBO(
                                                              76, 81, 97, 1),
                                                        ),
                                                      ),
                                                      Text(
                                                        DateFormat(
                                                                'EEEE, d MMMM yyyy')
                                                            .format(DateTime
                                                                .parse(pesanan
                                                                    .tgl_pemesanan))
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-Light',
                                                          fontSize: 13.w,
                                                          color: Color.fromRGBO(
                                                              76, 81, 97, 1),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Divider(
                                              color:
                                                  Color.fromRGBO(76, 81, 97, 1),
                                            ),
                                            Container(
                                              width: 437.w,
                                              height: 99.h,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: 89.w,
                                                    height: 97.h,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    child: Image.network(
                                                      Api.image + stand.image,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 329.w,
                                                    height: 99.h,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Dapur ${stand.nama_stand}, Kode : ${stand.kode_stand}',
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
                                                        Container(
                                                          width: 329.w,
                                                          height: 45.h,
                                                          child:
                                                              GridView.builder(
                                                            itemCount: 1,
                                                            gridDelegate:
                                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                                    crossAxisCount:
                                                                        1,
                                                                    mainAxisExtent:
                                                                        15.h),
                                                            itemBuilder:
                                                                (context, i) {
                                                              return Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                    pesanan.jumlah +
                                                                        ' ${menu.nama_menu}',
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'Gilroy-Light',
                                                                      fontSize:
                                                                          13,
                                                                      color: Color
                                                                          .fromRGBO(
                                                                              76,
                                                                              81,
                                                                              97,
                                                                              1),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    convertToIdr(
                                                                        int.parse(
                                                                            menu.harga),
                                                                        0),
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'Gilroy-Light',
                                                                      fontSize:
                                                                          13,
                                                                      color: Color
                                                                          .fromRGBO(
                                                                              242,
                                                                              78,
                                                                              26,
                                                                              1),
                                                                    ),
                                                                  ),
                                                                ],
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 329.w,
                                                          height: 36.h,
                                                          child: Center(
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  'Total Pembayaran',
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'Gilroy-Light',
                                                                    fontSize:
                                                                        13,
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            76,
                                                                            81,
                                                                            97,
                                                                            1),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  convertToIdr(
                                                                      int.parse(
                                                                          pesanan
                                                                              .total),
                                                                      0),
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'Gilroy-Light',
                                                                    fontSize:
                                                                        16,
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            242,
                                                                            78,
                                                                            26,
                                                                            1),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment(0.97, 0.0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  updateData(pesanan);
                                                },
                                                child: Container(
                                                  width: 145.w,
                                                  height: 36.h,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                    color: Color.fromRGBO(
                                                        242, 78, 26, 1),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      'Selesai',
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
                                            ),
                                          ],
                                        ),
                                      );
                                    })),
                            Visibility(
                              visible: loading,
                              child: Container(
                                width: 490.w,
                                height: 980.h,
                                color: Color.fromRGBO(0, 0, 0, 0.20),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: Color.fromRGBO(119, 115, 205, 1),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                  SingleChildScrollView(
                    child: Container(
                        width: 490.w,
                        height: 980.h * 0.84,
                        color: Color.fromRGBO(243, 243, 243, 1),
                        child: loadingRiwayat
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: Color.fromRGBO(76, 81, 97, 1),
                                ),
                              )
                            : GridView.builder(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 15.w,
                                  vertical: 20.h,
                                ),
                                itemCount: _riwayatUser.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1,
                                  mainAxisExtent: 182.h,
                                  mainAxisSpacing: 15.w,
                                ),
                                itemBuilder: ((context, i) {
                                  final riwayatPesanan = _riwayatUser[i];
                                  final menu = _menuFilterRiwayat[i];
                                  final stand = _standFilterRiwayat[i];
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 5,
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.3),
                                          spreadRadius: 0,
                                          blurRadius: 1.5,
                                          offset: Offset(0, 0),
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 437.w,
                                          height: 48.h,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Nama Pemesan',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Gilroy-Light',
                                                      fontSize: 13.w,
                                                      color: Color.fromRGBO(
                                                          76, 81, 97, 1),
                                                    ),
                                                  ),
                                                  Text(
                                                    riwayatPesanan
                                                        .nama_pemesanan,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Gilroy-Light',
                                                      fontSize: 13.w,
                                                      color: Color.fromRGBO(
                                                          76, 81, 97, 1),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'No Pesanan :',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Gilroy-ExtraBold',
                                                      fontSize: 13.w,
                                                      color: Color.fromRGBO(
                                                          76, 81, 97, 1),
                                                    ),
                                                  ),
                                                  Text(
                                                    riwayatPesanan.no_pemesanan,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Gilroy-Light',
                                                      fontSize: 13.w,
                                                      color: Color.fromRGBO(
                                                          76, 81, 97, 1),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Waktu Pemesanan',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Gilroy-Light',
                                                      fontSize: 13.w,
                                                      color: Color.fromRGBO(
                                                          76, 81, 97, 1),
                                                    ),
                                                  ),
                                                  Text(
                                                    riwayatPesanan
                                                        .tgl_pemesanan,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Gilroy-Light',
                                                      fontSize: 13.w,
                                                      color: Color.fromRGBO(
                                                          76, 81, 97, 1),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          color: Color.fromRGBO(76, 81, 97, 1),
                                        ),
                                        Container(
                                          width: 437.w,
                                          height: 99.h,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 89.w,
                                                height: 97.h,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Image.network(
                                                  Api.image + stand.image,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Container(
                                                width: 329.w,
                                                height: 99.h,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Dapur ${stand.nama_stand}, Kode : ${stand.kode_stand}',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Gilroy-ExtraBold',
                                                        fontSize: 13,
                                                        color: Color.fromRGBO(
                                                            76, 81, 97, 1),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 329.w,
                                                      height: 45.h,
                                                      child: GridView.builder(
                                                        itemCount: 1,
                                                        gridDelegate:
                                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                                crossAxisCount:
                                                                    1,
                                                                mainAxisExtent:
                                                                    15.h),
                                                        itemBuilder:
                                                            (context, i) {
                                                          return Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                '${riwayatPesanan.jumlah}X ${menu.nama_menu}',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-Light',
                                                                  fontSize: 13,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          76,
                                                                          81,
                                                                          97,
                                                                          1),
                                                                ),
                                                              ),
                                                              Text(
                                                                convertToIdr(
                                                                    int.parse(menu
                                                                        .harga),
                                                                    0),
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-Light',
                                                                  fontSize: 13,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          242,
                                                                          78,
                                                                          26,
                                                                          1),
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 329.w,
                                                      height: 36.h,
                                                      child: Center(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              'Total Pembayaran',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Gilroy-Light',
                                                                fontSize: 13,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        76,
                                                                        81,
                                                                        97,
                                                                        1),
                                                              ),
                                                            ),
                                                            Text(
                                                              convertToIdr(
                                                                  int.parse(
                                                                      riwayatPesanan
                                                                          .total),
                                                                  0),
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Gilroy-Light',
                                                                fontSize: 16,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        242,
                                                                        78,
                                                                        26,
                                                                        1),
                                                              ),
                                                            ),
                                                          ],
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
                                }))),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
