import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolyte/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'model.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  bool visible = false;

  List<Siswa> _siswa = [];
  List<Guru> _guru = [];
  List<Pegawai> _pegawai = [];
  List<Admin> _admin = [];
  var loading = false;
  var obscure = true;

  Future fetchDataSiswa() async {
    setState(() {
      loading = true;
    });
    _siswa.clear();
    final response = await http.get(Uri.parse(Api.getSiswa));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        for (Map<String, dynamic> i in data) {
          _siswa.add(Siswa.formJson(i));
          loading = false;
        }
      });
    }
  }

  Future fetchDataGuru() async {
    setState(() {
      loading = true;
    });
    _guru.clear();
    final response = await http.get(Uri.parse(Api.getGuru));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        for (Map<String, dynamic> i in data) {
          _guru.add(Guru.formJson(i));
          loading = false;
        }
      });
    }
  }

  Future fetchDataPegawai() async {
    setState(() {
      loading = true;
    });
    _pegawai.clear();
    final response = await http.get(Uri.parse(Api.getPegawai));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      for (Map<String, dynamic> i in data) {
        _pegawai.add(Pegawai.formJson(i));
      }
      setState(() {
        loading = false;
      });
    }
  }

  Future fetchDataAdmin() async {
    setState(() {
      loading = true;
    });
    _admin.clear();
    final response = await http.get(Uri.parse(Api.getAdmin));
    print(response.body);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        for (Map<String, dynamic> i in data) {
          _admin.add(Admin.formJson(i));
          loading = false;
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDataSiswa();
    fetchDataGuru();
    fetchDataPegawai();
    fetchDataAdmin();
  }

  var info = '';

  _cekLogin() async {
    final prefs = await SharedPreferences.getInstance();
    String email = emailController.text;
    String password = passwordController.text;
    if (_formKey.currentState!.validate()) {}
    if (_formKey2.currentState!.validate()) {}
    if (status == 'Siswa') {
      for (var i = 0; i <= _siswa.length + 1; i++) {
        final siswa = _siswa[i];
        if (email.toLowerCase() == siswa.email.toLowerCase() &&
            password.toLowerCase() == siswa.pass.toLowerCase()) {
          final prefs = await SharedPreferences.getInstance();
          prefs.setBool('slogin', true);
          prefs.setString('id', siswa.id.toString());
          prefs.setString('status', status);
          prefs.setString('status user', siswa.status);
          prefs.setString('nama user', siswa.nama);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        } else if (i == _siswa.length) {
          return info = 'Data yang anda masukan salah !';
        }
      }
    } else if (status == 'Guru') {
      for (var i = 0; i <= _guru.length + 1; i++) {
        final guru = _guru[i];
        if (email.toLowerCase() == guru.email.toLowerCase() &&
            password.toLowerCase() == guru.pass.toLowerCase()) {
          final prefs = await SharedPreferences.getInstance();
          prefs.setBool('slogin', true);
          prefs.setString('id', guru.id.toString());
          prefs.setString('status', status);
          prefs.setString('status user', guru.status);
          prefs.setString('nama user', guru.nama);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        } else if (i == _guru.length) {
          return info = 'Data yang anda masukan salah !';
        }
      }
    } else if (status == 'Admin') {
      for (var i = 0; i <= _admin.length + 1; i++) {
        final admin = _admin[i];
        if (email.toLowerCase() == admin.email.toLowerCase() &&
            password.toLowerCase() == admin.pass.toLowerCase()) {
          final prefs = await SharedPreferences.getInstance();
          prefs.setBool('slogin', true);
          prefs.setString('id', admin.id.toString());
          prefs.setString('status', status);
          prefs.setString('status user', admin.status);
          prefs.setString('nama user', admin.nama);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        } else if (i == _admin.length) {
          return info = 'Data yang anda masukan salah !';
        }
      }
    } else if (status == 'Pegawai') {
      for (var i = 0; i <= _pegawai.length + 1; i++) {
        final pegawai = _pegawai[i];
        if (email.toLowerCase() == pegawai.email.toLowerCase() &&
            password.toLowerCase() == pegawai.pass.toLowerCase()) {
          final prefs = await SharedPreferences.getInstance();
          prefs.setBool('slogin', true);
          prefs.setString('id', pegawai.id.toString());
          prefs.setString('status', status);
          prefs.setString('status user', pegawai.status);
          prefs.setString('nama user', pegawai.nama);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        } else if (i == _pegawai.length) {
          return info = 'Data yang anda masukan salah !';
        }
      }
    }
  }

  var _status = ['Siswa', 'Guru', 'Pegawai', 'Admin', 'Ekternal'];
  var status = 'Siswa';

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        systemNavigationBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    return ScreenUtilInit(
      designSize: const Size(490, 980),
      builder: (context, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Stack(
              children: [
                Center(
                  child: Container(
                    width: 384.w,
                    height: 627.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: new Image.asset(
                            "assets/images/logolanding.png",
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 60),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  'Masukkan akun anda',
                                  style: TextStyle(
                                    fontFamily: 'Gilroy-ExtraBold',
                                    fontSize: 32.w,
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  'Kamu dapat menggunakan akun yang diberikan pihak sekolah!',
                                  style: TextStyle(
                                    fontFamily: 'Gilroy-Light',
                                    fontSize: 22.w,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 384.w,
                          height: 340.h,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 300.w,
                                height: 50.h,
                                child: Row(
                                  children: [
                                    Text(
                                      'Status Anda  :  ',
                                      style: TextStyle(
                                        fontFamily: 'Gilroy-Light',
                                        fontSize: 20.w,
                                      ),
                                    ),
                                    Container(
                                      width: 130.w,
                                      height: 30.h,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.3),
                                            spreadRadius: 0,
                                            blurRadius: 1.5,
                                            offset: Offset(0, 1),
                                          )
                                        ],
                                        color: Colors.white,
                                      ),
                                      child: Center(
                                        child: DropdownButton(
                                          value: status,
                                          elevation: 0,
                                          underline: SizedBox(),
                                          style: TextStyle(
                                            fontFamily: 'Gilroy-Light',
                                            fontSize: 18,
                                            color:
                                                Color.fromRGBO(76, 81, 97, 1),
                                          ),
                                          icon: const Icon(
                                              Icons.keyboard_arrow_down),
                                          items: _status.map((String items) {
                                            return DropdownMenuItem(
                                              value: items,
                                              child: Text(items),
                                            );
                                          }).toList(),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              status = newValue!;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 384.w,
                                height: 136.h,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text(
                                        'Email',
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                          fontSize: 20.w,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Form(
                                        key: _formKey,
                                        child: TextFormField(
                                          controller: emailController,
                                          decoration: new InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        10)),
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Email tidak boleh kosong';
                                            } else if (info.isNotEmpty) {
                                              return info;
                                            }
                                            for (var i = 0;
                                                i < _siswa.length;
                                                i++) {
                                              if (value.toLowerCase() ==
                                                  _siswa[i]
                                                      .email
                                                      .toLowerCase()) {
                                                return null;
                                              }
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 384.w,
                                height: 136.h,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text(
                                        'Password',
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Light',
                                          fontSize: 20.w,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsetsDirectional.only(top: 3),
                                      child: Stack(
                                        children: [
                                          Form(
                                            key: _formKey2,
                                            child: TextFormField(
                                              controller: passwordController,
                                              obscureText: obscure,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                              ),
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Password tidak boleh kosong';
                                                } else if (info.isNotEmpty) {
                                                  return info;
                                                }
                                                for (var i = 0;
                                                    i < _siswa.length;
                                                    i++) {
                                                  if (value.toLowerCase() ==
                                                      _siswa[i]
                                                          .pass
                                                          .toLowerCase()) {
                                                    return null;
                                                  }
                                                }
                                              },
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment(0.88, 0.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  obscure = !obscure;
                                                });
                                              },
                                              child: Container(
                                                margin:
                                                    EdgeInsets.only(top: 17.h),
                                                child: Icon(
                                                  obscure
                                                      ? Icons.visibility
                                                      : Icons.visibility_off,
                                                  color: Color.fromRGBO(
                                                      76, 81, 97, 1),
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
                        GestureDetector(
                          onTap: () {
                            _cekLogin();
                          },
                          child: Container(
                            width: 384.w,
                            height: 47.h,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                "Masuk",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Gilroy-Light',
                                  fontSize: 20.w,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: loading,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: Color.fromRGBO(0, 0, 0, 0.20),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
