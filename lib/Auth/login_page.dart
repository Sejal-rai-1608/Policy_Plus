import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:turfnpark/Pages/mainscreen.dart';
import '../auth/forgot_password.dart';
import '../auth/register.dart';
import '../widgets/CTextfield.dart';
import 'package:turfnpark/widgets/primary_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool hidePassword = true;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // ✅ CLEAN LOGIN FUNCTION
  Future<void> loginUser() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter email and password")),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      print("LOGIN START");

      final userCred = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      print("LOGIN SUCCESS: ${userCred.user?.email}");

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Login Successful")));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainScreen()),
      );
    } on FirebaseAuthException catch (e) {
      print("LOGIN ERROR: ${e.message}");

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message ?? "Login failed")));
    } catch (e) {
      print("GENERAL ERROR: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60.h),

              Center(
                child: SvgPicture.asset("assets/logo/Logo.svg", height: 80.h),
              ),

              SizedBox(height: 40.h),

              /// 🔹 EMAIL FIELD
              CTextfield(
                hintText: "Email",
                prefix: SvgPicture.asset(
                  "assets/icons/mail.svg",
                  color: const Color.fromARGB(255, 51, 51, 51),
                ),
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),

              SizedBox(height: 16.h),

              /// 🔹 PASSWORD FIELD
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

              SizedBox(height: 12.h),

              /// 🔹 FORGOT PASSWORD
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ForgotPassword()),
                    );
                  },
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30.h),

              /// 🔹 LOGIN BUTTON
              PrimaryButton(
                text: isLoading ? "Please wait..." : "Login",
                onPressed: isLoading ? () {} : () async => await loginUser(),
              ),

              SizedBox(height: 24.h),

              /// 🔹 REGISTER LINK
              Center(
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(fontSize: 14.sp, color: Colors.black),
                    children: [
                      const TextSpan(text: "Don't have an account? "),
                      TextSpan(
                        text: "Register Now",
                        style: const TextStyle(
                          color: Color(0xffF58220),
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const Register(),
                              ),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}
