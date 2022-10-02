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
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
          systemNavigationBarDividerColor: Colors.black,
          statusBarColor: Colors.white,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
        ),
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
    );
  }
}
