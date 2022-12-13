import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:schoolyte/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model.dart';
import 'package:image_picker/image_picker.dart';

class MutasiPage extends StatefulWidget {
  Test profil;
  MutasiPage({super.key, required this.profil});

  @override
  _MutasiPageState createState() => new _MutasiPageState(profil);
}

class _MutasiPageState extends State<MutasiPage> {
  List<Test> _siswa = [];

  final TextEditingController ortuController = TextEditingController();
  final TextEditingController tujuanController = TextEditingController();

  var loading = false;

  Future fetchData() async {
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

  File? image;
  Future getImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? imagePicked =
        await _picker.pickImage(source: ImageSource.gallery);

    image = File(imagePicked!.path);
    setState(() {});
  }

  Future sendData() async {
    setState(() {
      loading = true;
    });
    if (ortuController.text.isEmpty ||
        tujuanController.text.isEmpty ||
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
                height: 357,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 177,
                      height: 177,
                      child: Image.asset(
                        'assets/images/alertDialog.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    Text(
                      'Gagal',
                      style: TextStyle(
                        fontFamily: 'Gilroy-ExtraBold',
                        fontSize: 32,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 107,
                        height: 43,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color.fromRGBO(242, 78, 26, 1),
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
                                builder: (context) => HomePage()));
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
      // try {
      //   var stream = http.ByteStream(DelegatingStream(image!.openRead()));
      //   var length = await image!.length();
      //   var uri = Uri.parse(Api.createBook);
      //   var request = http.MultipartRequest("POST", uri);
      //   request.fields['nama_buku'] = namaController.text;
      //   request.fields['tahun_terbit'] = tahunController.text;
      //   request.fields['nama_penulis'] = penulisController.text;
      //   request.fields['rincian_buku'] = rincianController.text;
      //   request.fields['jumlah_buku'] = jumlahBuku.toString();
      //   request.fields['kategori_buku'] = kategoriController.text;
      //   request.files.add(http.MultipartFile("image", stream, length,
      //       filename: path.basename(image!.path)));

      //   var response = await request.send();
      //   if (response.statusCode == 200) {
      //     setState(() {
      //       loading = false;
      //     });
      // showDialog(
      //     barrierDismissible: false,
      //     context: context,
      //     builder: (context) {
      //       return Dialog(
      //         shape: RoundedRectangleBorder(
      //           borderRadius: BorderRadius.circular(14),
      //         ),
      //         child: Container(
      //           height: 357,
      //           child: Column(
      //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //             crossAxisAlignment: CrossAxisAlignment.center,
      //             children: [
      //               Container(
      //                 width: 177,
      //                 height: 177,
      //                 child: Image.asset(
      //                   'assets/images/dialog.png',
      //                   fit: BoxFit.fill,
      //                 ),
      //               ),
      //               Text(
      //                 'Sukses',
      //                 style: TextStyle(
      //                   fontFamily: 'Gilroy-ExtraBold',
      //                   fontSize: 32,
      //                 ),
      //               ),
      //               GestureDetector(
      //                 onTap: () {
      //                   Navigator.push(
      //                       context,
      //                       MaterialPageRoute(
      //                           builder: (context) => TambahBuku()));
      //                 },
      //                 child: Container(
      //                   width: 107,
      //                   height: 43,
      //                   decoration: BoxDecoration(
      //                     borderRadius: BorderRadius.circular(5),
      //                     color: Color.fromRGBO(119, 115, 205, 1),
      //                   ),
      //                   child: Center(
      //                     child: Text(
      //                       'OK',
      //                       style: TextStyle(
      //                         fontFamily: 'Gilroy-Light',
      //                         fontSize: 20,
      //                         color: Colors.white,
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //       );
      //     });
      //   } else {
      //     return;
      //   }
      // } catch (e) {
      //   debugPrint("Error $e");
      // }
    }
  }

