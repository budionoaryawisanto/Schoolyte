import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'model.dart';
import 'package:image_picker/image_picker.dart';

class EditBerita extends StatefulWidget {
  @override
  _EditBeritaState createState() => new _EditBeritaState();
}

class _EditBeritaState extends State<EditBerita> {
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

  sendData() {}

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
                    'Edit Postingan',
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
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 764,
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.09),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: 123,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Judul   :',
                                    style: TextStyle(
                                      fontFamily: 'Gilroy-Light',
                                      fontSize: 18,
                                      color: Color.fromRGBO(76, 81, 97, 1),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    height: 85,
                                    color: Color.fromRGBO(243, 243, 243, 0.7),
                                    child: Form(
                                      key: _formKey,
                                      child: TextFormField(
                                        controller: judulController,
                                        maxLines: 3,
                                        keyboardType: TextInputType.multiline,
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                          fontSize: 16,
                                          color: Color.fromRGBO(76, 81, 97, 1),
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
                                                  BorderRadius.circular(10)),
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
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: 404,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Deskripsi Berita   :',
                                    style: TextStyle(
                                      fontFamily: 'Gilroy-Light',
                                      fontSize: 18,
                                      color: Color.fromRGBO(76, 81, 97, 1),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    height: 366,
                                    color: Color.fromRGBO(243, 243, 243, 0.7),
                                    child: Form(
                                      key: _formKey2,
                                      child: TextFormField(
                                        controller: deskripsiController,
                                        maxLines: 100,
                                        keyboardType: TextInputType.multiline,
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                          fontSize: 16,
                                          color: Color.fromRGBO(76, 81, 97, 1),
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
                                                  BorderRadius.circular(10)),
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
                              width: MediaQuery.of(context).size.width * 0.6,
                              height:
                                  MediaQuery.of(context).size.height * 0.042,
                              margin: EdgeInsets.only(top: 22),
                              child: Row(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.15,
                                    child: Text(
                                      'Tambah Foto',
                                      style: TextStyle(
                                        fontFamily: 'Gilroy-Light',
                                        fontSize: 18,
                                        color: Color.fromRGBO(76, 81, 97, 1),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '  :',
                                    style: TextStyle(
                                      color: Color.fromRGBO(76, 81, 97, 1),
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
                                                      child: new Image.file(
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
                                            margin: EdgeInsets.only(left: 25),
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
                                            child: Center(
                                              child: Text(
                                                'Lihat Foto',
                                                style: TextStyle(
                                                  fontFamily: 'Gilroy-Light',
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
                                            margin: EdgeInsets.only(left: 25),
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
                                            child: Center(
                                              child: Text(
                                                'Pilih foto',
                                                style: TextStyle(
                                                  fontFamily: 'Gilroy-Light',
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
                                    borderRadius: BorderRadius.circular(4),
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
                    ),
                  )),
      ),
    );
  }
}
