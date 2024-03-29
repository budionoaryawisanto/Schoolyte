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
import 'package:date_time_picker/date_time_picker.dart';

class TambahBuku extends StatefulWidget {
  @override
  _TambahBukuState createState() => new _TambahBukuState();
}

class _TambahBukuState extends State<TambahBuku> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController tahunController = TextEditingController();
  final TextEditingController penulisController = TextEditingController();
  final TextEditingController kategoriController = TextEditingController();
  final TextEditingController rincianController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();
  final _formKey4 = GlobalKey<FormState>();
  final _formKey5 = GlobalKey<FormState>();

  List<Book> _books = [];
  List<Book> _search = [];
  var loading = false;

  Future fetchData() async {
    setState(() {
      loading = true;
    });
    _books.clear();
    final response = await http.get(Uri.parse(Api.getBook));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        for (Map<String, dynamic> i in data) {
          _books.add(Book.formJson(i));
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
        tahunController.text.isEmpty ||
        penulisController.text.isEmpty ||
        rincianController.text.isEmpty ||
        kategoriController.text.isEmpty ||
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
        request.fields['tahun_terbit'] = tahunController.text;
        request.fields['nama_penulis'] = penulisController.text;
        request.fields['rincian_buku'] = rincianController.text;
        request.fields['jumlah_buku'] = jumlahBuku.toString();
        request.fields['kategori_buku'] = kategoriController.text;
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
                                    builder: (context) => TambahBuku()));
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
    Tab(text: 'Buku'),
    Tab(text: 'Sumbang'),
    Tab(text: 'Lihat Buku'),
  ];

  final TextEditingController searchController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  onSearch(String text) async {
    _search.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    _books.forEach((book) {
      if (book.nama_buku.toLowerCase().contains(text.toLowerCase()) ||
          book.nama_penulis.toLowerCase().contains(text.toLowerCase()) ||
          book.kategori_buku.toLowerCase().contains(text.toLowerCase()) ||
          book.tahun_terbit.contains(text.toLowerCase())) {
        _search.add(book);
      }
    });
  }

  var jumlahBuku = 1;
  var start = '';
  var end = '';

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
                      'Tambah',
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PerpustakaanPegawaiPage()));
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
                  loading
                      ? Center(
                          child: CircularProgressIndicator(
                              color: Color.fromRGBO(76, 81, 97, 1)),
                        )
                      : Container(
                          width: 490.w,
                          height: 980.h * 0.8,
                          padding:
                              EdgeInsets.symmetric(horizontal: 490.w * 0.09),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Tambah Buku',
                                style: TextStyle(
                                  fontFamily: 'Gilroy-ExtraBold',
                                  fontSize: 20.w,
                                  color: Color.fromRGBO(76, 81, 97, 1),
                                ),
                              ),
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
                                        'Nama Buku',
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
                                              return 'Nama buku tidak boleh kosong ! ';
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
                                height: 980.h * 0.06,
                                margin: EdgeInsets.only(top: 22),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 490.w * 0.15,
                                      child: Text(
                                        'Tahun Terbit',
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
                                        key: _formKey2,
                                        child: TextFormField(
                                          controller: tahunController,
                                          style: TextStyle(
                                            fontFamily: 'Gilroy-Light',
                                            fontSize: 16.w,
                                            color:
                                                Color.fromRGBO(76, 81, 97, 1),
                                          ),
                                          textAlignVertical:
                                              TextAlignVertical(y: -0.7),
                                          decoration: InputDecoration(
                                            labelText: 'Tahun',
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
                                              return 'Tahun terbit tidak boleh kosong ! ';
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
                                height: 980.h * 0.06,
                                margin: EdgeInsets.only(top: 22),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 490.w * 0.15,
                                      child: Text(
                                        'Penulis',
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
                                        key: _formKey3,
                                        child: TextFormField(
                                          controller: penulisController,
                                          style: TextStyle(
                                            fontFamily: 'Gilroy-Light',
                                            fontSize: 16.w,
                                            color:
                                                Color.fromRGBO(76, 81, 97, 1),
                                          ),
                                          textAlignVertical:
                                              TextAlignVertical(y: -0.7),
                                          decoration: InputDecoration(
                                            labelText: 'Nama Penulis',
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
                                              return 'Nama penulis tidak boleh kosong ! ';
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
                                height: 980.h * 0.06,
                                margin: EdgeInsets.only(top: 22),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 490.w * 0.15,
                                      child: Text(
                                        'Kategori',
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
                                        key: _formKey4,
                                        child: TextFormField(
                                          controller: kategoriController,
                                          style: TextStyle(
                                            fontFamily: 'Gilroy-Light',
                                            fontSize: 16.w,
                                            color:
                                                Color.fromRGBO(76, 81, 97, 1),
                                          ),
                                          textAlignVertical:
                                              TextAlignVertical(y: -0.7),
                                          decoration: InputDecoration(
                                            labelText: 'Kategori Buku',
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
                                              return 'Kategori buku tidak boleh kosong ! ';
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
                                height: 980.h * 0.11,
                                margin: EdgeInsets.only(top: 22),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 490.w * 0.15,
                                      child: Text(
                                        'Rincian Buku',
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
                                        key: _formKey5,
                                        child: TextFormField(
                                          controller: rincianController,
                                          keyboardType: TextInputType.multiline,
                                          maxLines: 400,
                                          style: TextStyle(
                                            fontFamily: 'Gilroy-Light',
                                            fontSize: 16.w,
                                            color:
                                                Color.fromRGBO(76, 81, 97, 1),
                                          ),
                                          decoration: InputDecoration(
                                            labelText: 'Keterangan Buku',
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
                                width: 490.w * 0.42,
                                height: 980.h * 0.042,
                                margin: EdgeInsets.only(top: 22),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 490.w * 0.14,
                                      child: Text(
                                        'Jumlah Buku',
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                          fontSize: 18.w,
                                          color: Color.fromRGBO(76, 81, 97, 1),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '   :',
                                      style: TextStyle(
                                        color: Color.fromRGBO(76, 81, 97, 1),
                                      ),
                                    ),
                                    Container(
                                      width: 490.w * 0.17,
                                      height: 980.h * 0.026,
                                      margin: EdgeInsets.only(left: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          GestureDetector(
                                            onTap: () => setState(() {
                                              jumlahBuku--;
                                            }),
                                            child: Container(
                                              width: 25.w,
                                              height: 25.h,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(180),
                                                border: Border.all(
                                                  width: 1,
                                                  color: Color.fromRGBO(
                                                      119, 115, 205, 1),
                                                ),
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  Icons.remove,
                                                  color: Color.fromRGBO(
                                                      119, 115, 205, 1),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            jumlahBuku.toString(),
                                            style: TextStyle(
                                              fontFamily: 'Gilroy-Light',
                                              fontSize: 16.w,
                                              color: Colors.black,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () => setState(() {
                                              jumlahBuku++;
                                            }),
                                            child: Container(
                                              width: 25.w,
                                              height: 25.h,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(180),
                                                border: Border.all(
                                                  width: 1,
                                                  color: Color.fromRGBO(
                                                      119, 115, 205, 1),
                                                ),
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  Icons.add,
                                                  color: Color.fromRGBO(
                                                      119, 115, 205, 1),
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
                      : Container(
                          width: 490.w,
                          height: 980.h * 0.7,
                          padding: EdgeInsets.all(10),
                          color: Color.fromRGBO(243, 243, 243, 1),
                          child: GridView.builder(
                              itemCount: _books.length,
                              padding: EdgeInsets.all(10),
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 140.w,
                                mainAxisExtent: 283.h,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 12,
                              ),
                              itemBuilder: (context, i) {
                                final book = _books[i];
                                return GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                        isScrollControlled: true,
                                        enableDrag: false,
                                        context: context,
                                        builder: (BuildContext context) {
                                          return SafeArea(
                                            child: Container(
                                              height: 980.h * 0.964,
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 30,
                                              ),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              vertical: 30),
                                                      child: Row(
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () =>
                                                                Navigator.pop(
                                                                    context),
                                                            child: Icon(
                                                              Icons
                                                                  .chevron_left,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      200,
                                                                      200,
                                                                      200,
                                                                      1),
                                                              size: 40.w,
                                                            ),
                                                          ),
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 25),
                                                            child: Text(
                                                              'Detail Buku',
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
                                                        ],
                                                      ),
                                                    ),
                                                    Center(
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return Center(
                                                                  child:
                                                                      Material(
                                                                    type: MaterialType
                                                                        .transparency,
                                                                    child: Image
                                                                        .network(
                                                                      Api.image +
                                                                          book.image,
                                                                    ),
                                                                  ),
                                                                );
                                                              });
                                                        },
                                                        child: Container(
                                                          width: 167.w,
                                                          height: 226.h,
                                                          child: Image.network(
                                                            Api.image +
                                                                book.image,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Center(
                                                      child: Container(
                                                        width: 490.w * 0.67,
                                                        height: 980.h * 0.2,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              book.nama_buku,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Gilroy-ExtraBold',
                                                                fontSize: 32.w,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                            Text(
                                                              'Tahun terbit: ' +
                                                                  book.tahun_terbit,
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Gilroy-Light',
                                                                fontSize: 13.w,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        76,
                                                                        81,
                                                                        97,
                                                                        1),
                                                              ),
                                                            ),
                                                            Text(
                                                              'Oleh: ' +
                                                                  book.nama_penulis,
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Gilroy-Light',
                                                                fontSize: 13.w,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        76,
                                                                        81,
                                                                        97,
                                                                        1),
                                                              ),
                                                            ),
                                                            Container(
                                                              width:
                                                                  490.w * 0.12,
                                                              height:
                                                                  980.h * 0.018,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            4),
                                                                color: book.jumlah_buku !=
                                                                        '0'
                                                                    ? Color
                                                                        .fromRGBO(
                                                                            119,
                                                                            115,
                                                                            205,
                                                                            1)
                                                                    : Color
                                                                        .fromRGBO(
                                                                            217,
                                                                            217,
                                                                            217,
                                                                            1),
                                                              ),
                                                              child: Center(
                                                                child: Text(
                                                                  book.jumlah_buku !=
                                                                          '0'
                                                                      ? 'Tersedia : ' +
                                                                          book.jumlah_buku
                                                                              .toString()
                                                                      : 'Habis',
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'Gilroy-Light',
                                                                    fontSize:
                                                                        10.w,
                                                                    color: book
                                                                                .jumlah_buku !=
                                                                            '0'
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .black,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Center(
                                                      child: Container(
                                                        width: 490.w * 0.8,
                                                        height: 980.h * 0.40,
                                                        child:
                                                            SingleChildScrollView(
                                                          child: Text(
                                                            book.rincian_buku,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-Light',
                                                              fontSize: 12.w,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      76,
                                                                      81,
                                                                      97,
                                                                      1),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(7),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.3),
                                          spreadRadius: 0,
                                          blurRadius: 1.5,
                                          offset: Offset(0, 0),
                                        )
                                      ],
                                    ),
                                    child: Stack(
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 119.w,
                                              height: 161.h,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Image.network(
                                                Api.image + book.image,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Container(
                                              height: 100.h,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment(-1.0, 0.0),
                                                    child: Text(
                                                      book.nama_buku,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Gilroy-ExtraBold',
                                                        fontSize: 13.w,
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment(-1.0, 0.0),
                                                    child: Text(
                                                      'Tahun terbit: ' +
                                                          book.tahun_terbit,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Gilroy-Light',
                                                        fontSize: 10.w,
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment(-1.0, 0.0),
                                                    child: Text(
                                                      'Oleh: ' +
                                                          book.nama_penulis,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Gilroy-Light',
                                                        fontSize: 10.w,
                                                      ),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment(-1.0, 0.0),
                                                    child: Text(
                                                      'Kategori: ' +
                                                          book.kategori_buku,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Gilroy-Light',
                                                        fontSize: 10.w,
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment(-1.0, 0.0),
                                                    child: Text(
                                                      'Jumlah Buku : ' +
                                                          book.jumlah_buku,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Gilroy-Light',
                                                        fontSize: 10.w,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Align(
                                          alignment: Alignment(-0.9, -0.93),
                                          child: GestureDetector(
                                            onTap: () {
                                              konfirmasi();
                                            },
                                            child: Container(
                                              width: 24.w,
                                              height: 24.h,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(180),
                                                color: Color.fromRGBO(
                                                    255, 255, 255, 0.78),
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  Icons.close,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment(0.9, -0.93),
                                          child: Container(
                                            width: 24.w,
                                            height: 24.h,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(180),
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 0.78),
                                            ),
                                            child: Center(
                                              child: Icon(
                                                Icons.done,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                  loading
                      ? Center(
                          child: CircularProgressIndicator(
                              color: Color.fromRGBO(255, 199, 0, 1)),
                        )
                      : Container(
                          width: 490.w,
                          height: 980.h,
                          color: Color.fromRGBO(243, 243, 243, 1),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  width: 490.w,
                                  height: 85,
                                  color: Colors.white,
                                  child: Center(
                                    child: Container(
                                      width: 490.w * 0.88,
                                      height: 980.h * 0.050,
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(243, 243, 243, 1),
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.3),
                                            spreadRadius: 0,
                                            blurRadius: 1.5,
                                            offset: Offset(0, 0),
                                          )
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 490.w * 0.73,
                                            child: Form(
                                              child: TextFormField(
                                                style: TextStyle(
                                                  fontFamily: 'Gilroy-Light',
                                                  fontSize: 16.w,
                                                ),
                                                textInputAction:
                                                    TextInputAction.done,
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
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  hintText:
                                                      'Apa yang ingin kamu pinjam?',
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
                                                color: searchController
                                                            .text.length !=
                                                        0
                                                    ? Colors.red
                                                    : Color.fromRGBO(
                                                        76, 81, 97, 58)),
                                            onPressed: () {
                                              searchController.clear();
                                              onSearch('');
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SingleChildScrollView(
                                  child: Container(
                                    width: 490.w,
                                    height: 980.h * 0.73,
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 10,
                                    ),
                                    child: _search.length != 0 ||
                                            searchController.text.isNotEmpty
                                        ? GridView.builder(
                                            itemCount: _search.length,
                                            padding: EdgeInsets.all(10),
                                            gridDelegate:
                                                SliverGridDelegateWithMaxCrossAxisExtent(
                                              maxCrossAxisExtent: 140.h,
                                              mainAxisExtent: 282.w,
                                              crossAxisSpacing: 15.w,
                                              mainAxisSpacing: 12.h,
                                            ),
                                            itemBuilder: (context, i) {
                                              final book = _search[i];
                                              return GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              PinjamBuku(
                                                                  book: book)));
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 8.w,
                                                    vertical: 8.h,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7),
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
                                                  child: Stack(
                                                    children: [
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            width: 119.w,
                                                            height: 161.h,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                            child:
                                                                Image.network(
                                                              Api.image +
                                                                  book.image,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                          Container(
                                                            height: 100.h,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                Align(
                                                                  alignment:
                                                                      Alignment(
                                                                          -1.0,
                                                                          0.0),
                                                                  child: Text(
                                                                    book.nama_buku,
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'Gilroy-ExtraBold',
                                                                      fontSize:
                                                                          13.w,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      Alignment(
                                                                          -1.0,
                                                                          0.0),
                                                                  child: Text(
                                                                    'Tahun terbit: ' +
                                                                        book.tahun_terbit,
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'Gilroy-Light',
                                                                      fontSize:
                                                                          10.w,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      Alignment(
                                                                          -1.0,
                                                                          0.0),
                                                                  child: Text(
                                                                    'Oleh: ' +
                                                                        book.nama_penulis,
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'Gilroy-Light',
                                                                      fontSize:
                                                                          10.w,
                                                                    ),
                                                                    maxLines: 1,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  ),
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      Alignment(
                                                                          -1.0,
                                                                          0.0),
                                                                  child: Text(
                                                                    'Kategori: ' +
                                                                        book.kategori_buku,
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'Gilroy-Light',
                                                                      fontSize:
                                                                          10.w,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height:
                                                                      980.h *
                                                                          0.014,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: book.jumlah_buku !=
                                                                            '0'
                                                                        ? Color.fromRGBO(
                                                                            115,
                                                                            119,
                                                                            205,
                                                                            1)
                                                                        : Color.fromRGBO(
                                                                            217,
                                                                            217,
                                                                            217,
                                                                            1),
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(4),
                                                                  ),
                                                                  child: Center(
                                                                    child: Text(
                                                                      book.jumlah_buku !=
                                                                              '0'
                                                                          ? 'Tersedia : ' +
                                                                              book.jumlah_buku
                                                                          : 'Habis',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Gilroy-Light',
                                                                        fontSize:
                                                                            10.w,
                                                                        color: book.jumlah_buku !=
                                                                                '0'
                                                                            ? Colors.white
                                                                            : Colors.black,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Align(
                                                        alignment: Alignment(
                                                            -0.9, -0.93),
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            print('edit click');
                                                          },
                                                          child: Container(
                                                            width: 24.w,
                                                            height: 24.h,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          180),
                                                              color: Color
                                                                  .fromRGBO(
                                                                      255,
                                                                      255,
                                                                      255,
                                                                      0.78),
                                                            ),
                                                            child: Center(
                                                              child: Icon(
                                                                Icons.edit,
                                                                size: 17.w,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        76,
                                                                        81,
                                                                        97,
                                                                        1),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment: Alignment(
                                                            0.9, -0.93),
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            konfirmasi();
                                                          },
                                                          child: Container(
                                                            width: 24.w,
                                                            height: 24.h,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          180),
                                                              color: Color
                                                                  .fromRGBO(
                                                                      255,
                                                                      255,
                                                                      255,
                                                                      0.78),
                                                            ),
                                                            child: Center(
                                                              child: Icon(
                                                                Icons.delete,
                                                                size: 17.w,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        76,
                                                                        81,
                                                                        97,
                                                                        1),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            })
                                        : GridView.builder(
                                            itemCount: _books.length,
                                            padding: EdgeInsets.all(10),
                                            gridDelegate:
                                                SliverGridDelegateWithMaxCrossAxisExtent(
                                              maxCrossAxisExtent: 140.w,
                                              mainAxisExtent: 282.h,
                                              crossAxisSpacing: 15.w,
                                              mainAxisSpacing: 12.h,
                                            ),
                                            itemBuilder: (context, i) {
                                              final book = _books[i];
                                              return GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              PinjamBuku(
                                                                  book: book)));
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 8.w,
                                                    vertical: 8.h,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7),
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
                                                  child: Stack(
                                                    children: [
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            width: 119.w,
                                                            height: 161.h,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                            child:
                                                                Image.network(
                                                              Api.image +
                                                                  book.image,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                          Container(
                                                            height: 100.h,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                Align(
                                                                  alignment:
                                                                      Alignment(
                                                                          -1.0,
                                                                          0.0),
                                                                  child: Text(
                                                                    book.nama_buku,
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'Gilroy-ExtraBold',
                                                                      fontSize:
                                                                          13.w,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      Alignment(
                                                                          -1.0,
                                                                          0.0),
                                                                  child: Text(
                                                                    'Tahun terbit: ' +
                                                                        book.tahun_terbit,
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'Gilroy-Light',
                                                                      fontSize:
                                                                          10.w,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      Alignment(
                                                                          -1.0,
                                                                          0.0),
                                                                  child: Text(
                                                                    'Oleh: ' +
                                                                        book.nama_penulis,
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'Gilroy-Light',
                                                                      fontSize:
                                                                          10.w,
                                                                    ),
                                                                    maxLines: 1,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  ),
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      Alignment(
                                                                          -1.0,
                                                                          0.0),
                                                                  child: Text(
                                                                    'Kategori: ' +
                                                                        book.kategori_buku,
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'Gilroy-Light',
                                                                      fontSize:
                                                                          10.w,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height:
                                                                      980.w *
                                                                          0.014,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: book.jumlah_buku !=
                                                                            '0'
                                                                        ? Color.fromRGBO(
                                                                            115,
                                                                            119,
                                                                            205,
                                                                            1)
                                                                        : Color.fromRGBO(
                                                                            217,
                                                                            217,
                                                                            217,
                                                                            1),
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(4),
                                                                  ),
                                                                  child: Center(
                                                                    child: Text(
                                                                      book.jumlah_buku !=
                                                                              '0'
                                                                          ? 'Tersedia : ' +
                                                                              book.jumlah_buku
                                                                          : 'Habis',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Gilroy-Light',
                                                                        fontSize:
                                                                            10.w,
                                                                        color: book.jumlah_buku !=
                                                                                '0'
                                                                            ? Colors.white
                                                                            : Colors.black,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Align(
                                                        alignment: Alignment(
                                                            -0.9, -0.93),
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            print('edit click');
                                                          },
                                                          child: Container(
                                                            width: 24.w,
                                                            height: 24.h,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          180),
                                                              color: Color
                                                                  .fromRGBO(
                                                                      255,
                                                                      255,
                                                                      255,
                                                                      0.78),
                                                            ),
                                                            child: Center(
                                                              child: Icon(
                                                                Icons.edit,
                                                                size: 17.w,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        76,
                                                                        81,
                                                                        97,
                                                                        1),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment: Alignment(
                                                            0.9, -0.93),
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            konfirmasi();
                                                          },
                                                          child: Container(
                                                            width: 24.w,
                                                            height: 24.h,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          180),
                                                              color: Color
                                                                  .fromRGBO(
                                                                      255,
                                                                      255,
                                                                      255,
                                                                      0.78),
                                                            ),
                                                            child: Center(
                                                              child: Icon(
                                                                Icons.delete,
                                                                size: 17.w,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        76,
                                                                        81,
                                                                        97,
                                                                        1),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }),
                                  ),
                                ),
                              ],
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
