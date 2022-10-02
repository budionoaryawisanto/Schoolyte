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
    return new Scaffold(
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
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment(0.0, 0.5),
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
                        alignment: Alignment(-1.0, -0.9),
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
                      alignment: Alignment(1.0, -0.9),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/landing', (Route<dynamic> route) => false);
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
