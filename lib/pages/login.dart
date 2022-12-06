import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_app/pages/phoneOTP.dart';
import 'package:video_app/utils/buttons.dart';
import 'package:video_app/utils/textInputDesign.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static String verify = "";
  static String otpCode = "";
  static String userPhoneNumber = "";
  static TextEditingController countryCode = TextEditingController();
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController countryCode_ = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    countryCode_.text = "  +91";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    return Material(
      child: Container(
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
              'Phone Number Register',
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
            Container(
              height: 55,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 40,
                    child: TextField(
                      onChanged: (value) {
                        countryCode_.text = value;
                      },
                      controller: countryCode_,
                      textDirection: TextDirection.ltr,
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '|',
                    style: TextStyle(
                      fontSize: 33,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        LoginScreen.userPhoneNumber = value;
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: 'Phone number'),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            SizedBox(
              height: 48,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    LoginScreen.countryCode.text = countryCode_.text;
                    print(countryCode_.text + LoginScreen.userPhoneNumber);
                    await FirebaseAuth.instance.verifyPhoneNumber(
                      phoneNumber:
                          countryCode_.text + LoginScreen.userPhoneNumber,
                      timeout: const Duration(seconds: 5),
                      verificationCompleted:
                          (PhoneAuthCredential credential) {},
                      verificationFailed: (FirebaseAuthException e) {},
                      codeSent: (String verificationId, int? resendToken) {
                        LoginScreen.verify = verificationId;

                        Navigator.pushNamed(context, 'otp');
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {
                        print('Time out');
                      },
                    );
                  } catch (e) {
                    print('Something Went Wrong!');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade600,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Send The Code",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),

            Spacer(),
          ],
        ),
      ),
    );
  }
}
