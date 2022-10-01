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
        child: Container(
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.symmetric(vertical: 50),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: 265,
                  height: 239,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: new Image.asset(
                          "assets/images/logolanding.png",
                        ),
                      ),
                      Align(
                        alignment: Alignment(-1.0, -0.1),
                        child: Text(
                          "WELCOME",
                          style: TextStyle(
                            fontFamily: 'Gilroy-ExtraBold',
                            fontSize: 46,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment(-1.0, 0.5),
                        child: Text(
                          "To",
                          style: TextStyle(
                            fontFamily: 'Gilroy-ExtraBold',
                            fontSize: 36,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment(-0.1, 0.5),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 199, 0, 1),
                            border: Border.all(
                              color: Color.fromRGBO(255, 199, 0, 1),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            "Schoolyte",
                            style: TextStyle(
                              fontFamily: 'Gilroy-Light',
                              fontSize: 36,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment(0.7, 0.5),
                        child: Text(
                          "!",
                          style: TextStyle(
                            fontFamily: 'Gilroy-ExtraBold',
                            fontSize: 40,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment(-1.0, 1.0),
                        child: Text(
                          "Kami akan memberikan layanan sesuai yang kalian butuhkan",
                          style: TextStyle(
                            fontFamily: 'Gilroy-Light',
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0.0, 0.0),
                child: new Image.asset(
                  "assets/images/hi1.png",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
