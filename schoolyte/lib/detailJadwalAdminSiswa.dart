import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'model.dart';
import 'package:date_time_picker/date_time_picker.dart';

class DetailJadwalAdminSiswa extends StatefulWidget {
  @override
  _DetailJadwalAdminSiswaState createState() =>
      new _DetailJadwalAdminSiswaState();
}

class _DetailJadwalAdminSiswaState extends State<DetailJadwalAdminSiswa> {
  final TextEditingController mapelController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  var _guru = ['-'];
  var guru = '-';
  var _hari = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat'];
  var hari = 'Senin';

  var start;
  var end;
  var onEdit = false;
  var loading = false;

  List<Test> _list = [];

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
      getGuru();
    }
  }

  getGuru() {
    for (var i = 0; i < _list.length; i++) {
      final nama = _list[i].name;
      _guru.add(nama);
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

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  List<Tab> myTabs = <Tab>[
    Tab(
      child: Text(
        'Sen',
        style: TextStyle(
          color: Color.fromRGBO(76, 81, 97, 1),
        ),
      ),
    ),
    Tab(
      child: Text(
        'Sel',
        style: TextStyle(
          color: Color.fromRGBO(76, 81, 97, 1),
        ),
      ),
    ),
    Tab(
      child: Text(
        'Rab',
        style: TextStyle(
          color: Color.fromRGBO(76, 81, 97, 1),
        ),
      ),
    ),
    Tab(
      child: Text(
        'Kam',
        style: TextStyle(
          color: Color.fromRGBO(76, 81, 97, 1),
        ),
      ),
    ),
    Tab(
      child: Text(
        'Jum',
        style: TextStyle(
          color: Color.fromRGBO(76, 81, 97, 1),
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
                              color: Color.fromRGBO(76, 81, 97, 1)),
                        )
                      : SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 490.w,
                                height: 520.h,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 30.w,
                                  vertical: 10.w,
                                ),
                                color: Colors.white,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Kelas 10 IPA 1',
                                      style: TextStyle(
                                        fontFamily: 'Gilroy-ExtraBold',
                                        fontSize: 20,
                                        color: Color.fromRGBO(76, 81, 97, 1),
                                      ),
                                    ),
                                    Text(
                                      'Semester Ganjil',
                                      style: TextStyle(
                                        fontFamily: 'Gilroy-Light',
                                        fontSize: 16,
                                        color: Color.fromRGBO(76, 81, 97, 1),
                                      ),
                                    ),
                                    Container(
                                      width: 490.w * 0.867,
                                      height: 44.h,
                                      margin: EdgeInsets.only(top: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Mata Pelajaran  :  ',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy-Light',
                                              fontSize: 18.w,
                                              color:
                                                  Color.fromRGBO(76, 81, 97, 1),
                                            ),
                                          ),
                                          Container(
                                            width: 490.w * 0.502,
                                            height: 44.h,
                                            child: Form(
                                              key: _formKey,
                                              child: TextFormField(
                                                maxLines: 1,
                                                controller: mapelController,
                                                style: TextStyle(
                                                  fontFamily: 'Gilroy-Light',
                                                  fontSize: 16,
                                                  color: Color.fromRGBO(
                                                      76, 81, 97, 1),
                                                ),
                                                decoration: InputDecoration(
                                                  labelText: 'Mata Pelajaran',
                                                  labelStyle: TextStyle(
                                                    fontFamily: 'Gilroy-Light',
                                                    fontSize: 16,
                                                    color: Color.fromRGBO(
                                                        76, 81, 97, 0.54),
                                                  ),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 490.w * 0.867,
                                      height: 44.h,
                                      margin: EdgeInsets.only(top: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Nama Guru        :  ',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy-Light',
                                              fontSize: 18.w,
                                              color:
                                                  Color.fromRGBO(76, 81, 97, 1),
                                            ),
                                          ),
                                          Container(
                                            width: 490.w * 0.502,
                                            height: 44.h,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.3),
                                                  spreadRadius: 0,
                                                  blurRadius: 1.5,
                                                  offset: Offset(0, 1),
                                                )
                                              ],
                                              color: Colors.white,
                                            ),
                                            child: Center(
                                              child: DropdownButton(
                                                value: guru,
                                                menuMaxHeight: 400.h,
                                                elevation: 0,
                                                underline: SizedBox(),
                                                style: TextStyle(
                                                  fontFamily: 'Gilroy-Light',
                                                  fontSize: 16.w,
                                                  color: Color.fromRGBO(
                                                      76, 81, 97, 1),
                                                ),
                                                icon: Icon(
                                                    Icons.keyboard_arrow_down),
                                                items:
                                                    _guru.map((String items) {
                                                  return DropdownMenuItem(
                                                    value: items,
                                                    child: Text(items),
                                                  );
                                                }).toList(),
                                                onChanged: (String? newValue) {
                                                  setState(() {
                                                    guru = newValue!;
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 490.w * 0.867,
                                      height: 44.h,
                                      margin: EdgeInsets.only(top: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Hari                     :  ',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy-Light',
                                              fontSize: 18.w,
                                              color:
                                                  Color.fromRGBO(76, 81, 97, 1),
                                            ),
                                          ),
                                          Container(
                                            width: 490.w * 0.252,
                                            height: 44.h,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.3),
                                                  spreadRadius: 0,
                                                  blurRadius: 1.5,
                                                  offset: Offset(0, 1),
                                                )
                                              ],
                                              color: Colors.white,
                                            ),
                                            child: Center(
                                              child: DropdownButton(
                                                value: hari,
                                                menuMaxHeight: 400.h,
                                                elevation: 0,
                                                underline: SizedBox(),
                                                style: TextStyle(
                                                  fontFamily: 'Gilroy-Light',
                                                  fontSize: 16.w,
                                                  color: Color.fromRGBO(
                                                      76, 81, 97, 1),
                                                ),
                                                icon: Icon(
                                                    Icons.keyboard_arrow_down),
                                                items:
                                                    _hari.map((String items) {
                                                  return DropdownMenuItem(
                                                    value: items,
                                                    child: Text(items),
                                                  );
                                                }).toList(),
                                                onChanged: (String? newValue) {
                                                  setState(() {
                                                    hari = newValue!;
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 490.w * 0.867,
                                      height: 44.h,
                                      margin: EdgeInsets.only(top: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Waktu Mulai       :  ',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy-Light',
                                              fontSize: 18.w,
                                              color:
                                                  Color.fromRGBO(76, 81, 97, 1),
                                            ),
                                          ),
                                          Container(
                                            width: 490.w * 0.252,
                                            height: 44.h,
                                            child: DateTimePicker(
                                              type: DateTimePickerType.time,
                                              icon:
                                                  Icon(Icons.schedule_rounded),
                                              initialValue: start,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: 'Gilroy-Light',
                                                fontSize: 16.w,
                                                color: Colors.black,
                                              ),
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
                                      width: 490.w * 0.867,
                                      height: 44.h,
                                      margin: EdgeInsets.only(top: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Waktu Berakhir    :  ',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy-Light',
                                              fontSize: 18.w,
                                              color:
                                                  Color.fromRGBO(76, 81, 97, 1),
                                            ),
                                          ),
                                          Container(
                                            width: 490.w * 0.252,
                                            height: 44.h,
                                            child: DateTimePicker(
                                              type: DateTimePickerType.time,
                                              icon: Icon(Icons.update_rounded),
                                              initialValue: end,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: 'Gilroy-Light',
                                                fontSize: 16.w,
                                                color: Colors.black,
                                              ),
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
                                      margin: EdgeInsets.only(top: 40),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Visibility(
                                            visible: onEdit,
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  onEdit = false;
                                                  mapelController.clear();
                                                  guru = '-';
                                                  hari = 'Senin';
                                                  start = '';
                                                  end = '';
                                                });
                                              },
                                              child: Container(
                                                width: 120.w,
                                                height: 30.h,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.3),
                                                      spreadRadius: 0,
                                                      blurRadius: 1.5,
                                                      offset: Offset(0, 1),
                                                    )
                                                  ],
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.close_rounded,
                                                      size: 24,
                                                      color: Color.fromRGBO(
                                                          242, 78, 26, 1),
                                                    ),
                                                    Text(
                                                      'Cancel Edit',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Gilroy-Light',
                                                        fontSize: 14,
                                                        color: Color.fromRGBO(
                                                            76, 81, 97, 1),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {},
                                            child: Container(
                                              width: 97.w,
                                              height: 30.h,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.black,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'Selesai',
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
                                    Container(
                                      width: 490.w * 0.893,
                                      height: 33.h,
                                      margin: EdgeInsets.only(top: 40),
                                      child: TabBar(
                                        indicatorColor:
                                            Color.fromRGBO(76, 81, 97, 1),
                                        indicatorSize:
                                            TabBarIndicatorSize.label,
                                        indicatorPadding:
                                            EdgeInsets.only(top: 0),
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
                                  ],
                                ),
                              ),
                              Container(
                                width: 490.w,
                                height: 350.h,
                                child: TabBarView(
                                  children: [
                                    GridView.builder(
                                      itemCount: _list.length,
                                      padding: EdgeInsets.symmetric(
                                        vertical: 10.h,
                                        horizontal: 10.w,
                                      ),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 1,
                                        mainAxisExtent: 93.h,
                                        mainAxisSpacing: 15,
                                      ),
                                      itemBuilder: (context, i) {
                                        final jadwal = _list[i];
                                        return Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 20,
                                          ),
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.3),
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
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 273.w,
                                                height: 93.h,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            right: 30),
                                                        child: new Image.asset(
                                                          'assets/images/garis.png',
                                                        )),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          jadwal.id == 2
                                                              ? 'Bahasa Indonesia'
                                                              : 'IPA',
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
                                                            fontFamily:
                                                                'Gilroy-Light',
                                                            fontSize: 14.w,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 110.w,
                                                height: 66.75.h,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    ClipOval(
                                                      child: new Image.asset(
                                                        'assets/images/ppguru.png',
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    Text(
                                                      jadwal.name,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Gilroy-Light',
                                                        fontSize: 10.w,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 24.w,
                                                height: 62.h,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          onEdit = true;
                                                          mapelController.text =
                                                              'Bahasa Indonesia';
                                                          guru = jadwal.name;
                                                          hari = 'Rabu';
                                                          start = '08:00';
                                                          end = '09:00';
                                                        });
                                                      },
                                                      child: Icon(
                                                        Icons.edit,
                                                        size: 24,
                                                        color: Color.fromRGBO(
                                                            76, 81, 97, 1),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        konfirmasi();
                                                      },
                                                      child: Icon(
                                                        Icons.delete_rounded,
                                                        size: 24,
                                                        color: Color.fromRGBO(
                                                            76, 81, 97, 1),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                    GridView.builder(
                                      itemCount: _list.length,
                                      padding: EdgeInsets.symmetric(
                                        vertical: 10.h,
                                        horizontal: 10.w,
                                      ),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 1,
                                        mainAxisExtent: 93.h,
                                        mainAxisSpacing: 15,
                                      ),
                                      itemBuilder: (context, i) {
                                        final jadwal = _list[i];
                                        return Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 20,
                                          ),
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.3),
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
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 273.w,
                                                height: 93.h,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            right: 30),
                                                        child: new Image.asset(
                                                          'assets/images/garis.png',
                                                        )),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          jadwal.id == 2
                                                              ? 'Bahasa Indonesia'
                                                              : 'IPA',
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
                                                            fontFamily:
                                                                'Gilroy-Light',
                                                            fontSize: 14.w,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 110.w,
                                                height: 66.75.h,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    ClipOval(
                                                      child: new Image.asset(
                                                        'assets/images/ppguru.png',
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    Text(
                                                      jadwal.name,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Gilroy-Light',
                                                        fontSize: 10.w,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 24.w,
                                                height: 62.h,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          onEdit = true;
                                                          mapelController.text =
                                                              'Bahasa Indonesia';
                                                          guru = jadwal.name;
                                                          hari = 'Rabu';
                                                          start = '08:00';
                                                          end = '09:00';
                                                        });
                                                      },
                                                      child: Icon(
                                                        Icons.edit,
                                                        size: 24,
                                                        color: Color.fromRGBO(
                                                            76, 81, 97, 1),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        konfirmasi();
                                                      },
                                                      child: Icon(
                                                        Icons.delete_rounded,
                                                        size: 24,
                                                        color: Color.fromRGBO(
                                                            76, 81, 97, 1),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                    GridView.builder(
                                      itemCount: _list.length,
                                      padding: EdgeInsets.symmetric(
                                        vertical: 10.h,
                                        horizontal: 10.w,
                                      ),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 1,
                                        mainAxisExtent: 93.h,
                                        mainAxisSpacing: 15,
                                      ),
                                      itemBuilder: (context, i) {
                                        final jadwal = _list[i];
                                        return Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 20,
                                          ),
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.3),
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
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 273.w,
                                                height: 93.h,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            right: 30),
                                                        child: new Image.asset(
                                                          'assets/images/garis.png',
                                                        )),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          jadwal.id == 2
                                                              ? 'Bahasa Indonesia'
                                                              : 'IPA',
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
                                                            fontFamily:
                                                                'Gilroy-Light',
                                                            fontSize: 14.w,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 110.w,
                                                height: 66.75.h,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    ClipOval(
                                                      child: new Image.asset(
                                                        'assets/images/ppguru.png',
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    Text(
                                                      jadwal.name,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Gilroy-Light',
                                                        fontSize: 10.w,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 24.w,
                                                height: 62.h,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          onEdit = true;
                                                          mapelController.text =
                                                              'Bahasa Indonesia';
                                                          guru = jadwal.name;
                                                          hari = 'Rabu';
                                                          start = '08:00';
                                                          end = '09:00';
                                                        });
                                                      },
                                                      child: Icon(
                                                        Icons.edit,
                                                        size: 24,
                                                        color: Color.fromRGBO(
                                                            76, 81, 97, 1),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        konfirmasi();
                                                      },
                                                      child: Icon(
                                                        Icons.delete_rounded,
                                                        size: 24,
                                                        color: Color.fromRGBO(
                                                            76, 81, 97, 1),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                    GridView.builder(
                                      itemCount: _list.length,
                                      padding: EdgeInsets.symmetric(
                                        vertical: 10.h,
                                        horizontal: 10.w,
                                      ),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 1,
                                        mainAxisExtent: 93.h,
                                        mainAxisSpacing: 15,
                                      ),
                                      itemBuilder: (context, i) {
                                        final jadwal = _list[i];
                                        return Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 20,
                                          ),
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.3),
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
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 273.w,
                                                height: 93.h,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            right: 30),
                                                        child: new Image.asset(
                                                          'assets/images/garis.png',
                                                        )),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          jadwal.id == 2
                                                              ? 'Bahasa Indonesia'
                                                              : 'IPA',
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
                                                            fontFamily:
                                                                'Gilroy-Light',
                                                            fontSize: 14.w,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 110.w,
                                                height: 66.75.h,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    ClipOval(
                                                      child: new Image.asset(
                                                        'assets/images/ppguru.png',
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    Text(
                                                      jadwal.name,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Gilroy-Light',
                                                        fontSize: 10.w,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 24.w,
                                                height: 62.h,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          onEdit = true;
                                                          mapelController.text =
                                                              'Bahasa Indonesia';
                                                          guru = jadwal.name;
                                                          hari = 'Rabu';
                                                          start = '08:00';
                                                          end = '09:00';
                                                        });
                                                      },
                                                      child: Icon(
                                                        Icons.edit,
                                                        size: 24,
                                                        color: Color.fromRGBO(
                                                            76, 81, 97, 1),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        konfirmasi();
                                                      },
                                                      child: Icon(
                                                        Icons.delete_rounded,
                                                        size: 24,
                                                        color: Color.fromRGBO(
                                                            76, 81, 97, 1),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                    GridView.builder(
                                      itemCount: _list.length,
                                      padding: EdgeInsets.symmetric(
                                        vertical: 10.h,
                                        horizontal: 10.w,
                                      ),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 1,
                                        mainAxisExtent: 93.h,
                                        mainAxisSpacing: 15,
                                      ),
                                      itemBuilder: (context, i) {
                                        final jadwal = _list[i];
                                        return Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 20,
                                          ),
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.3),
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
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 273.w,
                                                height: 93.h,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            right: 30),
                                                        child: new Image.asset(
                                                          'assets/images/garis.png',
                                                        )),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          jadwal.id == 2
                                                              ? 'Bahasa Indonesia'
                                                              : 'IPA',
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
                                                            fontFamily:
                                                                'Gilroy-Light',
                                                            fontSize: 14.w,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 110.w,
                                                height: 66.75.h,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    ClipOval(
                                                      child: new Image.asset(
                                                        'assets/images/ppguru.png',
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    Text(
                                                      jadwal.name,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Gilroy-Light',
                                                        fontSize: 10.w,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 24.w,
                                                height: 62.h,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          onEdit = true;
                                                          mapelController.text =
                                                              'Bahasa Indonesia';
                                                          guru = jadwal.name;
                                                          hari = 'Rabu';
                                                          start = '08:00';
                                                          end = '09:00';
                                                        });
                                                      },
                                                      child: Icon(
                                                        Icons.edit,
                                                        size: 24,
                                                        color: Color.fromRGBO(
                                                            76, 81, 97, 1),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        konfirmasi();
                                                      },
                                                      child: Icon(
                                                        Icons.delete_rounded,
                                                        size: 24,
                                                        color: Color.fromRGBO(
                                                            76, 81, 97, 1),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
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
