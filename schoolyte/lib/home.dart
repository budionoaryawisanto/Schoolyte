import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:schoolyte/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  int _currentIndex = 0;
  List<int> cardList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  _logOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('slogin', false);
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 1,
            iconTheme: IconThemeData(color: Color.fromARGB(255, 66, 65, 65)),
            backgroundColor: Colors.white,
            systemOverlayStyle: const SystemUiOverlayStyle(
              systemNavigationBarDividerColor: Color.fromRGBO(98, 103, 117, 1),
              statusBarColor: Colors.white,
              statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.dark,
            ),
            actions: <Widget>[
              Container(
                margin: EdgeInsetsDirectional.only(end: 10),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/landing', (Route<dynamic> route) => false);
                  },
                  child: Image.asset(
                    'assets/images/lonceng.png',
                  ),
                ),
              ),
            ],
          ),
          drawer: Drawer(
            backgroundColor: Colors.white,
            width: 257,
            child: ListView(
              padding: EdgeInsets.zero,
              children: const <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Image(
                    image: AssetImage('assets/images/logolanding.png'),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.message),
                  title: Text('Messages'),
                ),
                ListTile(
                  leading: Icon(Icons.account_circle),
                  title: Text('Profile'),
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              width: 490,
              height: 1184,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment(0.0, -1.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/landing', (Route<dynamic> route) => false);
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        fixedSize: Size(490, 104),
                        backgroundColor: Colors.white,
                      ),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment(-1.0, 0.0),
                            child: Container(
                              width: 55,
                              height: 55,
                              margin: EdgeInsets.only(left: 7),
                              child: ClipOval(
                                child: new Image.asset(
                                  'assets/images/profil.png',
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment(-0.6, -0.4),
                            child: Text(
                              'Selamat Datang',
                              style: TextStyle(
                                fontFamily: 'Gilroy-Light',
                                fontSize: 16,
                                color: Color.fromRGBO(76, 81, 97, 1),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment(-0.5, 0.2),
                            child: Container(
                              margin: EdgeInsets.only(left: 9),
                              child: Text(
                                'Rendy Pratama Putra',
                                style: TextStyle(
                                  fontFamily: 'Gilroy-ExtraBold',
                                  fontSize: 22,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Align(
                              alignment: Alignment(-0.1, -0.5),
                              child: new Image.asset(
                                'assets/images/tangan.png',
                              )),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(0.0, -0.8),
                    child: Container(
                      width: 490,
                      height: 340,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.black,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CarouselSlider(
                            options: CarouselOptions(
                                autoPlay: true,
                                autoPlayInterval: Duration(seconds: 3),
                                autoPlayAnimationDuration:
                                    Duration(milliseconds: 800),
                                autoPlayCurve: Curves.fastOutSlowIn,
                                pauseAutoPlayOnTouch: true,
                                enlargeCenterPage: true,
                                viewportFraction: 0.8,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _currentIndex = index;
                                  });
                                }),
                            items: cardList.map((item) {
                              return ItemCard();
                            }).toList(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: map<Widget>(cardList, (index, url) {
                              return Container(
                                width: _currentIndex == index ? 30 : 10.0,
                                height: 10.0,
                                margin: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 2.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: _currentIndex == index
                                      ? Colors.blue
                                      : Colors.blue.withOpacity(0.3),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(0.0, 0.8),
                    child: Container(
                      width: 403,
                      height: 375,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.black,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Align(
                            child: Container(
                              margin: EdgeInsets.only(top: 10),
                              alignment: Alignment(-1.0, -1.0),
                              child: Text(
                                'Berita Sekolah',
                                style: TextStyle(
                                  fontFamily: 'Gilroy-ExtraBold',
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment(1.0, -1.0),
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/landing',
                                    (Route<dynamic> route) => false);
                              },
                              child: Container(
                                width: 87,
                                height: 18,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(180, 176, 255, 1),
                                  border: Border.all(
                                    width: 1,
                                    color: Color.fromRGBO(180, 176, 255, 1),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    "Lihat Semua",
                                    style: TextStyle(
                                      fontFamily: 'Gilroy-ExtraBold',
                                      fontSize: 12,
                                      color: Color.fromRGBO(119, 115, 205, 1),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment(0.0, -0.6),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/landing',
                                    (Route<dynamic> route) => false);
                              },
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(403, 89),
                                side: BorderSide(
                                  width: 2,
                                  color: Color.fromARGB(255, 240, 236, 236),
                                ),
                                backgroundColor: Colors.white,
                              ),
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment(-0.9, 0.0),
                                    child: Container(
                                      width: 270,
                                      height: 44,
                                      child: Text(
                                        "10 Sekolah Adiwiyata HSS Lomba cerdas cermat di Desa Rejosari",
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-ExtraBold',
                                          fontSize: 16,
                                          color: Color.fromRGBO(76, 81, 97, 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment(1.0, 0.0),
                                    child: Container(
                                      width: 67,
                                      height: 67,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1,
                                            color: Colors.white,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(7)),
                                      child: new Image.asset(
                                        'assets/images/hi1.png',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment(0.0, 0.1),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/landing',
                                    (Route<dynamic> route) => false);
                              },
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(403, 89),
                                side: BorderSide(
                                  width: 2,
                                  color: Color.fromARGB(255, 240, 236, 236),
                                ),
                                backgroundColor: Colors.white,
                              ),
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment(-0.9, 0.0),
                                    child: Container(
                                      width: 270,
                                      height: 44,
                                      child: Text(
                                        "10 Sekolah Adiwiyata HSS Lomba cerdas cermat di Desa Rejosari",
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-ExtraBold',
                                          fontSize: 16,
                                          color: Color.fromRGBO(76, 81, 97, 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment(1.0, 0.0),
                                    child: Container(
                                      width: 67,
                                      height: 67,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1,
                                            color: Colors.white,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(7)),
                                      child: new Image.asset(
                                        'assets/images/hi1.png',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment(0.0, 0.8),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/landing',
                                    (Route<dynamic> route) => false);
                              },
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(403, 89),
                                side: BorderSide(
                                  width: 2,
                                  color: Color.fromARGB(255, 240, 236, 236),
                                ),
                                backgroundColor: Colors.white,
                              ),
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment(-0.9, 0.0),
                                    child: Container(
                                      width: 270,
                                      height: 44,
                                      child: Text(
                                        "10 Sekolah Adiwiyata HSS Lomba cerdas cermat di Desa Rejosari",
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-ExtraBold',
                                          fontSize: 16,
                                          color: Color.fromRGBO(76, 81, 97, 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment(1.0, 0.0),
                                    child: Container(
                                      width: 67,
                                      height: 67,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1,
                                            color: Colors.white,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(7)),
                                      child: new Image.asset(
                                        'assets/images/hi1.png',
                                        fit: BoxFit.fill,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color:
            Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.4), blurRadius: 2),
        ],
      ),
    );
  }
}
