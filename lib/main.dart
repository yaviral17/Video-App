import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:video_app/pages/home.dart';
import 'package:video_app/pages/login.dart';
import 'package:video_app/pages/phoneOTP.dart';
import 'package:video_app/pages/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'splash',
    routes: {
      'splash': (context) => Splash(),
      'phone': (context) => LoginScreen(),
      'otp': (context) => OtpVerifyScreen(),
      'home': (context) => HomeScreen(),
    },
  ));
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: LoginScreen(),
//     );
//   }
// }