  @override
  Test profil;
  _MutasiPageState(this.profil);

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
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(75),
            child: AppBar(
              backgroundColor: Colors.white,
              title: Align(
                alignment: Alignment(-0.7, 0.0),
                child: Text(
                  'Mutasi',
                  style: TextStyle(
                    fontFamily: 'Gilroy-ExtraBold',
                    fontSize: 24,
                    color: Color.fromRGBO(76, 81, 97, 1),
                  ),
                ),
              ),
              elevation: 0.0,
              iconTheme: IconThemeData(color: Color.fromRGBO(217, 217, 217, 1)),
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
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 268,
                    height: 54,
                    margin: EdgeInsets.only(top: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Lengkapi data berikut!',
                          style: TextStyle(
                            fontFamily: 'Gilroy-ExtraBold',
                            fontSize: 16,
                            color: Color.fromRGBO(76, 81, 97, 1),
                          ),
                        ),
                        Text(
                          'Siswa yang ingin mengurus perpindahan sekolah harap mengisi data dibawah',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Gilroy-Light',
                            fontSize: 14,
                            color: Color.fromRGBO(76, 81, 97, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 840,
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Color.fromRGBO(243, 243, 243, 1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nama Lengkap    :',
                          style: TextStyle(
                            fontFamily: 'Gilroy-ExtraBold',
                            fontSize: 16,
                            color: Color.fromRGBO(76, 81, 97, 1),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.85,
                          height: 40,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              profil.name,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: 'Gilroy-Light',
                                fontSize: 14,
                                color: Color.fromRGBO(76, 81, 97, 1),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'NISN    :',
                          style: TextStyle(
                            fontFamily: 'Gilroy-ExtraBold',
                            fontSize: 16,
                            color: Color.fromRGBO(76, 81, 97, 1),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.85,
                          height: 40,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              profil.phone,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: 'Gilroy-Light',
                                fontSize: 14,
                                color: Color.fromRGBO(76, 81, 97, 1),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'Jenis Kelamin    :',
                          style: TextStyle(
                            fontFamily: 'Gilroy-ExtraBold',
                            fontSize: 16,
                            color: Color.fromRGBO(76, 81, 97, 1),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.85,
                          height: 40,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Perempuan',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: 'Gilroy-Light',
                                fontSize: 14,
                                color: Color.fromRGBO(76, 81, 97, 1),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'TTL    :',
                          style: TextStyle(
                            fontFamily: 'Gilroy-ExtraBold',
                            fontSize: 16,
                            color: Color.fromRGBO(76, 81, 97, 1),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.85,
                          height: 40,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '${profil.address.city}  24-01-2025',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: 'Gilroy-Light',
                                fontSize: 14,
                                color: Color.fromRGBO(76, 81, 97, 1),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'Nama OrangTua/Wali    :',
                          style: TextStyle(
                            fontFamily: 'Gilroy-ExtraBold',
                            fontSize: 16,
                            color: Color.fromRGBO(76, 81, 97, 1),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.85,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                          child: Form(
                            child: TextFormField(
                              controller: ortuController,
                              style: TextStyle(
                                fontFamily: 'Gilroy-Light',
                                fontSize: 14,
                                color: Color.fromRGBO(76, 81, 97, 1),
                              ),
                              decoration: InputDecoration(
                                labelText: 'Bapak/Ibu/Saudara/Wali',
                                labelStyle: TextStyle(
                                  fontFamily: 'Gilroy-Light',
                                  fontSize: 14,
                                  color: Color.fromRGBO(76, 81, 97, 0.54),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'Alamat Lengkap    :',
                          style: TextStyle(
                            fontFamily: 'Gilroy-ExtraBold',
                            fontSize: 16,
                            color: Color.fromRGBO(76, 81, 97, 1),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.85,
                          height: 40,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '${profil.address.street} ${profil.address.suite}',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: 'Gilroy-Light',
                                fontSize: 14,
                                color: Color.fromRGBO(76, 81, 97, 1),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'Sekolah Tujuan    :',
                          style: TextStyle(
                            fontFamily: 'Gilroy-ExtraBold',
                            fontSize: 16,
                            color: Color.fromRGBO(76, 81, 97, 1),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.85,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                          child: Form(
                            child: TextFormField(
                              controller: tujuanController,
                              style: TextStyle(
                                fontFamily: 'Gilroy-Light',
                                fontSize: 14,
                                color: Color.fromRGBO(76, 81, 97, 1),
                              ),
                              decoration: InputDecoration(
                                labelText: 'Sekolah Tujuan',
                                labelStyle: TextStyle(
                                  fontFamily: 'Gilroy-Light',
                                  fontSize: 14,
                                  color: Color.fromRGBO(76, 81, 97, 0.54),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'Kelas    :',
                          style: TextStyle(
                            fontFamily: 'Gilroy-ExtraBold',
                            fontSize: 16,
                            color: Color.fromRGBO(76, 81, 97, 1),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.85,
                          height: 40,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '11 IPA 1',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: 'Gilroy-Light',
                                fontSize: 14,
                                color: Color.fromRGBO(76, 81, 97, 1),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'Email    :',
                          style: TextStyle(
                            fontFamily: 'Gilroy-ExtraBold',
                            fontSize: 16,
                            color: Color.fromRGBO(76, 81, 97, 1),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.85,
                          height: 40,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              profil.email,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: 'Gilroy-Light',
                                fontSize: 14,
                                color: Color.fromRGBO(76, 81, 97, 1),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'Surat Keterangan Anda    :',
                          style: TextStyle(
                            fontFamily: 'Gilroy-ExtraBold',
                            fontSize: 16,
                            color: Color.fromRGBO(76, 81, 97, 1),
                          ),
                        ),
                        Container(
                          width: 170,
                          height: 42,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              image != null
                                  ? GestureDetector(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return Center(
                                                child: Material(
                                                  type:
                                                      MaterialType.transparency,
                                                  child: new Image.file(image!),
                                                ),
                                              );
                                            });
                                      },
                                      child: Container(
                                        width: 135,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                        width: 135,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                    alignment: Alignment(0.85, 0.0),
                    child: GestureDetector(
                      onTap: () {
                        sendData();
                      },
                      child: Container(
                        width: 106,
                        height: 30,
                        margin: EdgeInsets.only(
                          top: 30,
                          bottom: 20,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
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
        ),
      ),
    );
  }
}
