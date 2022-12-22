import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'model.dart';

class DetailNilaiBelajarAdminProfil extends StatefulWidget {
  Test profil;
  DetailNilaiBelajarAdminProfil({super.key, required this.profil});
  @override
  _DetailNilaiBelajarAdminProfilState createState() =>
      new _DetailNilaiBelajarAdminProfilState(profil);
}

class _DetailNilaiBelajarAdminProfilState
    extends State<DetailNilaiBelajarAdminProfil> {
  List<Test> _nilai = [];

  var loading = false;

  Future<Null> fetchData() async {
    setState(() {
      loading = true;
    });
    _nilai.clear();
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        for (Map<String, dynamic> i in data) {
          _nilai.add(Test.formJson(i));
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

  final TextEditingController tugas1Controller = TextEditingController();
  final TextEditingController tugas2Controller = TextEditingController();
  final TextEditingController tugas3Controller = TextEditingController();
  final TextEditingController utsController = TextEditingController();
  final TextEditingController uasController = TextEditingController();
  final _formKeyTugas1 = GlobalKey<FormState>();
  final _formKeyTugas2 = GlobalKey<FormState>();
  final _formKeyTugas3 = GlobalKey<FormState>();
  final _formKeyUts = GlobalKey<FormState>();
  final _formKeyUas = GlobalKey<FormState>();

  onEdit(Test nilai) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              width: 461.w,
              height: 372.h,
              padding: EdgeInsets.symmetric(
                vertical: 10,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment(-0.75, 0.0),
                    child: Text(
                      'Bahasa Indonesia',
                      style: TextStyle(
                        fontFamily: 'Gilroy-ExtraBold',
                        fontSize: 20.w,
                        color: Color.fromRGBO(76, 81, 97, 1),
                      ),
                    ),
                  ),
                  Divider(
                    color: Color.fromRGBO(76, 81, 97, 1),
                  ),
                  Container(
                    width: 343.w,
                    height: 46.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Tugas 1',
                          style: TextStyle(
                            fontFamily: 'Gilroy-Light',
                            fontSize: 16.w,
                            color: Color.fromRGBO(76, 81, 97, 1),
                          ),
                        ),
                        Container(
                          width: 60.w,
                          height: 28.h,
                          color: Color.fromRGBO(243, 243, 243, 1),
                          child: Form(
                            key: _formKeyTugas1,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              controller: tugas1Controller,
                              maxLines: 1,
                              style: TextStyle(
                                fontFamily: 'Gilroy-ExtraBold',
                                fontSize: 16.w,
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 343.w,
                    height: 46.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Tugas 2',
                          style: TextStyle(
                            fontFamily: 'Gilroy-Light',
                            fontSize: 16.w,
                            color: Color.fromRGBO(76, 81, 97, 1),
                          ),
                        ),
                        Container(
                          width: 60.w,
                          height: 28.h,
                          color: Color.fromRGBO(243, 243, 243, 1),
                          child: Form(
                            key: _formKeyTugas2,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              controller: tugas2Controller,
                              maxLines: 1,
                              style: TextStyle(
                                fontFamily: 'Gilroy-ExtraBold',
                                fontSize: 16.w,
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 343.w,
                    height: 46.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Tugas 3',
                          style: TextStyle(
                            fontFamily: 'Gilroy-Light',
                            fontSize: 16.w,
                            color: Color.fromRGBO(76, 81, 97, 1),
                          ),
                        ),
                        Container(
                          width: 60.w,
                          height: 28.h,
                          color: Color.fromRGBO(243, 243, 243, 1),
                          child: Form(
                            key: _formKeyTugas3,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              controller: tugas3Controller,
                              maxLines: 1,
                              style: TextStyle(
                                fontFamily: 'Gilroy-ExtraBold',
                                fontSize: 16.w,
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 343.w,
                    height: 46.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Uts',
                          style: TextStyle(
                            fontFamily: 'Gilroy-Light',
                            fontSize: 16.w,
                            color: Color.fromRGBO(76, 81, 97, 1),
                          ),
                        ),
                        Container(
                          width: 60.w,
                          height: 28.h,
                          color: Color.fromRGBO(243, 243, 243, 1),
                          child: Form(
                            key: _formKeyUts,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              controller: utsController,
                              maxLines: 1,
                              style: TextStyle(
                                fontFamily: 'Gilroy-ExtraBold',
                                fontSize: 16.w,
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 343.w,
                    height: 46.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Uas',
                          style: TextStyle(
                            fontFamily: 'Gilroy-Light',
                            fontSize: 16.w,
                            color: Color.fromRGBO(76, 81, 97, 1),
                          ),
                        ),
                        Container(
                          width: 60.w,
                          height: 28.h,
                          color: Color.fromRGBO(243, 243, 243, 1),
                          child: Form(
                            key: _formKeyUas,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              controller: uasController,
                              maxLines: 1,
                              style: TextStyle(
                                fontFamily: 'Gilroy-ExtraBold',
                                fontSize: 16.w,
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 353.w,
                    height: 30.h,
                    margin: EdgeInsets.symmetric(
                      vertical: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            width: 91.w,
                            height: 30.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color.fromRGBO(242, 78, 26, 1),
                            ),
                            child: Center(
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  fontFamily: 'Gilroy-Light',
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 91.w,
                            height: 30.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.black,
                            ),
                            child: Center(
                              child: Text(
                                'Send',
                                style: TextStyle(
                                  fontFamily: 'Gilroy-Light',
                                  fontSize: 14,
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

  onEditKeterampilan(Test nilai) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              width: 461.w,
              height: 372.h,
              padding: EdgeInsets.symmetric(
                vertical: 10,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment(-0.75, 0.0),
                    child: Text(
                      'Bahasa Indonesia',
                      style: TextStyle(
                        fontFamily: 'Gilroy-ExtraBold',
                        fontSize: 20.w,
                        color: Color.fromRGBO(76, 81, 97, 1),
                      ),
                    ),
                  ),
                  Divider(
                    color: Color.fromRGBO(76, 81, 97, 1),
                  ),
                  Container(
                    width: 343.w,
                    height: 46.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Tugas Keterampilan 1',
                          style: TextStyle(
                            fontFamily: 'Gilroy-Light',
                            fontSize: 16.w,
                            color: Color.fromRGBO(76, 81, 97, 1),
                          ),
                        ),
                        Container(
                          width: 60.w,
                          height: 28.h,
                          color: Color.fromRGBO(243, 243, 243, 1),
                          child: Form(
                            key: _formKeyTugas1,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              controller: tugas1Controller,
                              maxLines: 1,
                              style: TextStyle(
                                fontFamily: 'Gilroy-ExtraBold',
                                fontSize: 16.w,
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 343.w,
                    height: 46.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Tugas Keterampilan 2',
                          style: TextStyle(
                            fontFamily: 'Gilroy-Light',
                            fontSize: 16.w,
                            color: Color.fromRGBO(76, 81, 97, 1),
                          ),
                        ),
                        Container(
                          width: 60.w,
                          height: 28.h,
                          color: Color.fromRGBO(243, 243, 243, 1),
                          child: Form(
                            key: _formKeyTugas2,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              controller: tugas2Controller,
                              maxLines: 1,
                              style: TextStyle(
                                fontFamily: 'Gilroy-ExtraBold',
                                fontSize: 16.w,
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 343.w,
                    height: 46.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Tugas Keterampilan 3',
                          style: TextStyle(
                            fontFamily: 'Gilroy-Light',
                            fontSize: 16.w,
                            color: Color.fromRGBO(76, 81, 97, 1),
                          ),
                        ),
                        Container(
                          width: 60.w,
                          height: 28.h,
                          color: Color.fromRGBO(243, 243, 243, 1),
                          child: Form(
                            key: _formKeyTugas3,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              controller: tugas3Controller,
                              maxLines: 1,
                              style: TextStyle(
                                fontFamily: 'Gilroy-ExtraBold',
                                fontSize: 16.w,
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 343.w,
                    height: 46.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Uts',
                          style: TextStyle(
                            fontFamily: 'Gilroy-Light',
                            fontSize: 16.w,
                            color: Color.fromRGBO(76, 81, 97, 1),
                          ),
                        ),
                        Container(
                          width: 60.w,
                          height: 28.h,
                          color: Color.fromRGBO(243, 243, 243, 1),
                          child: Form(
                            key: _formKeyUts,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              controller: utsController,
                              maxLines: 1,
                              style: TextStyle(
                                fontFamily: 'Gilroy-ExtraBold',
                                fontSize: 16.w,
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 343.w,
                    height: 46.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Uas',
                          style: TextStyle(
                            fontFamily: 'Gilroy-Light',
                            fontSize: 16.w,
                            color: Color.fromRGBO(76, 81, 97, 1),
                          ),
                        ),
                        Container(
                          width: 60.w,
                          height: 28.h,
                          color: Color.fromRGBO(243, 243, 243, 1),
                          child: Form(
                            key: _formKeyUas,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              controller: uasController,
                              maxLines: 1,
                              style: TextStyle(
                                fontFamily: 'Gilroy-ExtraBold',
                                fontSize: 16.w,
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 353.w,
                    height: 30.h,
                    margin: EdgeInsets.symmetric(
                      vertical: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            width: 91.w,
                            height: 30.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color.fromRGBO(242, 78, 26, 1),
                            ),
                            child: Center(
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  fontFamily: 'Gilroy-Light',
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 91.w,
                            height: 30.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.black,
                            ),
                            child: Center(
                              child: Text(
                                'Send',
                                style: TextStyle(
                                  fontFamily: 'Gilroy-Light',
                                  fontSize: 14,
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

  var mapel = ['Matematika', 'Bahasa Indonesia', 'Bahasa Inggris'];

  List<Tab> myTabs = <Tab>[
    Tab(text: 'Pengetahuan'),
    Tab(text: 'Keterampilan'),
  ];

  @override
  Test profil;
  _DetailNilaiBelajarAdminProfilState(this.profil);
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
        return new MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SafeArea(
            child: DefaultTabController(
              length: myTabs.length,
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.white,
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(75.h),
                  child: AppBar(
                    backgroundColor: Color.fromRGBO(255, 217, 102, 1),
                    title: Align(
                      alignment: Alignment(-0.7, 0.0),
                      child: Text(
                        'Nilai Belajar',
                        style: TextStyle(
                          fontFamily: 'Gilroy-ExtraBold',
                          fontSize: 24.w.w,
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
                          size: 40.w,
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
                        width: 490.w,
                        height: 980.h,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 490.w * 0.85,
                                height: 115.h,
                                margin: EdgeInsets.only(
                                  top: 20,
                                  bottom: 20,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ClipOval(
                                      child: Image.asset(
                                        'assets/images/profil.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Container(
                                      width: 490.w * 0.55,
                                      height: 102.h,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            profil.name,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontFamily: 'Gilroy-ExtraBold',
                                              fontSize: 22.w,
                                            ),
                                          ),
                                          Text(
                                            'NIS : ${profil.phone}',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontFamily: 'Gilroy-Light',
                                              fontSize: 16.w,
                                              color:
                                                  Color.fromRGBO(76, 81, 97, 1),
                                            ),
                                          ),
                                          Text(
                                            'Kelas : X IPA ${profil.id}',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy-Light',
                                              fontSize: 16.w,
                                              color:
                                                  Color.fromRGBO(76, 81, 97, 1),
                                            ),
                                          ),
                                          Text(
                                            'Tahun Ajaran : 2020/2021',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy-Light',
                                              fontSize: 16.w,
                                              color:
                                                  Color.fromRGBO(76, 81, 97, 1),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                color: Color.fromRGBO(217, 217, 217, 1),
                              ),
                              Container(
                                width: 490.w,
                                height: 79.h,
                                child: Center(
                                  child: TabBar(
                                    padding: EdgeInsets.only(bottom: 10),
                                    indicatorColor:
                                        Color.fromRGBO(76, 81, 97, 1),
                                    indicatorSize: TabBarIndicatorSize.label,
                                    labelColor: Color.fromRGBO(76, 81, 97, 1),
                                    unselectedLabelColor:
                                        Color.fromRGBO(76, 81, 97, 1),
                                    labelStyle: TextStyle(
                                      fontFamily: 'Gilroy-ExtraBold',
                                      fontSize: 20.w,
                                      color: Color.fromRGBO(76, 81, 97, 1),
                                    ),
                                    unselectedLabelStyle: TextStyle(
                                      fontFamily: 'Gilroy-Light',
                                      fontSize: 20.w,
                                      color: Color.fromRGBO(76, 81, 97, 1),
                                    ),
                                    tabs: myTabs,
                                  ),
                                ),
                              ),
                              Container(
                                width: 490.w,
                                height: 980.h * 0.63,
                                child: TabBarView(
                                  children: [
                                    SingleChildScrollView(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Align(
                                            alignment: Alignment(-0.9, 0.0),
                                            child: Text(
                                              'Semester Ganjil',
                                              style: TextStyle(
                                                fontFamily: 'Gilroy-ExtraBold',
                                                fontSize: 18.w,
                                                color: Color.fromRGBO(
                                                    76, 81, 97, 1),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 490.w,
                                            height: 335.h,
                                            margin: EdgeInsets.only(
                                              bottom: 20,
                                            ),
                                            child: GridView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: mapel.length,
                                              padding: EdgeInsets.all(10),
                                              gridDelegate:
                                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                                maxCrossAxisExtent: 330.h,
                                                mainAxisExtent: 461.w,
                                                mainAxisSpacing: 10,
                                              ),
                                              itemBuilder: (context, i) {
                                                final nilai = _nilai[i];
                                                return GestureDetector(
                                                  onTap: () {
                                                    onEdit(nilai);
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.black
                                                              .withOpacity(0.2),
                                                          spreadRadius: 0,
                                                          blurRadius: 1.5,
                                                          offset: Offset(0, 0),
                                                        )
                                                      ],
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          width: 490.w,
                                                          height: 47.h,
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            horizontal: 40.w,
                                                            vertical: 10.h,
                                                          ),
                                                          child: Text(
                                                            mapel[i],
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-ExtraBold',
                                                              fontSize: 20.w,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      76,
                                                                      81,
                                                                      97,
                                                                      1),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 490.w,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                width: 0.25,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        76,
                                                                        81,
                                                                        97,
                                                                        0.37)),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 490.w,
                                                          height: 198.h,
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            horizontal: 40.w,
                                                          ),
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
                                                                    child: Text(
                                                                      'Tugas 1',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Gilroy-light',
                                                                        fontSize:
                                                                            16.w,
                                                                        color: Color.fromRGBO(
                                                                            76,
                                                                            81,
                                                                            97,
                                                                            1),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child: Text(
                                                                      '88',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Gilroy-ExtraBold',
                                                                        fontSize:
                                                                            16.w,
                                                                        color: Color.fromRGBO(
                                                                            76,
                                                                            81,
                                                                            97,
                                                                            1),
                                                                      ),
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
                                                                    child: Text(
                                                                      'Tugas 2',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Gilroy-light',
                                                                        fontSize:
                                                                            16.w,
                                                                        color: Color.fromRGBO(
                                                                            76,
                                                                            81,
                                                                            97,
                                                                            1),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child: Text(
                                                                      '88',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Gilroy-ExtraBold',
                                                                        fontSize:
                                                                            16.w,
                                                                        color: Color.fromRGBO(
                                                                            76,
                                                                            81,
                                                                            97,
                                                                            1),
                                                                      ),
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
                                                                    child: Text(
                                                                      'Tugas 3',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Gilroy-light',
                                                                        fontSize:
                                                                            16.w,
                                                                        color: Color.fromRGBO(
                                                                            76,
                                                                            81,
                                                                            97,
                                                                            1),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child: Text(
                                                                      '88',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Gilroy-ExtraBold',
                                                                        fontSize:
                                                                            16.w,
                                                                        color: Color.fromRGBO(
                                                                            76,
                                                                            81,
                                                                            97,
                                                                            1),
                                                                      ),
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
                                                                    child: Text(
                                                                      'UTS',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Gilroy-light',
                                                                        fontSize:
                                                                            16.w,
                                                                        color: Color.fromRGBO(
                                                                            76,
                                                                            81,
                                                                            97,
                                                                            1),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child: Text(
                                                                      '-',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Gilroy-ExtraBold',
                                                                        fontSize:
                                                                            16.w,
                                                                        color: Color.fromRGBO(
                                                                            76,
                                                                            81,
                                                                            97,
                                                                            1),
                                                                      ),
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
                                                                    child: Text(
                                                                      'UAS',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Gilroy-light',
                                                                        fontSize:
                                                                            16.w,
                                                                        color: Color.fromRGBO(
                                                                            76,
                                                                            81,
                                                                            97,
                                                                            1),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child: Text(
                                                                      '-',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Gilroy-ExtraBold',
                                                                        fontSize:
                                                                            16.w,
                                                                        color: Color.fromRGBO(
                                                                            76,
                                                                            81,
                                                                            97,
                                                                            1),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 490.w,
                                                          height: 47.h,
                                                          padding:
                                                              EdgeInsets.only(
                                                            left: 120.w,
                                                            right: 70.w,
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              bottomLeft: Radius
                                                                  .circular(10),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            color:
                                                                Color.fromRGBO(
                                                                    243,
                                                                    243,
                                                                    243,
                                                                    1),
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                'Total (rata-rata)',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-ExtraBold',
                                                                  fontSize:
                                                                      16.w,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          76,
                                                                          81,
                                                                          97,
                                                                          1),
                                                                ),
                                                              ),
                                                              Text(
                                                                '88',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-ExtraBold',
                                                                  fontSize:
                                                                      16.w,
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
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment(-0.9, 0.0),
                                            child: Text(
                                              'Semester Genap',
                                              style: TextStyle(
                                                fontFamily: 'Gilroy-ExtraBold',
                                                fontSize: 18.w,
                                                color: Color.fromRGBO(
                                                    76, 81, 97, 1),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 490.w,
                                            height: 335.h,
                                            margin: EdgeInsets.only(
                                              bottom: 20,
                                            ),
                                            child: GridView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: mapel.length,
                                              padding: EdgeInsets.all(10),
                                              gridDelegate:
                                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                                maxCrossAxisExtent: 330.h,
                                                mainAxisExtent: 461.w,
                                                mainAxisSpacing: 10,
                                              ),
                                              itemBuilder: (context, i) {
                                                final nilai = _nilai[i];
                                                return GestureDetector(
                                                  onTap: () {
                                                    onEdit(nilai);
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.black
                                                              .withOpacity(0.2),
                                                          spreadRadius: 0,
                                                          blurRadius: 1.5,
                                                          offset: Offset(0, 0),
                                                        )
                                                      ],
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          width: 490.w,
                                                          height: 47.h,
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            horizontal: 40.w,
                                                            vertical: 10.h,
                                                          ),
                                                          child: Text(
                                                            mapel[i],
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-ExtraBold',
                                                              fontSize: 20.w,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      76,
                                                                      81,
                                                                      97,
                                                                      1),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 490.w,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                width: 0.25,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        76,
                                                                        81,
                                                                        97,
                                                                        0.37)),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 490.w,
                                                          height: 198.h,
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            horizontal: 40.w,
                                                          ),
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
                                                                    child: Text(
                                                                      'Tugas 1',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Gilroy-light',
                                                                        fontSize:
                                                                            16.w,
                                                                        color: Color.fromRGBO(
                                                                            76,
                                                                            81,
                                                                            97,
                                                                            1),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child: Text(
                                                                      '88',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Gilroy-ExtraBold',
                                                                        fontSize:
                                                                            16.w,
                                                                        color: Color.fromRGBO(
                                                                            76,
                                                                            81,
                                                                            97,
                                                                            1),
                                                                      ),
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
                                                                    child: Text(
                                                                      'Tugas 2',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Gilroy-light',
                                                                        fontSize:
                                                                            16.w,
                                                                        color: Color.fromRGBO(
                                                                            76,
                                                                            81,
                                                                            97,
                                                                            1),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child: Text(
                                                                      '88',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Gilroy-ExtraBold',
                                                                        fontSize:
                                                                            16.w,
                                                                        color: Color.fromRGBO(
                                                                            76,
                                                                            81,
                                                                            97,
                                                                            1),
                                                                      ),
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
                                                                    child: Text(
                                                                      'Tugas 3',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Gilroy-light',
                                                                        fontSize:
                                                                            16.w,
                                                                        color: Color.fromRGBO(
                                                                            76,
                                                                            81,
                                                                            97,
                                                                            1),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child: Text(
                                                                      '88',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Gilroy-ExtraBold',
                                                                        fontSize:
                                                                            16.w,
                                                                        color: Color.fromRGBO(
                                                                            76,
                                                                            81,
                                                                            97,
                                                                            1),
                                                                      ),
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
                                                                    child: Text(
                                                                      'UTS',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Gilroy-light',
                                                                        fontSize:
                                                                            16.w,
                                                                        color: Color.fromRGBO(
                                                                            76,
                                                                            81,
                                                                            97,
                                                                            1),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child: Text(
                                                                      '-',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Gilroy-ExtraBold',
                                                                        fontSize:
                                                                            16.w,
                                                                        color: Color.fromRGBO(
                                                                            76,
                                                                            81,
                                                                            97,
                                                                            1),
                                                                      ),
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
                                                                    child: Text(
                                                                      'UAS',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Gilroy-light',
                                                                        fontSize:
                                                                            16.w,
                                                                        color: Color.fromRGBO(
                                                                            76,
                                                                            81,
                                                                            97,
                                                                            1),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child: Text(
                                                                      '-',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Gilroy-ExtraBold',
                                                                        fontSize:
                                                                            16.w,
                                                                        color: Color.fromRGBO(
                                                                            76,
                                                                            81,
                                                                            97,
                                                                            1),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 490.w,
                                                          height: 47.h,
                                                          padding:
                                                              EdgeInsets.only(
                                                            left: 120.w,
                                                            right: 70.w,
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              bottomLeft: Radius
                                                                  .circular(10),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            color:
                                                                Color.fromRGBO(
                                                                    243,
                                                                    243,
                                                                    243,
                                                                    1),
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                'Total (rata-rata)',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-ExtraBold',
                                                                  fontSize:
                                                                      16.w,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          76,
                                                                          81,
                                                                          97,
                                                                          1),
                                                                ),
                                                              ),
                                                              Text(
                                                                '88',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-ExtraBold',
                                                                  fontSize:
                                                                      16.w,
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
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SingleChildScrollView(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Align(
                                            alignment: Alignment(-0.9, 0.0),
                                            child: Text(
                                              'Semester Ganjil',
                                              style: TextStyle(
                                                fontFamily: 'Gilroy-ExtraBold',
                                                fontSize: 18.w,
                                                color: Color.fromRGBO(
                                                    76, 81, 97, 1),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 490.w,
                                            height: 335.h,
                                            margin: EdgeInsets.only(
                                              bottom: 20,
                                            ),
                                            child: GridView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: mapel.length,
                                              padding: EdgeInsets.all(10),
                                              gridDelegate:
                                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                                maxCrossAxisExtent: 330.h,
                                                mainAxisExtent: 461.w,
                                                mainAxisSpacing: 10,
                                              ),
                                              itemBuilder: (context, i) {
                                                final nilai = _nilai[i];
                                                return GestureDetector(
                                                  onTap: () {
                                                    onEditKeterampilan(nilai);
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.black
                                                              .withOpacity(0.2),
                                                          spreadRadius: 0,
                                                          blurRadius: 1.5,
                                                          offset: Offset(0, 0),
                                                        )
                                                      ],
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          width: 490.w,
                                                          height: 47.h,
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            horizontal: 40.w,
                                                            vertical: 10.h,
                                                          ),
                                                          child: Text(
                                                            mapel[i],
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-ExtraBold',
                                                              fontSize: 20.w,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      76,
                                                                      81,
                                                                      97,
                                                                      1),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 490.w,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                width: 0.25,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        76,
                                                                        81,
                                                                        97,
                                                                        0.37)),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 490.w,
                                                          height: 198.h,
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            horizontal: 40.w,
                                                          ),
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
                                                                    child: Text(
                                                                      'Tugas Keterampilan 1',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Gilroy-light',
                                                                        fontSize:
                                                                            16.w,
                                                                        color: Color.fromRGBO(
                                                                            76,
                                                                            81,
                                                                            97,
                                                                            1),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child: Text(
                                                                      '88',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Gilroy-ExtraBold',
                                                                        fontSize:
                                                                            16.w,
                                                                        color: Color.fromRGBO(
                                                                            76,
                                                                            81,
                                                                            97,
                                                                            1),
                                                                      ),
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
                                                                    child: Text(
                                                                      'Tugas Keterampilan 2',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Gilroy-light',
                                                                        fontSize:
                                                                            16.w,
                                                                        color: Color.fromRGBO(
                                                                            76,
                                                                            81,
                                                                            97,
                                                                            1),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child: Text(
                                                                      '88',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Gilroy-ExtraBold',
                                                                        fontSize:
                                                                            16.w,
                                                                        color: Color.fromRGBO(
                                                                            76,
                                                                            81,
                                                                            97,
                                                                            1),
                                                                      ),
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
                                                                    child: Text(
                                                                      'Tugas Keterampilan 3',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Gilroy-light',
                                                                        fontSize:
                                                                            16.w,
                                                                        color: Color.fromRGBO(
                                                                            76,
                                                                            81,
                                                                            97,
                                                                            1),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child: Text(
                                                                      '88',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Gilroy-ExtraBold',
                                                                        fontSize:
                                                                            16.w,
                                                                        color: Color.fromRGBO(
                                                                            76,
                                                                            81,
                                                                            97,
                                                                            1),
                                                                      ),
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
                                                                    child: Text(
                                                                      'UTS',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Gilroy-light',
                                                                        fontSize:
                                                                            16.w,
                                                                        color: Color.fromRGBO(
                                                                            76,
                                                                            81,
                                                                            97,
                                                                            1),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child: Text(
                                                                      '-',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Gilroy-ExtraBold',
                                                                        fontSize:
                                                                            16.w,
                                                                        color: Color.fromRGBO(
                                                                            76,
                                                                            81,
                                                                            97,
                                                                            1),
                                                                      ),
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
                                                                    child: Text(
                                                                      'UAS',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Gilroy-light',
                                                                        fontSize:
                                                                            16.w,
                                                                        color: Color.fromRGBO(
                                                                            76,
                                                                            81,
                                                                            97,
                                                                            1),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child: Text(
                                                                      '-',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Gilroy-ExtraBold',
                                                                        fontSize:
                                                                            16.w,
                                                                        color: Color.fromRGBO(
                                                                            76,
                                                                            81,
                                                                            97,
                                                                            1),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 490.w,
                                                          height: 47.h,
                                                          padding:
                                                              EdgeInsets.only(
                                                            left: 120.w,
                                                            right: 70.w,
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              bottomLeft: Radius
                                                                  .circular(10),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            color:
                                                                Color.fromRGBO(
                                                                    243,
                                                                    243,
                                                                    243,
                                                                    1),
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                'Total (rata-rata)',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-ExtraBold',
                                                                  fontSize:
                                                                      16.w,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          76,
                                                                          81,
                                                                          97,
                                                                          1),
                                                                ),
                                                              ),
                                                              Text(
                                                                '88',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-ExtraBold',
                                                                  fontSize:
                                                                      16.w,
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
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment(-0.9, 0.0),
                                            child: Text(
                                              'Semester Genap',
                                              style: TextStyle(
                                                fontFamily: 'Gilroy-ExtraBold',
                                                fontSize: 18.w,
                                                color: Color.fromRGBO(
                                                    76, 81, 97, 1),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 490.w,
                                            height: 335.h,
                                            margin: EdgeInsets.only(
                                              bottom: 20,
                                            ),
                                            child: GridView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: mapel.length,
                                              padding: EdgeInsets.all(10),
                                              gridDelegate:
                                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                                maxCrossAxisExtent: 330.h,
                                                mainAxisExtent: 461.w,
                                                mainAxisSpacing: 10,
                                              ),
                                              itemBuilder: (context, i) {
                                                final nilai = _nilai[i];
                                                return GestureDetector(
                                                  onTap: () {
                                                    onEditKeterampilan(nilai);
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.black
                                                              .withOpacity(0.2),
                                                          spreadRadius: 0,
                                                          blurRadius: 1.5,
                                                          offset: Offset(0, 0),
                                                        )
                                                      ],
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          width: 490.w,
                                                          height: 47.h,
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            horizontal: 40.w,
                                                            vertical: 10.h,
                                                          ),
                                                          child: Text(
                                                            mapel[i],
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-ExtraBold',
                                                              fontSize: 20.w,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      76,
                                                                      81,
                                                                      97,
                                                                      1),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 490.w,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                width: 0.25,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        76,
                                                                        81,
                                                                        97,
                                                                        0.37)),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 490.w,
                                                          height: 198.h,
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            horizontal: 40.w,
                                                          ),
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
                                                                    child: Text(
                                                                      'Tugas Keterampilan 1',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Gilroy-light',
                                                                        fontSize:
                                                                            16.w,
                                                                        color: Color.fromRGBO(
                                                                            76,
                                                                            81,
                                                                            97,
                                                                            1),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child: Text(
                                                                      '88',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Gilroy-ExtraBold',
                                                                        fontSize:
                                                                            16.w,
                                                                        color: Color.fromRGBO(
                                                                            76,
                                                                            81,
                                                                            97,
                                                                            1),
                                                                      ),
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
                                                                    child: Text(
                                                                      'Tugas Keterampilan 2',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Gilroy-light',
                                                                        fontSize:
                                                                            16.w,
                                                                        color: Color.fromRGBO(
                                                                            76,
                                                                            81,
                                                                            97,
                                                                            1),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child: Text(
                                                                      '88',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Gilroy-ExtraBold',
                                                                        fontSize:
                                                                            16.w,
                                                                        color: Color.fromRGBO(
                                                                            76,
                                                                            81,
                                                                            97,
                                                                            1),
                                                                      ),
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
                                                                    child: Text(
                                                                      'Tugas Keterampilan 3',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Gilroy-light',
                                                                        fontSize:
                                                                            16.w,
                                                                        color: Color.fromRGBO(
                                                                            76,
                                                                            81,
                                                                            97,
                                                                            1),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child: Text(
                                                                      '88',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Gilroy-ExtraBold',
                                                                        fontSize:
                                                                            16.w,
                                                                        color: Color.fromRGBO(
                                                                            76,
                                                                            81,
                                                                            97,
                                                                            1),
                                                                      ),
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
                                                                    child: Text(
                                                                      'UTS',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Gilroy-light',
                                                                        fontSize:
                                                                            16.w,
                                                                        color: Color.fromRGBO(
                                                                            76,
                                                                            81,
                                                                            97,
                                                                            1),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child: Text(
                                                                      '-',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Gilroy-ExtraBold',
                                                                        fontSize:
                                                                            16.w,
                                                                        color: Color.fromRGBO(
                                                                            76,
                                                                            81,
                                                                            97,
                                                                            1),
                                                                      ),
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
                                                                    child: Text(
                                                                      'UAS',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Gilroy-light',
                                                                        fontSize:
                                                                            16.w,
                                                                        color: Color.fromRGBO(
                                                                            76,
                                                                            81,
                                                                            97,
                                                                            1),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child: Text(
                                                                      '-',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Gilroy-ExtraBold',
                                                                        fontSize:
                                                                            16.w,
                                                                        color: Color.fromRGBO(
                                                                            76,
                                                                            81,
                                                                            97,
                                                                            1),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 490.w,
                                                          height: 47.h,
                                                          padding:
                                                              EdgeInsets.only(
                                                            left: 120.w,
                                                            right: 70.w,
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              bottomLeft: Radius
                                                                  .circular(10),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            color:
                                                                Color.fromRGBO(
                                                                    243,
                                                                    243,
                                                                    243,
                                                                    1),
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                'Total (rata-rata)',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-ExtraBold',
                                                                  fontSize:
                                                                      16.w,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          76,
                                                                          81,
                                                                          97,
                                                                          1),
                                                                ),
                                                              ),
                                                              Text(
                                                                '88',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-ExtraBold',
                                                                  fontSize:
                                                                      16.w,
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
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
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
              ),
            ),
          ),
        );
      },
    );
  }
}
