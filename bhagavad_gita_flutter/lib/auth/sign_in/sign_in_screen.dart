import 'dart:developer';

import 'package:bhagavad_gita_flutter/auth/sign_in/sign_in_otp_screen.dart';
import 'package:bhagavad_gita_flutter/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  GlobalKey<FormState> formKey = GlobalKey();
  FocusNode mobileNumberFocusNode = FocusNode();
  final TextEditingController mobileNumberController = TextEditingController();
  String mobileNumber = "";
  int? resendTokens;

  sendFirebaseOTP() async {
    try {
      EasyLoading.show(status: 'loading...');
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: mobileNumber,
        timeout: const Duration(seconds: 120),
        verificationCompleted: (PhoneAuthCredential credential) async {},
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: (String verificationId, int? resendToken) async {
          resendTokens = resendToken;
          // Update the UI - wait for the user to enter the SMS code
          EasyLoading.dismiss();

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OTPScreen(
                        mobileNumber: mobileNumber,
                        verificationId: verificationId,
                        resendToken: resendTokens,
                      )));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          EasyLoading.dismiss();
        },
      );
    } catch (e) {
      EasyLoading.dismiss();
      log("$e");
    }
  }

  @override
  void dispose() {
    mobileNumberController.dispose();
    mobileNumberFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 4.0, 15.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 6.0, top: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Enter your \nmobile number',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            color: textColor,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        const Text(
                          'we will send you confirmation code',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(6, 30.0, 6, 35),
                          child: Material(
                            surfaceTintColor: Colors.white,
                            shadowColor: primaryColor,
                            elevation: 1,
                            borderRadius: BorderRadius.circular(8),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IntlPhoneField(
                                controller: mobileNumberController,
                                autofocus: true,
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: textColor,
                                ),
                                focusNode: mobileNumberFocusNode,
                                dropdownIconPosition: IconPosition.trailing,
                                disableLengthCheck: true,
                                initialCountryCode: "IN",
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  focusColor: Colors.white,
                                  hoverColor: Colors.white,
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      mobileNumberController.text = "";
                                      mobileNumberFocusNode.unfocus();
                                    },
                                    child: const Icon(
                                      Icons.close,
                                      size: 18,
                                      color: Colors.red,
                                    ),
                                  ),
                                  border: InputBorder.none,
                                ),
                                onChanged: (phone) {
                                  mobileNumber = phone.completeNumber;
                                  log(mobileNumber);
                                },
                                onCountryChanged: (country) {},
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.65,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                ),
                                onPressed: () {
                                  if (mobileNumberController.text.length ==
                                      10) {
                                    sendFirebaseOTP();
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text("Enter a valid number")));
                                  }
                                },
                                child: const SizedBox(
                                  width: double.infinity,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(top: 14.0, bottom: 14),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.verified_user,
                                          size: 24,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Proceed Securly",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
