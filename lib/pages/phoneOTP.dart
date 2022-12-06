import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_app/User.dart';
import 'package:video_app/pages/home.dart';
import 'package:video_app/pages/login.dart';

class OtpVerifyScreen extends StatefulWidget {
  const OtpVerifyScreen({super.key});

  @override
  State<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  final firebaseAuth = FirebaseAuth.instance;
  String otpCode = "";

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    const fillColor = Color.fromARGB(70, 77, 157, 255);
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

    final defaultPinTheme = PinTheme(
      width: 60,
      height: 60,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: borderColor),
      ),
    );

    double displayWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 25),
        alignment: Alignment.center,
        width: displayWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Lottie.asset('assets/animations/phone_number.json',
                width: displayWidth * 0.6),
            Spacer(),
            const Text(
              'Phone Verification',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text(
              'We Need to verify your phone number to get started ',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            // Spacer(),
            SizedBox(
              height: 16,
            ),

            Pinput(
              length: 6,
              showCursor: false,
              onChanged: (value) async {
                LoginScreen.otpCode = value;
              },
            ),
            Spacer(),
            SizedBox(
              height: 48,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    print(LoginScreen.otpCode);
                    PhoneAuthCredential credential_ =
                        PhoneAuthProvider.credential(
                            verificationId: LoginScreen.verify,
                            smsCode: LoginScreen.otpCode);
                    await firebaseAuth.signInWithCredential(credential_);
                    final SharedPreferences sP =
                        await SharedPreferences.getInstance();
                    HomeScreen.Phone = LoginScreen.countryCode.text.trim() +
                        LoginScreen.userPhoneNumber;

                    sP.setString(
                        "PhoneNumber",
                        LoginScreen.countryCode.text.trim() +
                            LoginScreen.userPhoneNumber);

                    sP.setBool("isLogIn", true);

                    Navigator.pushNamedAndRemoveUntil(
                        context, 'home', (route) => false);
                  } catch (e) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Incorrect OTP')));
                    print('wrong otp');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade600,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Verify Phone Number",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Edit Phone Number ?',
                  ),
                ),
                Spacer(),
                TextButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.verifyPhoneNumber(
                      phoneNumber: LoginScreen.countryCode.text +
                          LoginScreen.userPhoneNumber,
                      verificationCompleted:
                          (PhoneAuthCredential credential) {},
                      verificationFailed: (FirebaseAuthException e) {},
                      codeSent: (String verificationId, int? resendToken) {
                        LoginScreen.verify = verificationId;
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {},
                    );
                  },
                  child: Text(
                    'Resend OTP',
                  ),
                ),
              ],
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
