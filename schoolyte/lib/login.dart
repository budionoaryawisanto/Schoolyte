import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController useridController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  bool visible = false;

  @override
  void initState() {
    super.initState();
  }

  _cekLogin() async {
    final prefs = await SharedPreferences.getInstance();
    String userid = useridController.text;
    String password = passwordController.text;
    if (_formKey.currentState!.validate()) {}
    if (_formKey2.currentState!.validate()) {}
    if (userid == '20051214078' && password == 'aryagtg') {
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool('slogin', true);
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
    } else {}
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
        child: Center(
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
                                  'ID/NIS/NIP',
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
                                    keyboardType: TextInputType.number,
                                    controller: useridController,
                                    decoration: new InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              new BorderRadius.circular(10)),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'ID/NIS/NIP tidak boleh kosong';
                                      } else if (value != '20051214078') {
                                        return 'ID/NIS/NIP Anda salah';
                                      }
                                      return null;
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
                                child: Form(
                                  key: _formKey2,
                                  child: TextFormField(
                                    controller: passwordController,
                                    obscureText: true,
                                    decoration: new InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              new BorderRadius.circular(10)),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Password tidak boleh kosong';
                                      } else if (value != 'aryagtg') {
                                        return 'Password Anda salah';
                                      }
                                      return null;
                                    },
                                  ),
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
      ),
    );
  }
}
