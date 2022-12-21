import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'model.dart';
import 'package:date_time_picker/date_time_picker.dart';

class DetailAbsensiAdminSiswa extends StatefulWidget {
  @override
  _DetailAbsensiAdminSiswaState createState() =>
      new _DetailAbsensiAdminSiswaState();
}

class _DetailAbsensiAdminSiswaState extends State<DetailAbsensiAdminSiswa> {
  List<Test> _siswa = [];
  List<Test> _search = [];

  var loading = false;

  Future<Null> fetchData() async {
    setState(() {
      loading = true;
    });
    _siswa.clear();
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        for (Map<String, dynamic> i in data) {
          _siswa.add(Test.formJson(i));
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

  final TextEditingController searchController = TextEditingController();
  final TextEditingController filterController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
                      fontSize: 32.w.w,
                    ),
                  ),
                  Container(
                    width: 253.w.w,
                    height: 43.h.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 107.w.w,
                            height: 43.h.h,
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

  onSearch(String text) async {
    _search.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    _siswa.forEach((kelas) {
      if (kelas.name.toLowerCase().contains(text.toLowerCase()) ||
          kelas.id.toString().contains(text) ||
          kelas.email.toLowerCase().contains(text.toLowerCase()) ||
          kelas.username.toLowerCase().contains(text.toLowerCase())) {
        _search.add(kelas);
      }
    });
  }

  onEdit(Test siswa) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
            child: Container(
              height: 470.h,
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 490.w * 0.85,
                    height: 56.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color.fromRGBO(246, 246, 246, 1),
                    ),
                    child: Center(
                      child: Text(
                        'Edit Data',
                        style: TextStyle(
                          fontFamily: 'Gilroy-ExtraBold',
                          fontSize: 16.w,
                          color: Color.fromRGBO(242, 78, 26, 0.80),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 490.w * 0.85,
                    height: 390.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color.fromRGBO(246, 246, 246, 1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 490.w * 0.7,
                          height: 140.h,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Nama   :   ',
                                    style: TextStyle(
                                      fontFamily: 'Gilroy-ExtraBold',
                                      fontSize: 16.w,
                                    ),
                                  ),
                                  Text(
                                    siswa.name,
                                    style: TextStyle(
                                      fontFamily: 'Gilroy-Light',
                                      fontSize: 16.w,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Kelas    :   ',
                                    style: TextStyle(
                                      fontFamily: 'Gilroy-ExtraBold',
                                      fontSize: 16.w,
                                    ),
                                  ),
                                  Text(
                                    'XII IPA 1',
                                    style: TextStyle(
                                      fontFamily: 'Gilroy-Light',
                                      fontSize: 16.w,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Waktu  :   ',
                                    style: TextStyle(
                                      fontFamily: 'Gilroy-ExtraBold',
                                      fontSize: 16.w,
                                    ),
                                  ),
                                  Text(
                                    '12 December 2022 07:0${siswa.id} ${DateTime.now().timeZoneName}',
                                    style: TextStyle(
                                      fontFamily: 'Gilroy-Light',
                                      fontSize: 16.w,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Kehadiran   :    ',
                                    style: TextStyle(
                                      fontFamily: 'Gilroy-ExtraBold',
                                      fontSize: 16.w,
                                    ),
                                  ),
                                  Container(
                                    width: 200.w,
                                    height: 30.h,
                                    color: Colors.white,
                                    child: Form(
                                      key: _formKey,
                                      child: TextFormField(
                                        controller: statusController,
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                          fontSize: 16.w,
                                        ),
                                        decoration: InputDecoration(
                                          labelText: 'New Input',
                                          labelStyle: TextStyle(
                                            fontFamily: 'Gilroy-Light',
                                            fontSize: 16.w,
                                            color:
                                                Color.fromRGBO(76, 81, 97, 1),
                                          ),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Kehadiran tidak boleh kosong ! ';
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 490.w * 0.7,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  width: 106.w,
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
                                        fontSize: 14.w,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  width: 106.w,
                                  height: 30.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.black,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Kirim',
                                      style: TextStyle(
                                        fontFamily: 'Gilroy-Light',
                                        fontSize: 14.w,
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
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Color.fromRGBO(180, 176, 255, 1),
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
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: PreferredSize(
                preferredSize: Size.fromHeight(75.h),
            child: AppBar(
              backgroundColor: Color.fromRGBO(180, 176, 255, 1),
              title: Align(
                alignment: Alignment(-0.7, 0.0),
                child: Text(
                  'Siswa',
                  style: TextStyle(
                    fontFamily: 'Gilroy-ExtraBold',
                        fontSize: 24.w,
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
                              width: 490.w * 0.82,
                              height: 46.h,
                          margin: EdgeInsets.only(top: 20),
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
                                    width: 490.w * 0.7,
                                child: Form(
                                  child: TextFormField(
                                    style: TextStyle(
                                      fontFamily: 'Gilroy-Light',
                                          fontSize: 16.w,
                                    ),
                                    textInputAction: TextInputAction.done,
                                    controller: searchController,
                                    autocorrect: true,
                                    onChanged: ((value) {
                                      setState(() {
                                        onSearch(value);
                                      });
                                    }),
                                    decoration: new InputDecoration(
                                      icon: Icon(
                                        Icons.search,
                                            size: 24.w,
                                      ),
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      hintText: 'Cari Siswa',
                                      hintStyle: TextStyle(
                                        fontFamily: 'Gilroy-Light',
                                            fontSize: 16.w,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.cancel,
                                        size: 24.w,
                                    color: searchController.text.length != 0
                                        ? Colors.red
                                        : Color.fromRGBO(76, 81, 97, 58)),
                                onPressed: () {
                                  searchController.clear();
                                  onSearch('');
                                },
                              ),
                            ],
                          ),
                        ),
                        Container(
                              width: 490.w,
                              height: 70.h,
                          margin: EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    filterController.clear();
                                  });
                                },
                                child: Container(
                                      width: 120.w,
                                      height: 40.h,
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
                                            fontSize: 15.w,
                                        color: Color.fromRGBO(76, 81, 97, 1),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                    width: 490.w * 0.52,
                                child: DateTimePicker(
                                  controller: filterController,
                                  type: DateTimePickerType.date,
                                  icon: Icon(Icons.date_range_rounded),
                                  dateMask: 'EEEE, d MMMM yyyy',
                                  firstDate: DateTime(DateTime.now().year - 3,
                                      DateTime.now().month, DateTime.now().day),
                                  lastDate: DateTime.now(),
                                  style: TextStyle(
                                    fontFamily: 'Gilroy-Light',
                                        fontSize: 16.w,
                                    color: Colors.black,
                                  ),
                                  onChanged: (val) => setState(() {
                                    filterController.text = val;
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
                              width: 490.w,
                              height: 980.h * 0.72,
                          child: searchController.text.isNotEmpty
                              ? GridView.builder(
                                  itemCount: _search.length,
                                  padding: EdgeInsets.all(10),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                        mainAxisExtent: 68.h,
                                    mainAxisSpacing: 10,
                                  ),
                                  itemBuilder: (context, i) {
                                    final siswa = _search[i];
                                    return Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.3),
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
                                          Container(
                                                width: 490.w * 0.38,
                                                height: 38.h,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  siswa.name,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontFamily:
                                                        'Gilroy-ExtraBold',
                                                        fontSize: 16.w,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  '12 December 2022  07:0${siswa.id} ${DateTime.now().timeZoneName}',
                                                  style: TextStyle(
                                                    fontFamily: 'Gilroy-Light',
                                                        fontSize: 12.w,
                                                    color: Color.fromRGBO(
                                                        76, 81, 97, 1),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {},
                                            child: Container(
                                                  width: 78.w,
                                                  height: 23.h,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                color: Color.fromRGBO(
                                                    243, 243, 243, 1),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.play_arrow,
                                                    size: 15,
                                                    color: Colors.black,
                                                  ),
                                                  Text(
                                                    'Lihat Foto',
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Gilroy-Light',
                                                          fontSize: 12.w,
                                                      color: Color.fromRGBO(
                                                          76, 81, 97, 0.54),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              onEdit(siswa);
                                            },
                                            child: Container(
                                                  width: 89.7.w,
                                                  height: 26.h,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                color: Color.fromRGBO(
                                                    243, 243, 243, 1),
                                                border: Border.all(
                                                  color: Colors.black,
                                                  width: 1,
                                                    ),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Hadir',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Gilroy-Light',
                                                          fontSize: 13.w,
                                                      color: Color.fromRGBO(
                                                          76, 81, 97, 1),
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.edit,
                                                    color: Color.fromRGBO(
                                                        76, 81, 97, 1),
                                                        size: 16.w,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              konfirmasi();
                                            },
                                            child: Icon(
                                              Icons.delete,
                                                  size: 24.w,
                                              color:
                                                  Color.fromRGBO(76, 81, 97, 1),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  })
                              : GridView.builder(
                                  itemCount: _siswa.length,
                                  padding: EdgeInsets.all(10),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                        mainAxisExtent: 68.h,
                                    mainAxisSpacing: 10,
                                  ),
                                  itemBuilder: (context, i) {
                                    final siswa = _siswa[i];
                                    return Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.3),
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
                                          Container(
                                                width: 490.w * 0.38,
                                                height: 38.h,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  siswa.name,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontFamily:
                                                        'Gilroy-ExtraBold',
                                                        fontSize: 16.w,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  '12 December 2022  07:0${siswa.id} ${DateTime.now().timeZoneName}',
                                                  style: TextStyle(
                                                    fontFamily: 'Gilroy-Light',
                                                        fontSize: 12.w,
                                                    color: Color.fromRGBO(
                                                        76, 81, 97, 1),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {},
                                            child: Container(
                                                  width: 78.w,
                                                  height: 23.h,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                color: Color.fromRGBO(
                                                    243, 243, 243, 1),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.play_arrow,
                                                        size: 15.w,
                                                    color: Colors.black,
                                                  ),
                                                  Text(
                                                    'Lihat Foto',
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Gilroy-Light',
                                                          fontSize: 12.w,
                                                      color: Color.fromRGBO(
                                                          76, 81, 97, 0.54),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              onEdit(siswa);
                                            },
                                            child: Container(
                                                  width: 89.7.w,
                                                  height: 26.h,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                color: Color.fromRGBO(
                                                    243, 243, 243, 1),
                                                border: Border.all(
                                                  color: Colors.black,
                                                  width: 1,
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Hadir',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Gilroy-Light',
                                                          fontSize: 13.w,
                                                      color: Color.fromRGBO(
                                                          76, 81, 97, 1),
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.edit,
                                                    color: Color.fromRGBO(
                                                        76, 81, 97, 1),
                                                        size: 16.w,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              konfirmasi();
                                            },
                                            child: Icon(
                                              Icons.delete,
                                                  size: 24.w,
                                              color:
                                                  Color.fromRGBO(76, 81, 97, 1),
                                            ),
                                          ),
                                        ],
                                      ),
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
 
      },
    );
  }
}
