import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_app/main.dart';
import 'package:video_app/pages/home.dart';
import 'package:video_app/pages/login.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Future getValidationData() async {
    final SharedPreferences sharePref = await SharedPreferences.getInstance();
    HomeScreen.isLogIn = sharePref.getBool('isLogIn')!;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(
      Duration(milliseconds: 6000),
      () {
        Navigator.pushReplacementNamed(context, 'phone');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Container(
            width: displayWidth * 0.7,
            child: Lottie.asset(
              'assets/animations/video.json',
            )),
      ),
    );
  }
}
