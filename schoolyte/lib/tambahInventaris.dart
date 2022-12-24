import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolyte/perpustakaanPegawai.dart';
import 'package:schoolyte/pinjamBuku.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:async/async.dart';

class TambahInventaris extends StatefulWidget {
  @override
  _TambahInventarisState createState() => new _TambahInventarisState();
}

class _TambahInventarisState extends State<TambahInventaris> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController rincianController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  List<Book> _fasilitas = [];
  List<Book> _search = [];
  var loading = false;

  Future fetchData() async {
    setState(() {
      loading = true;
    });
    _fasilitas.clear();
    final response = await http.get(Uri.parse(Api.getBook));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        for (Map<String, dynamic> i in data) {
          _fasilitas.add(Book.formJson(i));
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

  File? image;
  Future getImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? imagePicked =
        await _picker.pickImage(source: ImageSource.gallery);

    image = File(imagePicked!.path);
    setState(() {});
  }

  Future sendBuku() async {
    setState(() {
      loading = true;
    });
    if (namaController.text.isEmpty ||
        rincianController.text.isEmpty ||
        image == null) {
      setState(() {
        loading = false;
      });
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
                      'Gagal',
                      style: TextStyle(
                        fontFamily: 'Gilroy-ExtraBold',
                        fontSize: 32.w,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 107.w,
                        height: 43.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color.fromRGBO(242, 78, 26, 1),
                        ),
                        child: Center(
                          child: Text(
                            'OK',
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
            );
          });
    } else {
      try {
        var stream = http.ByteStream(DelegatingStream(image!.openRead()));
        var length = await image!.length();
        var uri = Uri.parse(Api.createBook);
        var request = http.MultipartRequest("POST", uri);
        request.fields['nama_buku'] = namaController.text;
        request.fields['rincian_buku'] = rincianController.text;
        request.files.add(http.MultipartFile("image", stream, length,
            filename: path.basename(image!.path)));

        var response = await request.send();
        if (response.statusCode == 200) {
          setState(() {
            loading = false;
          });
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
                            'assets/images/dialog.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                        Text(
                          'Sukses',
                          style: TextStyle(
                            fontFamily: 'Gilroy-ExtraBold',
                            fontSize: 32.w,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TambahInventaris()));
                          },
                          child: Container(
                            width: 107.w,
                            height: 43.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color.fromRGBO(119, 115, 205, 1),
                            ),
                            child: Center(
                              child: Text(
                                'OK',
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
                );
              });
        } else {
          return;
        }
      } catch (e) {
        debugPrint("Error $e");
      }
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

  List<Tab> myTabs = <Tab>[
    Tab(text: 'Fasilitas'),
    Tab(text: 'Lihat Fasilitas'),
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
                      'Tambah Fasilitas',
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
                  Container(
                    width: 490.w,
                    height: 980.h * 0.8,
                    padding: EdgeInsets.symmetric(horizontal: 490.w * 0.09),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tambah Fasilitas',
                          style: TextStyle(
                            fontFamily: 'Gilroy-ExtraBold',
                            fontSize: 20.w,
                            color: Color.fromRGBO(76, 81, 97, 1),
                          ),
                        ),
                        Container(
                          width: 431.w,
                          height: 500.h,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 490.w * 0.85,
                                height: 980.h * 0.06,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 490.w * 0.15,
                                      child: Text(
                                        'Nama Fasilitas',
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                          fontSize: 18.w,
                                          color: Color.fromRGBO(76, 81, 97, 1),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      ' :      ',
                                      style: TextStyle(
                                        color: Color.fromRGBO(76, 81, 97, 1),
                                      ),
                                    ),
                                    Container(
                                      width: 490.w * 0.6,
                                      child: Form(
                                        key: _formKey,
                                        child: TextFormField(
                                          controller: namaController,
                                          style: TextStyle(
                                            fontFamily: 'Gilroy-Light',
                                            fontSize: 16.w,
                                            color:
                                                Color.fromRGBO(76, 81, 97, 1),
                                          ),
                                          textAlignVertical:
                                              TextAlignVertical(y: -0.7),
                                          decoration: InputDecoration(
                                            labelText: 'Nama',
                                            labelStyle: TextStyle(
                                              fontFamily: 'Gilroy-Light',
                                              fontSize: 16.w,
                                              color: Color.fromRGBO(
                                                  76, 81, 97, 0.54),
                                            ),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Nama Fasilitas tidak boleh kosong ! ';
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 490.w * 0.85,
                                height: 344.h,
                                margin: EdgeInsets.only(top: 22),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 490.w * 0.15,
                                      child: Text(
                                        'Rincian Fasilitas',
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                          fontSize: 18.w,
                                          color: Color.fromRGBO(76, 81, 97, 1),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: Text(
                                        ' :      ',
                                        style: TextStyle(
                                          color: Color.fromRGBO(76, 81, 97, 1),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 490.w * 0.6,
                                      child: Form(
                                        key: _formKey2,
                                        child: TextFormField(
                                          controller: rincianController,
                                          keyboardType: TextInputType.multiline,
                                          maxLines: 400,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontFamily: 'Gilroy-Light',
                                            fontSize: 16.w,
                                            color:
                                                Color.fromRGBO(76, 81, 97, 1),
                                          ),
                                          decoration: InputDecoration(
                                            labelText: 'Keterangan Fasilitas',
                                            labelStyle: TextStyle(
                                              fontFamily: 'Gilroy-Light',
                                              fontSize: 16.w,
                                              color: Color.fromRGBO(
                                                  76, 81, 97, 0.54),
                                            ),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Deskripsi tidak boleh kosong ! ';
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 490.w * 0.6,
                                height: 980.h * 0.042,
                                margin: EdgeInsets.only(top: 22),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 490.w * 0.15,
                                      child: Text(
                                        'Tambah Foto',
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                          fontSize: 18.w,
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
                                              width: 490.w * 0.27,
                                              height: 980.h * 0.04,
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
                                                    fontSize: 16.w,
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
                                              width: 490.w * 0.27,
                                              height: 980.h * 0.04,
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
                                                    fontSize: 16.w,
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
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment(1.0, 0.0),
                          child: GestureDetector(
                            onTap: () {
                              sendBuku();
                            },
                            child: Container(
                              width: 119.w,
                              height: 36.h,
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
                                    fontSize: 15.w,
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
                  loading
                      ? Center(
                          child: CircularProgressIndicator(
                              color: Color.fromRGBO(255, 199, 0, 1)),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
