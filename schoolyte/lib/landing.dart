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

  _logIn() async {
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(12),
          child: Stack(
            children: [
              Align(
                alignment: Alignment(-0.7, -0.9),
                child: new Image.asset(
                  "assets/images/logolanding.png",
                ),
              ),
              Align(
                alignment: Alignment(0.0, -0.7),
                child: Container(
                  width: 376,
                  height: 202,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment(-1.0, -1.0),
                        child: Text(
                          "WELCOME",
                          style: TextStyle(
                            fontFamily: 'Gilroy-ExtraBold',
                            fontSize: 64,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment(-1.0, 0.0),
                        child: Text(
                          "To",
                          style: TextStyle(
                            fontFamily: 'Gilroy-ExtraBold',
                            fontSize: 48,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment(-0.4, 0.0),
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
                              fontSize: 40,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment(0.4, 0.0),
                        child: Text(
                          "!",
                          style: TextStyle(
                            fontFamily: 'Gilroy-ExtraBold',
                            fontSize: 48,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment(-1.0, 1.0),
                        child: Text(
                          "Kami akan memberikan layanan sesuai yang kalian butuhkan",
                          style: TextStyle(
                            fontFamily: 'Gilroy-Light',
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0.0, 0.2),
                child: new Image.asset(
                  "assets/images/hi1.png",
                ),
              ),
              Align(
                alignment: Alignment(0.0, 0.7),
                child: TextButton(
                  onPressed: () => _logIn(),
                  child: Container(
                    width: 384,
                    height: 55,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        "Mulai",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Gilroy-Light',
                          fontSize: 20,
                          color: Colors.white,
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
