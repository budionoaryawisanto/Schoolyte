import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:async/async.dart';

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

  List<Test> _list = [];
  List<Test> _search = [];
  var loading = false;

  Future fetchData() async {
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
    try {
      var stream = http.ByteStream(DelegatingStream(image!.openRead()));
      var length = await image!.length();
      var uri = Uri.parse(Api.createBook);
      var request = http.MultipartRequest("POST", uri);
      request.fields['statAbsen'] = '';
      request.fields['tglAbsen'] = '';
      request.fields['wktAbsen'] = '';

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
                  height: 357,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 177,
                        height: 177,
                        child: Image.asset(
                          'assets/images/dialog.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                      Text(
                        'Sukses',
                        style: TextStyle(
                          fontFamily: 'Gilroy-ExtraBold',
                          fontSize: 32,
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
                          width: 107,
                          height: 43,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color.fromRGBO(119, 115, 205, 1),
                          ),
                          child: Center(
                            child: Text(
                              'OK',
                              style: TextStyle(
                                fontFamily: 'Gilroy-Light',
                                fontSize: 20,
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
    _list.forEach((e) {
      if (e.name.toLowerCase().contains(text.toLowerCase()) ||
          e.id.toString().contains(text)) {
        _search.add(e);
      }
    });
  }

  var start = '';
  var end = '';
  var count = 1;

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: myTabs.length,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(138),
            child: AppBar(
              backgroundColor: Color.fromRGBO(255, 217, 102, 1),
              title: Align(
                alignment: Alignment(-0.7, 0.0),
                child: Text(
                  'Tambah',
                  style: TextStyle(
                    fontFamily: 'Gilroy-ExtraBold',
                    fontSize: 24,
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
                  fontSize: 20,
                ),
                unselectedLabelStyle: TextStyle(
                  fontFamily: 'Gilroy-Light',
                  fontSize: 20,
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
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.7,
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.09),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tambah Buku',
                      style: TextStyle(
                        fontFamily: 'Gilroy-ExtraBold',
                        fontSize: 20,
                        color: Color.fromRGBO(76, 81, 97, 1),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.15,
                            child: Text(
                              'Nama Buku',
                              style: TextStyle(
                                fontFamily: 'Gilroy-Light',
                                fontSize: 18,
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
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Form(
                              key: _formKey,
                              child: TextFormField(
                                controller: namaController,
                                style: TextStyle(
                                  fontFamily: 'Gilroy-Light',
                                  fontSize: 16,
                                  color: Color.fromRGBO(76, 81, 97, 1),
                                ),
                                textAlignVertical: TextAlignVertical(y: -0.7),
                                decoration: InputDecoration(
                                  labelText: 'Nama',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Gilroy-Light',
                                    fontSize: 16,
                                    color: Color.fromRGBO(76, 81, 97, 0.54),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
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
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: MediaQuery.of(context).size.height * 0.06,
                      margin: EdgeInsets.only(top: 22),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.15,
                            child: Text(
                              'Tahun Terbit',
                              style: TextStyle(
                                fontFamily: 'Gilroy-Light',
                                fontSize: 18,
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
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Form(
                              key: _formKey2,
                              child: TextFormField(
                                controller: tahunController,
                                style: TextStyle(
                                  fontFamily: 'Gilroy-Light',
                                  fontSize: 16,
                                  color: Color.fromRGBO(76, 81, 97, 1),
                                ),
                                textAlignVertical: TextAlignVertical(y: -0.7),
                                decoration: InputDecoration(
                                  labelText: 'Tahun',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Gilroy-Light',
                                    fontSize: 16,
                                    color: Color.fromRGBO(76, 81, 97, 0.54),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
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
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: MediaQuery.of(context).size.height * 0.06,
                      margin: EdgeInsets.only(top: 22),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.15,
                            child: Text(
                              'Penulis',
                              style: TextStyle(
                                fontFamily: 'Gilroy-Light',
                                fontSize: 18,
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
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Form(
                              key: _formKey3,
                              child: TextFormField(
                                controller: penulisController,
                                style: TextStyle(
                                  fontFamily: 'Gilroy-Light',
                                  fontSize: 16,
                                  color: Color.fromRGBO(76, 81, 97, 1),
                                ),
                                textAlignVertical: TextAlignVertical(y: -0.7),
                                decoration: InputDecoration(
                                  labelText: 'Nama Penulis',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Gilroy-Light',
                                    fontSize: 16,
                                    color: Color.fromRGBO(76, 81, 97, 0.54),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
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
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: MediaQuery.of(context).size.height * 0.06,
                      margin: EdgeInsets.only(top: 22),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.15,
                            child: Text(
                              'Kategori',
                              style: TextStyle(
                                fontFamily: 'Gilroy-Light',
                                fontSize: 18,
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
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Form(
                              key: _formKey4,
                              child: TextFormField(
                                controller: kategoriController,
                                style: TextStyle(
                                  fontFamily: 'Gilroy-Light',
                                  fontSize: 16,
                                  color: Color.fromRGBO(76, 81, 97, 1),
                                ),
                                textAlignVertical: TextAlignVertical(y: -0.7),
                                decoration: InputDecoration(
                                  labelText: 'Kategori Buku',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Gilroy-Light',
                                    fontSize: 16,
                                    color: Color.fromRGBO(76, 81, 97, 0.54),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
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
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: MediaQuery.of(context).size.height * 0.11,
                      margin: EdgeInsets.only(top: 22),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.15,
                            child: Text(
                              'Rincian Buku',
                              style: TextStyle(
                                fontFamily: 'Gilroy-Light',
                                fontSize: 18,
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
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Form(
                              key: _formKey5,
                              child: TextFormField(
                                controller: rincianController,
                                keyboardType: TextInputType.multiline,
                                maxLines: 400,
                                style: TextStyle(
                                  fontFamily: 'Gilroy-Light',
                                  fontSize: 16,
                                  color: Color.fromRGBO(76, 81, 97, 1),
                                ),
                                decoration: InputDecoration(
                                  labelText: 'Keterangan Buku',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Gilroy-Light',
                                    fontSize: 16,
                                    color: Color.fromRGBO(76, 81, 97, 0.54),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
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
                      width: MediaQuery.of(context).size.width * 0.42,
                      height: MediaQuery.of(context).size.height * 0.042,
                      margin: EdgeInsets.only(top: 22),
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.14,
                            child: Text(
                              'Jumlah Buku',
                              style: TextStyle(
                                fontFamily: 'Gilroy-Light',
                                fontSize: 18,
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
                            width: MediaQuery.of(context).size.width * 0.17,
                            height: MediaQuery.of(context).size.height * 0.026,
                            margin: EdgeInsets.only(left: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () => setState(() {
                                    count != 1 ? count-- : null;
                                  }),
                                  child: Container(
                                    width: 25,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(180),
                                      border: Border.all(
                                        width: 1,
                                        color: Color.fromRGBO(119, 115, 205, 1),
                                      ),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.remove,
                                        color: Color.fromRGBO(119, 115, 205, 1),
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  count.toString(),
                                  style: TextStyle(
                                    fontFamily: 'Gilroy-Light',
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => setState(() {
                                    count++;
                                  }),
                                  child: Container(
                                    width: 25,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(180),
                                      border: Border.all(
                                        width: 1,
                                        color: Color.fromRGBO(119, 115, 205, 1),
                                      ),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.add,
                                        color: Color.fromRGBO(119, 115, 205, 1),
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
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.height * 0.042,
                      margin: EdgeInsets.only(top: 22),
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.15,
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
                                              type: MaterialType.transparency,
                                              child: new Image.file(image!),
                                            ),
                                          );
                                        });
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.27,
                                    height: MediaQuery.of(context).size.height *
                                        0.04,
                                    margin: EdgeInsets.only(left: 25),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
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
                                        'Lihat Foto',
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                          fontSize: 16,
                                          color:
                                              Color.fromRGBO(76, 81, 97, 0.54),
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
                                    width: MediaQuery.of(context).size.width *
                                        0.27,
                                    height: MediaQuery.of(context).size.height *
                                        0.04,
                                    margin: EdgeInsets.only(left: 25),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
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
                                        'Pilih foto',
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                          fontSize: 16,
                                          color:
                                              Color.fromRGBO(76, 81, 97, 0.54),
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
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.7,
                padding: EdgeInsets.all(10),
                color: Color.fromRGBO(243, 243, 243, 1),
                child: GridView.builder(
                    itemCount: _list.length,
                    padding: EdgeInsets.all(10),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent:
                          MediaQuery.of(context).size.width * 0.35,
                      mainAxisExtent: MediaQuery.of(context).size.height * 0.28,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 12,
                    ),
                    itemBuilder: (context, i) {
                      final a = _list[i];
                      return Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
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
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: new Image.asset(
                                        'assets/images/samplebook.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment(-1.0, 0.0),
                                      child: Text(
                                        'Ilmu Pengetahuan Alam',
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-ExtraBold',
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment(-1.0, 0.0),
                                      child: Text(
                                        'Tahun terbit: 2013',
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment(-1.0, 0.0),
                                      child: Text(
                                        'Oleh: ' + a.name,
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                          fontSize: 10,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment(-1.0, 0.0),
                                      child: Text(
                                        'Kategori: Buku Paket',
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment(-1.0, 0.0),
                                      child: Text(
                                        'Jumlah Buku : 2',
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment(-0.9, -0.93),
                                  child: Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(180),
                                      color:
                                          Color.fromRGBO(255, 255, 255, 0.78),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment(0.9, -0.93),
                                  child: Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(180),
                                      color:
                                          Color.fromRGBO(255, 255, 255, 0.78),
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
                        ],
                      );
                    }),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Color.fromRGBO(243, 243, 243, 1),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 85,
                        color: Colors.white,
                        child: Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.88,
                            height: MediaQuery.of(context).size.height * 0.050,
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.73,
                                  child: Form(
                                    child: TextFormField(
                                      style: TextStyle(
                                        fontFamily: 'Gilroy-Light',
                                        fontSize: 16,
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
                                          size: 24,
                                        ),
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        hintText: 'Apa yang ingin kamu pinjam?',
                                        hintStyle: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.cancel,
                                      size: 24,
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
                        ),
                      ),
                      SingleChildScrollView(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.73,
                          margin: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: Stack(
                            children: [
                              loading
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : _search.length != 0 ||
                                          searchController.text.isNotEmpty
                                      ? GridView.builder(
                                          itemCount: _search.length,
                                          padding: EdgeInsets.all(10),
                                          gridDelegate:
                                              SliverGridDelegateWithMaxCrossAxisExtent(
                                            maxCrossAxisExtent:
                                                MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.35,
                                            mainAxisExtent:
                                                MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.28,
                                            crossAxisSpacing: 15,
                                            mainAxisSpacing: 12,
                                          ),
                                          itemBuilder: (context, i) {
                                            final b = _search[i];
                                            return Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 8,
                                                vertical: 4,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(7),
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
                                                            .spaceEvenly,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                        child: new Image.asset(
                                                          'assets/images/samplebook.png',
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment: Alignment(
                                                            -1.0, 0.0),
                                                        child: Text(
                                                          'Ilmu Pengetahuan Alam',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-ExtraBold',
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment: Alignment(
                                                            -1.0, 0.0),
                                                        child: Text(
                                                          'Tahun terbit: 2013',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-Light',
                                                            fontSize: 10,
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment: Alignment(
                                                            -1.0, 0.0),
                                                        child: Text(
                                                          'Oleh: ' + b.name,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-Light',
                                                            fontSize: 10,
                                                          ),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment: Alignment(
                                                            -1.0, 0.0),
                                                        child: Text(
                                                          'Kategori: Buku Paket',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-Light',
                                                            fontSize: 10,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.014,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: b.id % 2 == 0
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
                                                            b.id % 2 == 0
                                                                ? 'Tersedia : 6'
                                                                : 'Habis',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-Light',
                                                              fontSize: 10,
                                                              color: b.id % 2 ==
                                                                      0
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment(-0.9, -0.93),
                                                    child: Container(
                                                      width: 24,
                                                      height: 24,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(180),
                                                        color: Color.fromRGBO(
                                                            255,
                                                            255,
                                                            255,
                                                            0.78),
                                                      ),
                                                      child: Center(
                                                        child: Icon(
                                                          Icons.edit,
                                                          size: 17,
                                                          color: Color.fromRGBO(
                                                              76, 81, 97, 1),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment(0.9, -0.93),
                                                    child: Container(
                                                      width: 24,
                                                      height: 24,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(180),
                                                        color: Color.fromRGBO(
                                                            255,
                                                            255,
                                                            255,
                                                            0.78),
                                                      ),
                                                      child: Center(
                                                        child: Icon(
                                                          Icons.delete,
                                                          size: 17,
                                                          color: Color.fromRGBO(
                                                              76, 81, 97, 1),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          })
                                      : GridView.builder(
                                          itemCount: _list.length,
                                          padding: EdgeInsets.all(10),
                                          gridDelegate:
                                              SliverGridDelegateWithMaxCrossAxisExtent(
                                            maxCrossAxisExtent:
                                                MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.35,
                                            mainAxisExtent:
                                                MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.28,
                                            crossAxisSpacing: 15,
                                            mainAxisSpacing: 12,
                                          ),
                                          itemBuilder: (context, i) {
                                            final a = _list[i];
                                            return Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 8,
                                                vertical: 4,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(7),
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
                                                            .spaceEvenly,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                        child: new Image.asset(
                                                          'assets/images/samplebook.png',
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment: Alignment(
                                                            -1.0, 0.0),
                                                        child: Text(
                                                          'Ilmu Pengetahuan Alam',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-ExtraBold',
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment: Alignment(
                                                            -1.0, 0.0),
                                                        child: Text(
                                                          'Tahun terbit: 2013',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-Light',
                                                            fontSize: 10,
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment: Alignment(
                                                            -1.0, 0.0),
                                                        child: Text(
                                                          'Oleh: ' + a.name,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-Light',
                                                            fontSize: 10,
                                                          ),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment: Alignment(
                                                            -1.0, 0.0),
                                                        child: Text(
                                                          'Kategori: Buku Paket',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-Light',
                                                            fontSize: 10,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.014,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: a.id % 2 == 0
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
                                                            a.id % 2 == 0
                                                                ? 'Tersedia : 6'
                                                                : 'Habis',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-Light',
                                                              fontSize: 10,
                                                              color: a.id % 2 ==
                                                                      0
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment(-0.9, -0.93),
                                                    child: Container(
                                                      width: 24,
                                                      height: 24,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(180),
                                                        color: Color.fromRGBO(
                                                            255,
                                                            255,
                                                            255,
                                                            0.78),
                                                      ),
                                                      child: Center(
                                                        child: Icon(
                                                          Icons.edit,
                                                          size: 17,
                                                          color: Color.fromRGBO(
                                                              76, 81, 97, 1),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment(0.9, -0.93),
                                                    child: Container(
                                                      width: 24,
                                                      height: 24,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(180),
                                                        color: Color.fromRGBO(
                                                            255,
                                                            255,
                                                            255,
                                                            0.78),
                                                      ),
                                                      child: Center(
                                                        child: Icon(
                                                          Icons.delete,
                                                          size: 17,
                                                          color: Color.fromRGBO(
                                                              76, 81, 97, 1),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }),
                            ],
                          ),
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
  }
}
