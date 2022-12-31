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
  final TextEditingController namaController = TextEditingController();
  final TextEditingController rincianController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  List<Test> _fasilitas = [];
  var loading = false;
  var onEdit = false;

  Future fetchData() async {
    setState(() {
      loading = true;
    });
    _fasilitas.clear();
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        for (Map<String, dynamic> i in data) {
          _fasilitas.add(Test.formJson(i));
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

  List<Tab> myTabs = <Tab>[
    Tab(text: 'Terima Pesanan'),
    Tab(text: 'Selesai'),
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
                  //   SingleChildScrollView(
                  //     child: Container(
                  //         width: 490.w,
                  //         height: 980.h * 0.84,
                  //         color: Color.fromRGBO(243, 243, 243, 1),
                  //         child: loadingPesanan
                  //             ? Center(
                  //                 child: CircularProgressIndicator(
                  //                     color: Color.fromRGBO(76, 81, 97, 1)),
                  //               )
                  //             : GridView.builder(
                  //                 padding: EdgeInsets.symmetric(
                  //                   horizontal: 15.w,
                  //                   vertical: 20.h,
                  //                 ),
                  //                 itemCount: _pesananUser.length,
                  //                 gridDelegate:
                  //                     SliverGridDelegateWithFixedCrossAxisCount(
                  //                   crossAxisCount: 1,
                  //                   mainAxisExtent: 225.h,
                  //                   mainAxisSpacing: 15.w,
                  //                 ),
                  //                 itemBuilder: ((context, i) {
                  //                   final pesanan = _pesananUser[i];
                  //                   return Container(
                  //                     padding: EdgeInsets.symmetric(
                  //                       horizontal: 5,
                  //                     ),
                  //                     decoration: BoxDecoration(
                  //                       color: Colors.white,
                  //                       boxShadow: [
                  //                         BoxShadow(
                  //                           color: Colors.black.withOpacity(0.3),
                  //                           spreadRadius: 0,
                  //                           blurRadius: 1.5,
                  //                           offset: Offset(0, 0),
                  //                         )
                  //                       ],
                  //                       borderRadius: BorderRadius.circular(7),
                  //                     ),
                  //                     child: Column(
                  //                       mainAxisAlignment:
                  //                           MainAxisAlignment.spaceEvenly,
                  //                       crossAxisAlignment:
                  //                           CrossAxisAlignment.center,
                  //                       children: [
                  //                         Container(
                  //                           width: 437.w,
                  //                           height: 32.h,
                  //                           child: Column(
                  //                             mainAxisAlignment:
                  //                                 MainAxisAlignment.spaceBetween,
                  //                             crossAxisAlignment:
                  //                                 CrossAxisAlignment.center,
                  //                             children: [
                  //                               Row(
                  //                                 mainAxisAlignment:
                  //                                     MainAxisAlignment
                  //                                         .spaceBetween,
                  //                                 crossAxisAlignment:
                  //                                     CrossAxisAlignment.center,
                  //                                 children: [
                  //                                   Text(
                  //                                     'No Pesanan :',
                  //                                     style: TextStyle(
                  //                                       fontFamily:
                  //                                           'Gilroy-ExtraBold',
                  //                                       fontSize: 13.w,
                  //                                       color: Color.fromRGBO(
                  //                                           76, 81, 97, 1),
                  //                                     ),
                  //                                   ),
                  //                                   Text(
                  //                                     pesanan.no_pemesanan,
                  //                                     style: TextStyle(
                  //                                       fontFamily:
                  //                                           'Gilroy-Light',
                  //                                       fontSize: 13.w,
                  //                                       color: Color.fromRGBO(
                  //                                           76, 81, 97, 1),
                  //                                     ),
                  //                                   ),
                  //                                 ],
                  //                               ),
                  //                               Row(
                  //                                 mainAxisAlignment:
                  //                                     MainAxisAlignment
                  //                                         .spaceBetween,
                  //                                 crossAxisAlignment:
                  //                                     CrossAxisAlignment.center,
                  //                                 children: [
                  //                                   Text(
                  //                                     'Waktu Pemesanan',
                  //                                     style: TextStyle(
                  //                                       fontFamily:
                  //                                           'Gilroy-Light',
                  //                                       fontSize: 13.w,
                  //                                       color: Color.fromRGBO(
                  //                                           76, 81, 97, 1),
                  //                                     ),
                  //                                   ),
                  //                                   Text(
                  //                                     DateFormat(
                  //                                             'EEEE, d MMMM yyyy')
                  //                                         .format(DateTime.parse(
                  //                                             pesanan
                  //                                                 .tgl_pemesanan))
                  //                                         .toString(),
                  //                                     style: TextStyle(
                  //                                       fontFamily:
                  //                                           'Gilroy-Light',
                  //                                       fontSize: 13.w,
                  //                                       color: Color.fromRGBO(
                  //                                           76, 81, 97, 1),
                  //                                     ),
                  //                                   ),
                  //                                 ],
                  //                               ),
                  //                             ],
                  //                           ),
                  //                         ),
                  //                         Divider(
                  //                           color: Color.fromRGBO(76, 81, 97, 1),
                  //                         ),
                  //                         Container(
                  //                           width: 437.w,
                  //                           height: 99.h,
                  //                           child: Row(
                  //                             mainAxisAlignment:
                  //                                 MainAxisAlignment.spaceBetween,
                  //                             crossAxisAlignment:
                  //                                 CrossAxisAlignment.center,
                  //                             children: [
                  //                               Container(
                  //                                 width: 89.w,
                  //                                 height: 97.h,
                  //                                 decoration: BoxDecoration(
                  //                                   borderRadius:
                  //                                       BorderRadius.circular(5),
                  //                                 ),
                  //                                 child: Image.network(
                  //                                   Api.image + _menu[0].image,
                  //                                   fit: BoxFit.cover,
                  //                                 ),
                  //                               ),
                  //                               Container(
                  //                                 width: 329.w,
                  //                                 height: 99.h,
                  //                                 child: Column(
                  //                                   mainAxisAlignment:
                  //                                       MainAxisAlignment
                  //                                           .spaceBetween,
                  //                                   crossAxisAlignment:
                  //                                       CrossAxisAlignment.start,
                  //                                   children: [
                  //                                     Text(
                  //                                       'Dapur ${_stand[0].nama_stand}, Kode : ${_stand[0].kode_stand}',
                  //                                       style: TextStyle(
                  //                                         fontFamily:
                  //                                             'Gilroy-ExtraBold',
                  //                                         fontSize: 13,
                  //                                         color: Color.fromRGBO(
                  //                                             76, 81, 97, 1),
                  //                                       ),
                  //                                     ),
                  //                                     Container(
                  //                                       width: 329.w,
                  //                                       height: 45.h,
                  //                                       child: GridView.builder(
                  //                                         itemCount: 1,
                  //                                         gridDelegate:
                  //                                             SliverGridDelegateWithFixedCrossAxisCount(
                  //                                                 crossAxisCount:
                  //                                                     1,
                  //                                                 mainAxisExtent:
                  //                                                     15.h),
                  //                                         itemBuilder:
                  //                                             (context, i) {
                  //                                           return Row(
                  //                                             mainAxisAlignment:
                  //                                                 MainAxisAlignment
                  //                                                     .spaceBetween,
                  //                                             crossAxisAlignment:
                  //                                                 CrossAxisAlignment
                  //                                                     .center,
                  //                                             children: [
                  //                                               Text(
                  //                                                 '- ${_menu[0].nama_menu}',
                  //                                                 style:
                  //                                                     TextStyle(
                  //                                                   fontFamily:
                  //                                                       'Gilroy-Light',
                  //                                                   fontSize: 13,
                  //                                                   color: Color
                  //                                                       .fromRGBO(
                  //                                                           76,
                  //                                                           81,
                  //                                                           97,
                  //                                                           1),
                  //                                                 ),
                  //                                               ),
                  //                                               Text(
                  //                                                 convertToIdr(
                  //                                                     int.parse(
                  //                                                         _menu[0]
                  //                                                             .harga),
                  //                                                     0),
                  //                                                 style:
                  //                                                     TextStyle(
                  //                                                   fontFamily:
                  //                                                       'Gilroy-Light',
                  //                                                   fontSize: 13,
                  //                                                   color: Color
                  //                                                       .fromRGBO(
                  //                                                           242,
                  //                                                           78,
                  //                                                           26,
                  //                                                           1),
                  //                                                 ),
                  //                                               ),
                  //                                             ],
                  //                                           );
                  //                                         },
                  //                                       ),
                  //                                     ),
                  //                                     Container(
                  //                                       width: 329.w,
                  //                                       height: 36.h,
                  //                                       child: Center(
                  //                                         child: Row(
                  //                                           mainAxisAlignment:
                  //                                               MainAxisAlignment
                  //                                                   .spaceBetween,
                  //                                           crossAxisAlignment:
                  //                                               CrossAxisAlignment
                  //                                                   .center,
                  //                                           children: [
                  //                                             Text(
                  //                                               'Total Pembayaran',
                  //                                               style: TextStyle(
                  //                                                 fontFamily:
                  //                                                     'Gilroy-Light',
                  //                                                 fontSize: 13,
                  //                                                 color: Color
                  //                                                     .fromRGBO(
                  //                                                         76,
                  //                                                         81,
                  //                                                         97,
                  //                                                         1),
                  //                                               ),
                  //                                             ),
                  //                                             Text(
                  //                                               convertToIdr(
                  //                                                   int.parse(
                  //                                                       pesanan
                  //                                                           .total),
                  //                                                   0),
                  //                                               style: TextStyle(
                  //                                                 fontFamily:
                  //                                                     'Gilroy-Light',
                  //                                                 fontSize: 16,
                  //                                                 color: Color
                  //                                                     .fromRGBO(
                  //                                                         242,
                  //                                                         78,
                  //                                                         26,
                  //                                                         1),
                  //                                               ),
                  //                                             ),
                  //                                           ],
                  //                                         ),
                  //                                       ),
                  //                                     ),
                  //                                   ],
                  //                                 ),
                  //                               ),
                  //                             ],
                  //                           ),
                  //                         ),
                  //                         Align(
                  //                           alignment: Alignment(0.97, 0.0),
                  //                           child: GestureDetector(
                  //                             onTap: () {},
                  //                             child: Container(
                  //                               width: 145.w,
                  //                               height: 36.h,
                  //                               decoration: BoxDecoration(
                  //                                 borderRadius:
                  //                                     BorderRadius.circular(6),
                  //                                 color: Color.fromRGBO(
                  //                                     242, 78, 26, 1),
                  //                               ),
                  //                               child: Center(
                  //                                 child: Text(
                  //                                   'Selesai',
                  //                                   style: TextStyle(
                  //                                     fontFamily:
                  //                                         'Gilroy-ExtraBold',
                  //                                     fontSize: 15,
                  //                                     color: Colors.white,
                  //                                   ),
                  //                                 ),
                  //                               ),
                  //                             ),
                  //                           ),
                  //                         ),
                  //                       ],
                  //                     ),
                  //                   );
                  //                 }))),
                  //   ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
