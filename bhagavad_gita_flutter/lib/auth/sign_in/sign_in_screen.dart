import 'package:bhagavad_gita_flutter/widget/toast_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../router/routes_names.dart';
import '../../utils/file_collection.dart';
import '../../utils/utils.dart';

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
  FirebaseAuth auth = FirebaseAuth.instance;

  sendFirebaseOTP() async {
    try {
      EasyLoading.show(status: 'loading...');
      auth.setSettings(forceRecaptchaFlow: true); // <-- here is the magic
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: mobileNumber,
        timeout: const Duration(seconds: 120),
        verificationCompleted: (PhoneAuthCredential credential) async {},
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: (String verificationId, int? resendToken) async {
          resendTokens = resendToken;
          // Update the UI - wait for the user to enter the SMS code

          EasyLoading.dismiss();

          context.pushReplacementNamed(RouteNames.otpScreen, pathParameters: {
            'mobileNumber': mobileNumber,
            'verificationId': verificationId,
            'resendToken': resendTokens.toString(),
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      if ('[SmsRetrieverHelper] Timed out waiting for SMS' == e.toString()) {
        EasyLoading.dismiss();
        toast(
            'Your previous OTP is not expired till yet, please wait for 2 min');
      } else {
        EasyLoading.dismiss();
        toast(e.toString());
      }

    //  log("$e", name: "Firebase OTP");
    }
  }

  // @override
  // void dispose() {
  //   mobileNumberController.dispose();
  //   mobileNumberFocusNode.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    AppUtils.handleNotification(Permission.notification);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      floatingActionButton: SizedBox(
        height: 150,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/images/flute1.png', height: 150),
          ],
        ),
      ),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 20, 0.0, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Expanded(
                              flex: 3,
                              child: Column(
                                children: [
                                  Text(
                                    'Enter your mobile number',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w900,
                                      color: textColor,
                                      height: 1.2,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    'we will send you confirmation code',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: textColor),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                children: [
                                  Image.asset('assets/images/flute2.png',
                                      height: 150, width: 200),
                                ],
                              ),
                            )
                          ],
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
                               //   log(mobileNumber);
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
