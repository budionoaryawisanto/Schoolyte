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

  _start() async {
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Container(
            width: 384,
            height: 771,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: new Image.asset(
                    "assets/images/logolanding.png",
                  ),
                ),
                Container(
                  width: 376,
                  height: 202,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          "WELCOME",
                          style: TextStyle(
                            fontFamily: 'Gilroy-ExtraBold',
                            fontSize: 64,
                          ),
                        ),
                      ),
                      Container(
                        width: 280,
                        height: 59,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                "To",
                                style: TextStyle(
                                  fontFamily: 'Gilroy-ExtraBold',
                                  fontSize: 48,
                                ),
                              ),
                            ),
                            Container(
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
                            Container(
                              child: Text(
                                "!",
                                style: TextStyle(
                                  fontFamily: 'Gilroy-ExtraBold',
                                  fontSize: 48,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
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
                Container(
                  child: new Image.asset(
                    "assets/images/hi1.png",
                  ),
                ),
                Container(
                  child: TextButton(
                    onPressed: () => _start(),
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
      ),
    );
  }
}
