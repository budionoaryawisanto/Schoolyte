import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        systemNavigationBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    return ScreenUtilInit(
      designSize: const Size(490, 980),
      builder: (context, child) {
        return new Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
                  width: 384.w,
                  height: 771.h,
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
                        width: 376.w,
                        height: 212.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            "WELCOME",
                            style: TextStyle(
                              fontFamily: 'Gilroy-ExtraBold',
                                  fontSize: 64.w,
                            ),
                          ),
                        ),
                        Container(
                              width: 280.w,
                              height: 59.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(
                                  "To",
                                  style: TextStyle(
                                    fontFamily: 'Gilroy-ExtraBold',
                                        fontSize: 48.w,
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
                                        fontSize: 40.w,
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  "!",
                                  style: TextStyle(
                                    fontFamily: 'Gilroy-ExtraBold',
                                        fontSize: 48.w,
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
                                  fontSize: 22.w,
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
                            width: 384.w,
                            height: 55.h,
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
                                  fontSize: 20.w,
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
      ),
    );
  
      },
    );
  }
}
