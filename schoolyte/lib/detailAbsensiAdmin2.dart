import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'model.dart';

class DetailAbsensiAdmin2 extends StatefulWidget {
  @override
  _DetailAbsensiAdmin2State createState() => new _DetailAbsensiAdmin2State();
}

class _DetailAbsensiAdmin2State extends State<DetailAbsensiAdmin2> {
  List<Test> _list = [];

  var loading = false;

  Future<Null> fetchData() async {
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

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Color.fromRGBO(180, 176, 255, 1),
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Color.fromRGBO(229, 229, 229, 1),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(75),
            child: AppBar(
              backgroundColor: Color.fromRGBO(180, 176, 255, 1),
              title: Align(
                alignment: Alignment(-0.7, 0.0),
                child: Text(
                  'Siswa',
                  style: TextStyle(
                    fontFamily: 'Gilroy-ExtraBold',
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ),
              elevation: 0.0,
              iconTheme: IconThemeData(color: Colors.white),
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Align(
                  alignment: Alignment(1.0, 0.0),
                  child: Icon(
                    Icons.chevron_left_rounded,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
            ),
          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: loading
                ? Center(
                    child: CircularProgressIndicator(
                        color: Color.fromRGBO(119, 115, 255, 1)),
                  )
                : SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
