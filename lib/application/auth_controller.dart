import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zaltek/Screens/auth_screen.dart';
import 'package:zaltek/Screens/home.dart';
import 'package:zaltek/application/item_controller.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  bool _isLoadingHomeScreen = false;

  String _verificationID = '';

  bool otpVisibility = false;
  bool get isAuthenticating => _isLoadingHomeScreen;
  // bool get otpVisibility => _otpVisibility;
  String get authenticationWidgetId => 'authenticationWidgetId';

  //
  //
  // Google Sign In
  //
  //

  Future<void> signInWithGoogle() async {
    _isLoadingHomeScreen = true;
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    _isLoadingHomeScreen = false;
    update([authenticationWidgetId]);
    return await FirebaseAuth.instance.signInWithCredential(credential).then(
        (value) => Get.find<ItemListingController>()
            .getAllItems()
            .then((value) => Navigator.pushReplacement(
                  Get.context!,
                  MaterialPageRoute(builder: (context) => const Home()),
                )));
  }

  //
  // Phone Authentication
  //
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  void loginWithPhone() async {
    _isLoadingHomeScreen = true;
    update([authenticationWidgetId]);
    auth.verifyPhoneNumber(
      phoneNumber: phoneController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((value) {
          print("You are logged in successfully");
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        Fluttertoast.showToast(
            msg: e.message.toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      },
      codeSent: (String verificationId, int? resendToken) {
        update([authenticationWidgetId]);
        otpVisibility = true;
        _verificationID = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
    _isLoadingHomeScreen = false;
    update([authenticationWidgetId]);
  }

  void verifyOTP() async {
    _isLoadingHomeScreen = true;
    update([authenticationWidgetId]);
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationID, smsCode: otpController.text);

    await auth.signInWithCredential(credential).then((value) {
      Fluttertoast.showToast(
              msg: "You are logged in successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0)
          .then((value) => Get.find<ItemListingController>()
              .getAllItems()
              .then((value) => Navigator.pushReplacement(
                    Get.context!,
                    MaterialPageRoute(builder: (context) => const Home()),
                  )));
    });
    _isLoadingHomeScreen = false;
    update([authenticationWidgetId]);
  }

  //
  // Sign Out
  //
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    Navigator.pushReplacement(
      Get.context!,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }
}
