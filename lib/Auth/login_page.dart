import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:turfnpark/Pages/mainscreen.dart';
import 'package:turfnpark/utils/app_text_styles.dart';
import 'package:turfnpark/utils/spacing.dart';
import 'package:turfnpark/widgets/primary_button.dart';
import '../auth/forgot_password.dart';
import '../auth/register.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/CTextfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  bool hidePassword = true;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSpace.h24,

              /// 🔥 Logo + Title
              Center(
                child: Column(
                  children: [
                    SvgPicture.asset(
                      "assets/logo/Logo.svg",
                      height: ScreenUtil().screenHeight < 700 ? 60.h : 80.h,
                    ),
                    AppSpace.h10,
                    // Text(
                    //   "PolicyPlus",
                    //   style: TextStyle(
                    //     fontSize: 28.sp,
                    //     fontWeight: FontWeight.bold,
                    //     color: Colors.black,
                    //   ),
                    // ),
                  ],
                ),
              ),

              AppSpace.h20,

              /// 🔥 Username
              CTextfield(
                hintText: "Username",
                prefix: SvgPicture.asset(
                  "assets/icons/Icon.svg",
                  color: const Color.fromARGB(255, 51, 51, 51),
                ),
                controller: usernameController,
              ),

              AppSpace.h10,

              /// 🔥 Password
              CTextfield(
                hintText: "Password",
                prefix: SvgPicture.asset(
                  "assets/icons/key.svg",
                  color: const Color.fromARGB(255, 51, 51, 51),
                ),
                controller: passwordController,
                obscureText: hidePassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    hidePassword ? Icons.visibility_off : Icons.visibility,
                    size: 20.sp,
                  ),
                  onPressed: () {
                    setState(() {
                      hidePassword = !hidePassword;
                    });
                  },
                ),
              ),

              /// 🔥 Forgot Password
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ForgotPassword()),
                    );
                  },
                  child: Text(
                    "Forgot Password?",
                    style: AppTextStyles.cardMeta,
                  ),
                ),
              ),

              AppSpace.h24,

              /// 🔥 Login Button
              PrimaryButton(
                text: "Login",
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MainScreen()),
                  );
                },
              ),
              AppSpace.h20,

              /// 🔥 Register
              Center(
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(fontSize: 14.sp, color: Colors.black),
                    children: [
                      const TextSpan(text: "Don't have an account? "),
                      TextSpan(
                        text: "Register Now",
                        style: TextStyle(
                          color: const Color(0xffF58220),
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Register(),
                              ),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ),

              AppSpace.h24,

              /// 🔥 Divider Text
              Center(
                child: Text(
                  "Other ways to sign in",
                  style: AppTextStyles.cardMeta,
                ),
              ),

              AppSpace.h20,

              /// 🔥 Social Icons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/logo/facebook.png", height: 36.h),
                  AppSpace.w16,
                  SvgPicture.asset("assets/logo/google.svg", height: 36.h),
                  AppSpace.w16,
                  SvgPicture.asset("assets/logo/apple.svg", height: 36.h),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
