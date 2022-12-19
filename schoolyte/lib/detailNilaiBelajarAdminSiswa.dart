import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'model.dart';
import 'package:date_time_picker/date_time_picker.dart';

class DetailNilaiBelajarAdminSiswa extends StatefulWidget {
  @override
  _DetailNilaiBelajarAdminSiswaState createState() =>
      new _DetailNilaiBelajarAdminSiswaState();
}

class _DetailNilaiBelajarAdminSiswaState
    extends State<DetailNilaiBelajarAdminSiswa> {
  List<Test> _siswa = [];
  List<Test> _search = [];

  var loading = false;

  Future<Null> fetchData() async {
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

  final TextEditingController searchController = TextEditingController();
  final TextEditingController filterController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  onSearch(String text) async {
    _search.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    _siswa.forEach((kelas) {
      if (kelas.name.toLowerCase().contains(text.toLowerCase()) ||
          kelas.id.toString().contains(text) ||
          kelas.email.toLowerCase().contains(text.toLowerCase()) ||
          kelas.username.toLowerCase().contains(text.toLowerCase())) {
        _search.add(kelas);
      }
    });
  }

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
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Color.fromRGBO(243, 243, 243, 1),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(75),
            child: AppBar(
              backgroundColor: Color.fromRGBO(255, 217, 102, 1),
              title: Align(
                alignment: Alignment(-0.7, 0.0),
                child: Text(
                  'Nilai Belajar',
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
                        color: Color.fromRGBO(255, 217, 102, 1)),
                  )
                : SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 99,
                          color: Colors.white,
                          child: Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.82,
                              height: 46,
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
                                        MediaQuery.of(context).size.width * 0.7,
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
                                          hintText: 'Cari Siswa',
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
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.77,
                          child: searchController.text.isNotEmpty
                              ? GridView.builder(
                                  itemCount: _search.length,
                                  padding: EdgeInsets.all(10),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                    mainAxisExtent: 68,
                                    mainAxisSpacing: 10,
                                  ),
                                  itemBuilder: (context, i) {
                                    final siswa = _search[i];
                                    return Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.white,
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
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                siswa.name,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontFamily:
                                                      'Gilroy-ExtraBold',
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Text(
                                                'NIS : ${siswa.phone}',
                                                style: TextStyle(
                                                  fontFamily: 'Gilroy-Light',
                                                  fontSize: 12,
                                                  color: Color.fromRGBO(
                                                      76, 81, 97, 1),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Icon(
                                            Icons.chevron_right_rounded,
                                            size: 24,
                                            color: Colors.black,
                                          ),
                                        ],
                                      ),
                                    );
                                  })
                              : GridView.builder(
                                  itemCount: _siswa.length,
                                  padding: EdgeInsets.all(10),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                    mainAxisExtent: 68,
                                    mainAxisSpacing: 10,
                                  ),
                                  itemBuilder: (context, i) {
                                    final siswa = _siswa[i];
                                    return Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.white,
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
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                siswa.name,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontFamily:
                                                      'Gilroy-ExtraBold',
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Text(
                                                'NIS : ${siswa.phone}',
                                                style: TextStyle(
                                                  fontFamily: 'Gilroy-Light',
                                                  fontSize: 12,
                                                  color: Color.fromRGBO(
                                                      76, 81, 97, 1),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Icon(
                                            Icons.chevron_right_rounded,
                                            size: 24,
                                            color: Colors.black,
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
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
