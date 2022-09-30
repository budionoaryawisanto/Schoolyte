import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => new _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                )),
            padding: EdgeInsets.all(12),
            child: Stack(
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  width: 265,
                  height: 239,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      )),
                  child: new Image.asset(
                    "assets/images/logolanding.png",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
