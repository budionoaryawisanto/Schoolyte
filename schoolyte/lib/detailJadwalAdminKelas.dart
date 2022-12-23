import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:schoolyte/detailJadwalAdminSiswa.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model.dart';
import 'detailAbsensiAdminSiswa.dart';

class DetailJadwalAdminKelas extends StatefulWidget {
  @override
  _DetailJadwalAdminKelasState createState() =>
      new _DetailJadwalAdminKelasState();
}

class _DetailJadwalAdminKelasState extends State<DetailJadwalAdminKelas> {
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

  List<Tab> myTabs = <Tab>[
    Tab(
      height: 118.h,
      child: Container(
        width: 490.w * 0.244,
        height: 118.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 0,
              blurRadius: 1.5,
              offset: Offset(0, 0),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 490.w * 0.244,
              height: 39.h,
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 199, 0, 1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14),
                  topRight: Radius.circular(14),
                ),
              ),
              child: Center(
                child: Text(
                  'Kelas 10',
                  style: TextStyle(
                    fontFamily: 'Gilroy-ExtraBold',
                    fontSize: 19.w,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
              width: 490.w * 0.183,
              height: 61.h,
              margin: EdgeInsets.only(bottom: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 490.w * 0.183,
                    height: 24.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          size: 24,
                          color: Color.fromRGBO(255, 217, 102, 1),
                        ),
                        Text(
                          '120 Siswa',
                          style: TextStyle(
                            fontFamily: 'Gilroy-Light',
                            fontSize: 14,
                            color: Color.fromRGBO(76, 81, 97, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 490.w * 0.183,
                    height: 24.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.dns,
                          size: 24,
                          color: Color.fromRGBO(255, 217, 102, 1),
                        ),
                        Text(
                          '4 Kelas',
                          style: TextStyle(
                            fontFamily: 'Gilroy-Light',
                            fontSize: 14,
                            color: Color.fromRGBO(76, 81, 97, 1),
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
    Tab(
      height: 118.h,
      child: Container(
        width: 490.w * 0.244,
        height: 118.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 0,
              blurRadius: 1.5,
              offset: Offset(0, 0),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 490.w * 0.244,
              height: 39.h,
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 199, 0, 1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14),
                  topRight: Radius.circular(14),
                ),
              ),
              child: Center(
                child: Text(
                  'Kelas 11',
                  style: TextStyle(
                    fontFamily: 'Gilroy-ExtraBold',
                    fontSize: 19.w,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
              width: 490.w * 0.183,
              height: 61.h,
              margin: EdgeInsets.only(bottom: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 490.w * 0.183,
                    height: 24.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          size: 24,
                          color: Color.fromRGBO(255, 217, 102, 1),
                        ),
                        Text(
                          '120 Siswa',
                          style: TextStyle(
                            fontFamily: 'Gilroy-Light',
                            fontSize: 14,
                            color: Color.fromRGBO(76, 81, 97, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 490.w * 0.183,
                    height: 24.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.dns,
                          size: 24,
                          color: Color.fromRGBO(255, 217, 102, 1),
                        ),
                        Text(
                          '4 Kelas',
                          style: TextStyle(
                            fontFamily: 'Gilroy-Light',
                            fontSize: 14,
                            color: Color.fromRGBO(76, 81, 97, 1),
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
    Tab(
      height: 118.h,
      child: Container(
        width: 490.w * 0.244,
        height: 118.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 0,
              blurRadius: 1.5,
              offset: Offset(0, 0),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 490.w * 0.244,
              height: 39.h,
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 199, 0, 1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14),
                  topRight: Radius.circular(14),
                ),
              ),
              child: Center(
                child: Text(
                  'Kelas 12',
                  style: TextStyle(
                    fontFamily: 'Gilroy-ExtraBold',
                    fontSize: 19.w,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
              width: 490.w * 0.183,
              height: 61.h,
              margin: EdgeInsets.only(bottom: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 490.w * 0.183,
                    height: 24.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          size: 24,
                          color: Color.fromRGBO(255, 217, 102, 1),
                        ),
                        Text(
                          '120 Siswa',
                          style: TextStyle(
                            fontFamily: 'Gilroy-Light',
                            fontSize: 14,
                            color: Color.fromRGBO(76, 81, 97, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 490.w * 0.183,
                    height: 24.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.dns,
                          size: 24,
                          color: Color.fromRGBO(255, 217, 102, 1),
                        ),
                        Text(
                          '4 Kelas',
                          style: TextStyle(
                            fontFamily: 'Gilroy-Light',
                            fontSize: 14,
                            color: Color.fromRGBO(76, 81, 97, 1),
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
  ];

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
    return ScreenUtilInit(
      designSize: const Size(490, 980),
      builder: (context, child) {
        return new MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SafeArea(
            child: DefaultTabController(
              length: myTabs.length,
              child: Scaffold(
                backgroundColor: Color.fromRGBO(229, 229, 229, 1),
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(75.h),
                  child: AppBar(
                    backgroundColor: Colors.white,
                    title: Align(
                      alignment: Alignment(-0.7, 0.0),
                      child: Text(
                        'Jadwal Kelas',
                        style: TextStyle(
                          fontFamily: 'Gilroy-ExtraBold',
                          fontSize: 24.w,
                          color: Color.fromRGBO(76, 81, 97, 1),
                        ),
                      ),
                    ),
                    elevation: 0.0,
                    iconTheme:
                        IconThemeData(color: Color.fromRGBO(76, 81, 97, 1)),
                    leading: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Align(
                        alignment: Alignment(1.0, 0.0),
                        child: Icon(
                          Icons.chevron_left_rounded,
                          color: Color.fromRGBO(76, 81, 97, 1),
                          size: 40.w,
                        ),
                      ),
                    ),
                  ),
                ),
                body: Container(
                  width: 490.w,
                  height: 980.h,
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
                                width: 490.w,
                                height: 220.h,
                                color: Colors.white,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Align(
                                      alignment: Alignment(-0.85, 0.0),
                                      child: Container(
                                        child: Text(
                                          'Pilih Kelas',
                                          style: TextStyle(
                                            fontFamily: 'Gilroy-ExtraBold',
                                            fontSize: 24.w,
                                            color:
                                                Color.fromRGBO(76, 81, 97, 1),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 490.w * 0.9,
                                      height: 128.h,
                                      child: TabBar(
                                        indicatorColor:
                                            Color.fromRGBO(255, 199, 0, 1),
                                        indicatorSize:
                                            TabBarIndicatorSize.label,
                                        indicatorPadding:
                                            EdgeInsets.only(top: 0),
                                        tabs: myTabs,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 490.w,
                                height: 980.h * 0.65,
                                padding: EdgeInsets.all(20),
                                child: TabBarView(children: [
                                  GridView.builder(
                                      itemCount: 3,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 1,
                                        mainAxisExtent: 54.h,
                                        mainAxisSpacing: 15.w,
                                      ),
                                      itemBuilder: (context, i) {
                                        final kelas = _list[i];
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DetailJadwalAdminSiswa()));
                                          },
                                          child: Container(
                                            margin: EdgeInsets.all(2),
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 20.h,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.3),
                                                  spreadRadius: 0,
                                                  blurRadius: 1.5,
                                                  offset: Offset(0, 0),
                                                )
                                              ],
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Kelas 10 IPA ${kelas.id}',
                                                  style: TextStyle(
                                                    fontFamily:
                                                        'Gilroy-ExtraBold',
                                                    fontSize: 16.w,
                                                    color: Color.fromRGBO(
                                                        76, 81, 97, 1),
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.chevron_right_rounded,
                                                  size: 24.w,
                                                  color: Colors.black,
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                  GridView.builder(
                                      itemCount: 3,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 1,
                                        mainAxisExtent: 54.h,
                                        mainAxisSpacing: 15.w,
                                      ),
                                      itemBuilder: (context, i) {
                                        final kelas = _list[i];
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DetailJadwalAdminSiswa()));
                                          },
                                          child: Container(
                                            margin: EdgeInsets.all(2),
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 20.h,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.3),
                                                  spreadRadius: 0,
                                                  blurRadius: 1.5,
                                                  offset: Offset(0, 0),
                                                )
                                              ],
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Kelas 11 IPA ${kelas.id}',
                                                  style: TextStyle(
                                                    fontFamily:
                                                        'Gilroy-ExtraBold',
                                                    fontSize: 16.w,
                                                    color: Color.fromRGBO(
                                                        76, 81, 97, 1),
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.chevron_right_rounded,
                                                  size: 24.w,
                                                  color: Colors.black,
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                  GridView.builder(
                                      itemCount: 3,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 1,
                                        mainAxisExtent: 54.h,
                                        mainAxisSpacing: 15.w,
                                      ),
                                      itemBuilder: (context, i) {
                                        final kelas = _list[i];
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DetailJadwalAdminSiswa()));
                                          },
                                          child: Container(
                                            margin: EdgeInsets.all(2),
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 20.h,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.3),
                                                  spreadRadius: 0,
                                                  blurRadius: 1.5,
                                                  offset: Offset(0, 0),
                                                )
                                              ],
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Kelas 12 IPA ${kelas.id}',
                                                  style: TextStyle(
                                                    fontFamily:
                                                        'Gilroy-ExtraBold',
                                                    fontSize: 16.w,
                                                    color: Color.fromRGBO(
                                                        76, 81, 97, 1),
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.chevron_right_rounded,
                                                  size: 24.w,
                                                  color: Colors.black,
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                ]),
                              ),
                            ],
                          ),
                        ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
