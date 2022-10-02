import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          // padding: EdgeInsets.all(12),
          // margin: EdgeInsets.symmetric(vertical: 50),
          child: Stack(
            children: [
              Align(
                alignment: Alignment(0.0, 0.0),
                child: Container(
                  width: 384,
                  height: 771,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: new Image.asset(
                          "assets/images/logolanding.png",
                        ),
                      ),
                      Align(
                        alignment: Alignment(-1.0, -0.6),
                        child: Text(
                          'Masukkan akun anda',
                          style: TextStyle(
                            fontFamily: 'Gilroy-ExtraBold',
                            fontSize: 32,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment(-1.0, -0.5),
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 6),
                          child: Text(
                            'Kamu dapat menggunakan akun yang diberikan pihak sekolah!',
                            style: TextStyle(
                              fontFamily: 'Gilroy-Light',
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment(0.0, -0.1),
                        child: Container(
                          width: 384,
                          height: 140,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'ID/NIS/NIP',
                                  style: TextStyle(
                                    fontFamily: 'Gilroy-Light',
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment(0.0, -0.3),
                                child: Container(
                                  margin: EdgeInsetsDirectional.only(top: 3),
                                  child: Form(
                                    key: _formKey,
                                    child: TextFormField(
                                      decoration: new InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                new BorderRadius.circular(10)),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'ID/NIS/NIP tidak boleh kosong';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment(0.0, 0.2),
                        child: Container(
                          width: 384,
                          height: 140,
                          margin: EdgeInsetsDirectional.only(top: 30),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Password',
                                  style: TextStyle(
                                    fontFamily: 'Gilroy-Light',
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment(0.0, -0.3),
                                child: Container(
                                  margin: EdgeInsetsDirectional.only(top: 3),
                                  child: Form(
                                    key: _formKey2,
                                    child: TextFormField(
                                      obscureText: true,
                                      decoration: new InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                new BorderRadius.circular(10)),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Password tidak boleh kosong';
                                        }
                                        return null;
                                      },
                                    ),
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
              Align(
                alignment: Alignment(0.0, 0.4),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/home', (Route<dynamic> route) => false);
                    if (_formKey.currentState!.validate()) {}
                    if (_formKey2.currentState!.validate()) {}
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
