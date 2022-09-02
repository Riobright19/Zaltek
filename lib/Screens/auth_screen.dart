import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zaltek/application/auth_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool showButton = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
          child: ListView(
        children: [
          Center(child: Image.asset('assets/firebase.png')),
          SizedBox(
            height: 200.h,
          ),
          loginButton(context, () {
            Get.find<AuthController>().signInWithGoogle();
          }, 'Google', Colors.blue, Icons.phone),
          SizedBox(
            height: 40.h,
          ),
          loginButton(context, () {
            setState(() {
              showButton = false;
            });
          }, 'Phone', Colors.green, Icons.phone),
          phoneAuthenticationFields()
        ],
      )),
    );
  }

  Widget loginButton(BuildContext context, void Function() onTap, String text,
      Color color, IconData icon) {
    return Visibility(
      visible: showButton,
      child: InkWell(
          onTap: onTap,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 50.h),
            width: MediaQuery.of(context).size.width,
            height: 150.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.h), color: color),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Get.find<AuthController>().isAuthenticating
                  ? const CircularProgressIndicator()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          icon,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 30.w,
                        ),
                        Text(
                          text,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 50.h,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
            ),
          )),
    );
  }

  Widget phoneAuthenticationFields() {
    return GetBuilder<AuthController>(
        id: Get.find<AuthController>().authenticationWidgetId,
        builder: (controller) {
          return Visibility(
            visible: !showButton,
            child: Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: controller.phoneController,
                    decoration:
                        const InputDecoration(labelText: "Phone number"),
                    keyboardType: TextInputType.phone,
                  ),
                  Visibility(
                    child: TextField(
                      controller: controller.otpController,
                      decoration: const InputDecoration(),
                      keyboardType: TextInputType.number,
                    ),
                    visible: controller.otpVisibility,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (controller.otpVisibility) {
                          controller.verifyOTP();
                        } else {
                          controller.loginWithPhone();
                        }
                      },
                      child:
                          Text(controller.otpVisibility ? "Verify" : "Login")),
                ],
              ),
            ),
          );
        });
  }
}
