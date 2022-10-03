import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
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
