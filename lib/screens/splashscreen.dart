import 'dart:async';
import 'package:bloodline/screens/homescreen.dart';
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/fonts.dart';
import '../widgets/my_text.dart';


class SplashScreen extends StatefulWidget {
  // Stateful widgets are useful when the part of the
  // user interface you are describing can change dynamically
  const SplashScreen({Key? key}) : super(key: key);

  @override
  // used to annotate the implementation of an abstract method.
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = const Duration(seconds: 10);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => HomeScreen()));
  }
  @override
  void initState() {
    super.initState();
    startTime();
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/splashScrn.jpg'),
              fit: BoxFit.fill,
              opacity: 0.2
            ),
          ),
          child: Center(
            child: Column(crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 150),
                Container(height: 250,
                    width: 250,
                    child: Image.asset('images/logo.png')),
                SizedBox(height: 200,),
                MyText('BloodLine',
                    fontSize: 40,
                    color: MainColors.primary,
                    fontWeight: FontWeight.bold,
                fontFamily: Fonts.logo,
                ),
                const SizedBox(height: 20),
                const CircularProgressIndicator(
                  backgroundColor: MainColors.primary,
                  strokeWidth: 2.0,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}