import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'model.dart';
import 'package:image_picker/image_picker.dart';

class PostingBerita extends StatefulWidget {
  @override
  _PostingBeritaState createState() => new _PostingBeritaState();
}

class _PostingBeritaState extends State<PostingBerita> {
  final TextEditingController judulController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  List<Test> _berita = [];

  var loading = false;

  Future fetchData() async {
    setState(() {
      loading = true;
    });
    _berita.clear();
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        for (Map<String, dynamic> i in data) {
          _berita.add(Test.formJson(i));
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

  File? image;
  Future getImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? imagePicked =
        await _picker.pickImage(source: ImageSource.gallery);

    image = File(imagePicked!.path);
    setState(() {});
  }

  List<Tab> myTabs = <Tab>[
    Tab(text: 'Menunggu'),
    Tab(text: 'Dikonfirmasi'),
  ];

  sendData() {
    if (_formKey.currentState!.validate()) {}
    if (_formKey2.currentState!.validate()) {}
  }

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
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: DefaultTabController(
          length: myTabs.length,
          child: Scaffold(
              backgroundColor: Colors.white,
              resizeToAvoidBottomInset: false,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(75),
                child: AppBar(
                  backgroundColor: Colors.white,
                  title: Align(
                    alignment: Alignment(-0.7, 0.0),
                    child: Text(
                      'Buat Postingan',
                      style: TextStyle(
                        fontFamily: 'Gilroy-ExtraBold',
                        fontSize: 24,
                        color: Color.fromRGBO(76, 81, 97, 1),
                      ),
                    ),
                  ),
                  elevation: 0.0,
                  iconTheme:
                      IconThemeData(color: Color.fromRGBO(217, 217, 217, 1)),
                  leading: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Align(
                      alignment: Alignment(1.0, 0.0),
                      child: Icon(
                        Icons.chevron_left_rounded,
                        color: Color.fromRGBO(217, 217, 217, 1),
                        size: 40,
                      ),
                    ),
                  ),
                ),
              ),
              body: loading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.97,
                      color: Colors.white,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 764,
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.09),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    height: 123,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Judul   :',
                                          style: TextStyle(
                                            fontFamily: 'Gilroy-Light',
                                            fontSize: 18,
                                            color:
                                                Color.fromRGBO(76, 81, 97, 1),
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.9,
                                          height: 85,
                                          color: Color.fromRGBO(
                                              243, 243, 243, 0.7),
                                          child: Form(
                                            key: _formKey,
                                            child: TextFormField(
                                              controller: judulController,
                                              maxLines: 3,
                                              keyboardType:
                                                  TextInputType.multiline,
                                              style: TextStyle(
                                                fontFamily: 'Gilroy-Light',
                                                fontSize: 16,
                                                color: Color.fromRGBO(
                                                    76, 81, 97, 1),
                                              ),
                                              textAlignVertical:
                                                  TextAlignVertical.top,
                                              decoration: InputDecoration(
                                                labelText: 'Judul Berita',
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
                                                  return 'Judul Berita tidak boleh kosong ! ';
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
                                        MediaQuery.of(context).size.width * 0.9,
                                    height: 404,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Deskripsi Berita   :',
                                          style: TextStyle(
                                            fontFamily: 'Gilroy-Light',
                                            fontSize: 18,
                                            color:
                                                Color.fromRGBO(76, 81, 97, 1),
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.9,
                                          height: 366,
                                          color: Color.fromRGBO(
                                              243, 243, 243, 0.7),
                                          child: Form(
                                            key: _formKey2,
                                            child: TextFormField(
                                              controller: deskripsiController,
                                              maxLines: 100,
                                              keyboardType:
                                                  TextInputType.multiline,
                                              style: TextStyle(
                                                fontFamily: 'Gilroy-Light',
                                                fontSize: 16,
                                                color: Color.fromRGBO(
                                                    76, 81, 97, 1),
                                              ),
                                              textAlignVertical:
                                                  TextAlignVertical.top,
                                              decoration: InputDecoration(
                                                labelText: 'Deskripsi Berita',
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
                                                  return 'Deskripsi Berita tidak boleh kosong ! ';
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
                                        MediaQuery.of(context).size.width * 0.6,
                                    height: MediaQuery.of(context).size.height *
                                        0.042,
                                    margin: EdgeInsets.only(top: 22),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.15,
                                          child: Text(
                                            'Tambah Foto',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy-Light',
                                              fontSize: 18,
                                              color:
                                                  Color.fromRGBO(76, 81, 97, 1),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '  :',
                                          style: TextStyle(
                                            color:
                                                Color.fromRGBO(76, 81, 97, 1),
                                          ),
                                        ),
                                        image != null
                                            ? GestureDetector(
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return Center(
                                                          child: Material(
                                                            type: MaterialType
                                                                .transparency,
                                                            child:
                                                                new Image.file(
                                                                    image!),
                                                          ),
                                                        );
                                                      });
                                                },
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.27,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.04,
                                                  margin:
                                                      EdgeInsets.only(left: 25),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
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
                                                  child: Center(
                                                    child: Text(
                                                      'Lihat Foto',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Gilroy-Light',
                                                        fontSize: 16,
                                                        color: Color.fromRGBO(
                                                            76, 81, 97, 0.54),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : GestureDetector(
                                                onTap: () async {
                                                  await getImage();
                                                },
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.27,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.04,
                                                  margin:
                                                      EdgeInsets.only(left: 25),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
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
                                                  child: Center(
                                                    child: Text(
                                                      'Pilih foto',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Gilroy-Light',
                                                        fontSize: 16,
                                                        color: Color.fromRGBO(
                                                            76, 81, 97, 0.54),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                        Visibility(
                                          visible: image != null ? true : false,
                                          child: GestureDetector(
                                            onTap: () => setState(() {
                                              image = null;
                                            }),
                                            child: Container(
                                              margin: EdgeInsets.only(left: 10),
                                              child: Icon(
                                                Icons.delete,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment(1.0, 0.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        sendData();
                                      },
                                      child: Container(
                                        width: 119,
                                        height: 36,
                                        margin: EdgeInsets.only(top: 30),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
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
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.06,
                              margin: EdgeInsets.only(top: 25),
                              child: TabBar(
                                padding: EdgeInsets.only(bottom: 10),
                                indicatorColor: Color.fromRGBO(76, 81, 97, 1),
                                indicatorSize: TabBarIndicatorSize.label,
                                labelColor: Color.fromRGBO(76, 81, 97, 1),
                                unselectedLabelColor:
                                    Color.fromRGBO(76, 81, 97, 1),
                                labelStyle: TextStyle(
                                  fontFamily: 'Gilroy-ExtraBold',
                                  fontSize: 20,
                                  color: Color.fromRGBO(76, 81, 97, 1),
                                ),
                                unselectedLabelStyle: TextStyle(
                                  fontFamily: 'Gilroy-Light',
                                  fontSize: 20,
                                  color: Color.fromRGBO(76, 81, 97, 1),
                                ),
                                tabs: myTabs,
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.59,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: TabBarView(
                                children: [
                                  GridView.builder(
                                    itemCount: 10,
                                    gridDelegate:
                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 445,
                                      mainAxisExtent: 89,
                                      crossAxisSpacing: 15,
                                    ),
                                    itemBuilder: (context, i) {
                                      final berita = _berita[i];
                                      return GestureDetector(
                                        onTap: () {
                                          showModalBottomSheet<void>(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(15),
                                                topRight: Radius.circular(15),
                                              ),
                                            ),
                                            isScrollControlled: true,
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.87,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(15),
                                                    topRight:
                                                        Radius.circular(15),
                                                  ),
                                                  color: Colors.white,
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          width: 50,
                                                          height: 50,
                                                        ),
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.1,
                                                          height: 5,
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                Color.fromRGBO(
                                                                    0,
                                                                    0,
                                                                    0,
                                                                    0.25),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 50,
                                                          height: 50,
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.8,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.16,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(9),
                                                      ),
                                                      child: new Image.asset(
                                                        'assets/images/logoberita.png',
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.8,
                                                      margin: EdgeInsets.only(
                                                          top: 10),
                                                      child: Text(
                                                        '10 Sekolah Adiwiyata HSS Lomba cerdas cermat di Desa Rejosari',
                                                        textAlign:
                                                            TextAlign.center,
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-ExtraBold',
                                                          fontSize: 24,
                                                          color: Color.fromRGBO(
                                                              76, 81, 97, 1),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.8,
                                                      height: 31,
                                                      margin: EdgeInsets.only(
                                                          top: 15),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16),
                                                        color: Color.fromRGBO(
                                                            242, 78, 26, 1),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          '${berita.name} - 12-12-2022',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-ExtraBold',
                                                            fontSize: 16,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.8,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.5,
                                                      margin: EdgeInsets.only(
                                                          top: 15),
                                                      child:
                                                          SingleChildScrollView(
                                                        child: Text(
                                                          'Pertemuan dua nama sekolah besar akan jadi laga pembuka Honda DBL 2021 DKI Jakarta Series, Kamis (7/10) besok di Gelanggang Remaja Cempaka Putih, Jakarta Pusat. Adalah Tim putra SMAN 28 Jakarta kontra SMAN 70 Jakarta. Bentroknya dua sekolah ini mengingatkan kita semua pada final Honda DBL DKI Jakarta Series 2019-South Region.\n\nDimana, kedua sekolah ini saling berjumpa waktu itu. Hanya saja, ketika itu perwakilan tim putri mereka yang saling bertemu. Srikandi SMAN 28 mampu menaklukan putri Seventy (julukan SMAN 70), di partai puncak 51-39.\n\nTahun ini, kedua sekolah kembali saling bentrok. Namun, diwakili oleh tim putranya. Tentu ini jadi misi revans putra Seventy demi menebus kekalahan tim putri mereka, dua tahun silam. “Pasti, anak-anak semangat mengusung misi ini, kami targetkan bisa ambil game pertama,” cetus Ari Adiska pelatih tim putra Seventy. Pertemuan dua nama sekolah besar akan jadi laga pembuka Honda DBL 2021 DKI Jakarta Series, Kamis (7/10) besok di Gelanggang Remaja Cempaka Putih, Jakarta Pusat. Adalah Tim putra SMAN 28 Jakarta kontra SMAN 70 Jakarta. Bentroknya dua sekolah ini mengingatkan kita semua pada final Honda DBL DKI Jakarta Series 2019-South Region. Dimana, kedua sekolah ini saling berjumpa waktu itu. Hanya saja, ketika itu perwakilan tim putri mereka yang saling bertemu. Srikandi SMAN 28 mampu menaklukan putri Seventy (julukan SMAN 70), di partai puncak 51-39. Tahun ini, kedua sekolah kembali saling bentrok. Namun, diwakili oleh tim putranya. Tentu ini jadi misi revans putra Seventy demi menebus kekalahan tim putri mereka, dua tahun silam. “Pasti, anak-anak semangat mengusung misi ini, kami targetkan bisa ambil game pertama,” cetus Ari Adiska pelatih tim putra Seventy.',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-Light',
                                                            fontSize: 15,
                                                            color:
                                                                Color.fromRGBO(
                                                                    76,
                                                                    81,
                                                                    97,
                                                                    1),
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
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          margin: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.6,
                                                height: 64,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "10 Sekolah Adiwiyata HSS Lomba cerdas cermat di Desa Rejosari",
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Gilroy-ExtraBold',
                                                        fontSize: 16,
                                                        color: Color.fromRGBO(
                                                            76, 81, 97, 1),
                                                      ),
                                                    ),
                                                    Text(
                                                      '${berita.name} - 12-12-2022',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Gilroy-Light',
                                                        fontSize: 13,
                                                        color: Color.fromRGBO(
                                                            76, 81, 97, 1),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 67,
                                                height: 67,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7)),
                                                child: new Image.asset(
                                                  'assets/images/logoberita.png',
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  GridView.builder(
                                    itemCount: 10,
                                    gridDelegate:
                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 445,
                                      mainAxisExtent: 89,
                                      crossAxisSpacing: 15,
                                    ),
                                    itemBuilder: (context, i) {
                                      final berita = _berita[i];
                                      return GestureDetector(
                                        onTap: () {
                                          showModalBottomSheet<void>(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(15),
                                                topRight: Radius.circular(15),
                                              ),
                                            ),
                                            isScrollControlled: true,
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.87,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(15),
                                                    topRight:
                                                        Radius.circular(15),
                                                  ),
                                                  color: Colors.white,
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          width: 50,
                                                          height: 50,
                                                        ),
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.1,
                                                          height: 5,
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                Color.fromRGBO(
                                                                    0,
                                                                    0,
                                                                    0,
                                                                    0.25),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 50,
                                                          height: 50,
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.8,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.16,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(9),
                                                      ),
                                                      child: new Image.asset(
                                                        'assets/images/logoberita.png',
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.8,
                                                      margin: EdgeInsets.only(
                                                          top: 10),
                                                      child: Text(
                                                        '10 Sekolah Adiwiyata HSS Lomba cerdas cermat di Desa Rejosari',
                                                        textAlign:
                                                            TextAlign.center,
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy-ExtraBold',
                                                          fontSize: 24,
                                                          color: Color.fromRGBO(
                                                              76, 81, 97, 1),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.8,
                                                      height: 31,
                                                      margin: EdgeInsets.only(
                                                          top: 15),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16),
                                                        color: Color.fromRGBO(
                                                            242, 78, 26, 1),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          '${berita.name} - 12-12-2022',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-ExtraBold',
                                                            fontSize: 16,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.8,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.5,
                                                      margin: EdgeInsets.only(
                                                          top: 15),
                                                      child:
                                                          SingleChildScrollView(
                                                        child: Text(
                                                          'Pertemuan dua nama sekolah besar akan jadi laga pembuka Honda DBL 2021 DKI Jakarta Series, Kamis (7/10) besok di Gelanggang Remaja Cempaka Putih, Jakarta Pusat. Adalah Tim putra SMAN 28 Jakarta kontra SMAN 70 Jakarta. Bentroknya dua sekolah ini mengingatkan kita semua pada final Honda DBL DKI Jakarta Series 2019-South Region.\n\nDimana, kedua sekolah ini saling berjumpa waktu itu. Hanya saja, ketika itu perwakilan tim putri mereka yang saling bertemu. Srikandi SMAN 28 mampu menaklukan putri Seventy (julukan SMAN 70), di partai puncak 51-39.\n\nTahun ini, kedua sekolah kembali saling bentrok. Namun, diwakili oleh tim putranya. Tentu ini jadi misi revans putra Seventy demi menebus kekalahan tim putri mereka, dua tahun silam. “Pasti, anak-anak semangat mengusung misi ini, kami targetkan bisa ambil game pertama,” cetus Ari Adiska pelatih tim putra Seventy. Pertemuan dua nama sekolah besar akan jadi laga pembuka Honda DBL 2021 DKI Jakarta Series, Kamis (7/10) besok di Gelanggang Remaja Cempaka Putih, Jakarta Pusat. Adalah Tim putra SMAN 28 Jakarta kontra SMAN 70 Jakarta. Bentroknya dua sekolah ini mengingatkan kita semua pada final Honda DBL DKI Jakarta Series 2019-South Region. Dimana, kedua sekolah ini saling berjumpa waktu itu. Hanya saja, ketika itu perwakilan tim putri mereka yang saling bertemu. Srikandi SMAN 28 mampu menaklukan putri Seventy (julukan SMAN 70), di partai puncak 51-39. Tahun ini, kedua sekolah kembali saling bentrok. Namun, diwakili oleh tim putranya. Tentu ini jadi misi revans putra Seventy demi menebus kekalahan tim putri mereka, dua tahun silam. “Pasti, anak-anak semangat mengusung misi ini, kami targetkan bisa ambil game pertama,” cetus Ari Adiska pelatih tim putra Seventy.',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-Light',
                                                            fontSize: 15,
                                                            color:
                                                                Color.fromRGBO(
                                                                    76,
                                                                    81,
                                                                    97,
                                                                    1),
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
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          margin: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.6,
                                                height: 64,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "10 Sekolah Adiwiyata HSS Lomba cerdas cermat di Desa Rejosari",
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Gilroy-ExtraBold',
                                                        fontSize: 16,
                                                        color: Color.fromRGBO(
                                                            76, 81, 97, 1),
                                                      ),
                                                    ),
                                                    Text(
                                                      '${berita.name} - 12-12-2022',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Gilroy-Light',
                                                        fontSize: 13,
                                                        color: Color.fromRGBO(
                                                            76, 81, 97, 1),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 67,
                                                height: 67,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7)),
                                                child: new Image.asset(
                                                  'assets/images/logoberita.png',
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ],
                                          ),
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
                    )),
        ),
      ),
    );
  }
}