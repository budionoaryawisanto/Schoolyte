import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DetailJadwalAdminGuru extends StatefulWidget {
  @override
  _DetailJadwalAdminGuruState createState() =>
      new _DetailJadwalAdminGuruState();
}

class _DetailJadwalAdminGuruState extends State<DetailJadwalAdminGuru> {
  List<Test> _jadwal = [];
  var loading = false;

  Future fetchJadwal() async {
    setState(() {
      loading = true;
    });
    _jadwal.clear();
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    print(response.body);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        for (Map<String, dynamic> i in data) {
          _jadwal.add(Test.formJson(i));
          loading = false;
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchJadwal();
  }

  List<Tab> myTabs = <Tab>[
    Tab(
      child: Text(
        'Sen',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    ),
    Tab(
      child: Text(
        'Sel',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    ),
    Tab(
      child: Text(
        'Rab',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    ),
    Tab(
      child: Text(
        'Kam',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    ),
    Tab(
      child: Text(
        'Jum',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        systemNavigationBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    return ScreenUtilInit(
      designSize: const Size(490, 980),
      builder: (context, child) {
        return new MaterialApp(
          debugShowCheckedModeBanner: false,
          home: DefaultTabController(
            length: myTabs.length,
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(138),
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
                  bottom: TabBar(
                    padding: EdgeInsets.only(bottom: 10),
                    indicatorColor: Color.fromRGBO(76, 81, 97, 1),
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorPadding: EdgeInsets.only(top: 0),
                    labelStyle: TextStyle(
                      fontFamily: 'Gilroy-ExtraBold',
                      fontSize: 20.w,
                      color: Color.fromRGBO(76, 81, 97, 1),
                    ),
                    unselectedLabelStyle: TextStyle(
                      fontFamily: 'Gilroy-Light',
                      fontSize: 20.w,
                    ),
                    tabs: myTabs,
                  ),
                ),
              ),
              body: TabBarView(
                children: [
                  loading
                      ? Center(
                          child: CircularProgressIndicator(
                              color: Color.fromRGBO(76, 81, 97, 1)),
                        )
                      : SingleChildScrollView(
                          child: Container(
                            width: 490.w,
                            height: 980.h * 0.8,
                            margin: EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: loading
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : GridView.builder(
                                    itemCount: 9,
                                    padding: EdgeInsets.all(10),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                      mainAxisExtent: 93.h,
                                      mainAxisSpacing: 15,
                                    ),
                                    itemBuilder: (context, i) {
                                      final jadwal = _jadwal[i];
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 20,
                                        ),
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.3),
                                              spreadRadius: 0,
                                              blurRadius: 1.5,
                                              offset: Offset(0, 1),
                                            )
                                          ],
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                                margin:
                                                    EdgeInsets.only(right: 40),
                                                child: new Image.asset(
                                                  'assets/images/garis.png',
                                                )),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Kelas 10 IPA ${jadwal.id}',
                                                  style: TextStyle(
                                                    fontFamily:
                                                        'Gilroy-ExtraBold',
                                                    fontSize: 24.w,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  '07:00 - 09:00 WIB',
                                                  style: TextStyle(
                                                    fontFamily: 'Gilroy-Light',
                                                    fontSize: 14.w,
                                                    color: Colors.black,
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
                        ),
                  loading
                      ? Center(
                          child: CircularProgressIndicator(
                              color: Color.fromRGBO(76, 81, 97, 1)),
                        )
                      : SingleChildScrollView(
                          child: Container(
                            width: 490.w,
                            height: 980.h * 0.8,
                            margin: EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: loading
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : GridView.builder(
                                    itemCount: 9,
                                    padding: EdgeInsets.all(10),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                      mainAxisExtent: 93.h,
                                      mainAxisSpacing: 15,
                                    ),
                                    itemBuilder: (context, i) {
                                      final jadwal = _jadwal[i];
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 20,
                                        ),
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.3),
                                              spreadRadius: 0,
                                              blurRadius: 1.5,
                                              offset: Offset(0, 1),
                                            )
                                          ],
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                                margin:
                                                    EdgeInsets.only(right: 40),
                                                child: new Image.asset(
                                                  'assets/images/garis.png',
                                                )),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Kelas 10 IPA ${jadwal.id}',
                                                  style: TextStyle(
                                                    fontFamily:
                                                        'Gilroy-ExtraBold',
                                                    fontSize: 24.w,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  '07:00 - 09:00 WIB',
                                                  style: TextStyle(
                                                    fontFamily: 'Gilroy-Light',
                                                    fontSize: 14.w,
                                                    color: Colors.black,
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
                        ),
                  loading
                      ? Center(
                          child: CircularProgressIndicator(
                              color: Color.fromRGBO(76, 81, 97, 1)),
                        )
                      : SingleChildScrollView(
                          child: Container(
                            width: 490.w,
                            height: 980.h * 0.8,
                            margin: EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: loading
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : GridView.builder(
                                    itemCount: 9,
                                    padding: EdgeInsets.all(10),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                      mainAxisExtent: 93.h,
                                      mainAxisSpacing: 15,
                                    ),
                                    itemBuilder: (context, i) {
                                      final jadwal = _jadwal[i];
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 20,
                                        ),
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.3),
                                              spreadRadius: 0,
                                              blurRadius: 1.5,
                                              offset: Offset(0, 1),
                                            )
                                          ],
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                                margin:
                                                    EdgeInsets.only(right: 40),
                                                child: new Image.asset(
                                                  'assets/images/garis.png',
                                                )),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Kelas 10 IPA ${jadwal.id}',
                                                  style: TextStyle(
                                                    fontFamily:
                                                        'Gilroy-ExtraBold',
                                                    fontSize: 24.w,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  '07:00 - 09:00 WIB',
                                                  style: TextStyle(
                                                    fontFamily: 'Gilroy-Light',
                                                    fontSize: 14.w,
                                                    color: Colors.black,
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
                        ),
                  loading
                      ? Center(
                          child: CircularProgressIndicator(
                              color: Color.fromRGBO(76, 81, 97, 1)),
                        )
                      : SingleChildScrollView(
                          child: Container(
                            width: 490.w,
                            height: 980.h * 0.8,
                            margin: EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: loading
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : GridView.builder(
                                    itemCount: 9,
                                    padding: EdgeInsets.all(10),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                      mainAxisExtent: 93.h,
                                      mainAxisSpacing: 15,
                                    ),
                                    itemBuilder: (context, i) {
                                      final jadwal = _jadwal[i];
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 20,
                                        ),
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.3),
                                              spreadRadius: 0,
                                              blurRadius: 1.5,
                                              offset: Offset(0, 1),
                                            )
                                          ],
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                                margin:
                                                    EdgeInsets.only(right: 40),
                                                child: new Image.asset(
                                                  'assets/images/garis.png',
                                                )),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Kelas 10 IPA ${jadwal.id}',
                                                  style: TextStyle(
                                                    fontFamily:
                                                        'Gilroy-ExtraBold',
                                                    fontSize: 24.w,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  '07:00 - 09:00 WIB',
                                                  style: TextStyle(
                                                    fontFamily: 'Gilroy-Light',
                                                    fontSize: 14.w,
                                                    color: Colors.black,
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
                        ),
                  loading
                      ? Center(
                          child: CircularProgressIndicator(
                              color: Color.fromRGBO(76, 81, 97, 1)),
                        )
                      : SingleChildScrollView(
                          child: Container(
                            width: 490.w,
                            height: 980.h * 0.8,
                            margin: EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: loading
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : GridView.builder(
                                    itemCount: 9,
                                    padding: EdgeInsets.all(10),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                      mainAxisExtent: 93.h,
                                      mainAxisSpacing: 15,
                                    ),
                                    itemBuilder: (context, i) {
                                      final jadwal = _jadwal[i];
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 20,
                                        ),
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.3),
                                              spreadRadius: 0,
                                              blurRadius: 1.5,
                                              offset: Offset(0, 1),
                                            )
                                          ],
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                                margin:
                                                    EdgeInsets.only(right: 40),
                                                child: new Image.asset(
                                                  'assets/images/garis.png',
                                                )),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Kelas 10 IPA ${jadwal.id}',
                                                  style: TextStyle(
                                                    fontFamily:
                                                        'Gilroy-ExtraBold',
                                                    fontSize: 24.w,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  '07:00 - 09:00 WIB',
                                                  style: TextStyle(
                                                    fontFamily: 'Gilroy-Light',
                                                    fontSize: 14.w,
                                                    color: Colors.black,
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
