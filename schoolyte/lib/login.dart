import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  List<Test> _siswa = [];
  var loading = false;
  var obscure = true;

  Future fetchDataSiswa() async {
    setState(() {
      loading = true;
    });
    _siswa.clear();
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    print(response.body);
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
    fetchDataSiswa();
  }

  var info = '';

  _cekLogin() async {
    final prefs = await SharedPreferences.getInstance();
    String email = emailController.text;
    String password = passwordController.text;
    if (_formKey.currentState!.validate()) {}
    if (_formKey2.currentState!.validate()) {}
    for (var i = 0; i < _siswa.length + 1; i++) {
      if (email == '20051214078' && password == 'aryagtg' ||
          email.toLowerCase() == _siswa[i].email.toLowerCase() &&
              password.toLowerCase() == _siswa[i].username.toLowerCase()) {
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool('slogin', true);
        prefs.setString('id', _siswa[i].id.toString());
        // prefs.setString('status', _siswa[i].status);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } else if (i == _siswa.length - 1) {
        return info = 'Data yang Anda masukan salah !';
      }
    }
  }

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

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Container(
                width: 384,
                height: 627,
                margin: EdgeInsets.only(bottom: 100),
                child: SingleChildScrollView(
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
                        margin: EdgeInsets.only(top: 100),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                'Masukkan akun anda',
                                style: TextStyle(
                                  fontFamily: 'Gilroy-ExtraBold',
                                  fontSize: 32,
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                'Kamu dapat menggunakan akun yang diberikan pihak sekolah!',
                                style: TextStyle(
                                  fontFamily: 'Gilroy-Light',
                                  fontSize: 22,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 384,
                        height: 338,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 384,
                              height: 136,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Text(
                                      'Email',
                                      style: TextStyle(
                                        fontFamily: 'Gilroy-Light',
                                        fontSize: 20,
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
                                            return 'ID/NIS/NIP tidak boleh kosong';
                                          } else if (info.isNotEmpty) {
                                            return info;
                                          }
                                          for (var i = 0;
                                              i < _siswa.length;
                                              i++) {
                                            if (value ==
                                                _siswa[i].id.toString()) {
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
                              width: 384,
                              height: 136,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Text(
                                      'Password',
                                      style: TextStyle(
                                        fontFamily: 'Gilroy-Light',
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsetsDirectional.only(top: 3),
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
                                                        .username
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
                                              margin: EdgeInsets.only(top: 17),
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
                      TextButton(
                        onPressed: () {
                          _cekLogin();
                        },
                        child: Container(
                          width: 384,
                          height: 47,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "Masuk",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Gilroy-Light',
                                fontSize: 20,
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
  }
}
