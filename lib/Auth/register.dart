import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:turfnpark/widgets/primary_button.dart';
import '../widgets/CTextfield.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:turfnpark/auth/login_page.dart';

// 🔥 ADD THESE
import 'package:http/http.dart' as http;
import 'dart:convert';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final contactController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool hidePassword = true;
  bool hideConfirmPassword = true;
  bool isLoading = false;

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    contactController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  // 🔥 FINAL REGISTER FUNCTION
  Future<void> registerUser() async {
    if (usernameController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Passwords do not match")));
      return;
    }

    setState(() => isLoading = true);

    try {
      print("STEP 1: Firebase start");

      // 🔥 STEP 1: Firebase Register
      UserCredential userCred = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );

      print("STEP 2: Firebase success");

      String uid = userCred.user!.uid;
      print("UID: $uid");

      // 🔥 STEP 2: BACKEND CALL
      print("STEP 3: Sending to backend");

      var response = await http.post(
        Uri.parse(
          "https://policyplus-backend.onrender.com/api/users/saveUser",
        ), // ⚠️ IP check
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "uid": uid,
          "username": usernameController.text,
          "email": emailController.text,
          "phone": phoneController.text,
        }),
      );

      // 🔥 DEBUG OUTPUT
      print("STATUS: ${response.statusCode}");
      print("BODY: ${response.body}");

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Registration Successful")));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } on FirebaseAuthException catch (e) {
      print("FIREBASE ERROR: ${e.message}");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "Registration failed")),
      );
    } catch (e) {
      print("GENERAL ERROR: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                SvgPicture.asset("assets/logo/Logo.svg", height: 80),

                const SizedBox(height: 40),

                CTextfield(
                  hintText: "Username",
                  prefix: SvgPicture.asset(
                    "assets/icons/Icon.svg",
                    color: const Color.fromARGB(255, 51, 51, 51),
                  ),
                  controller: usernameController,
                ),

                CTextfield(
                  hintText: "Email Id",
                  prefix: SvgPicture.asset(
                    "assets/icons/mail.svg",
                    color: const Color.fromARGB(255, 51, 51, 51),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                ),

                CTextfield(
                  hintText: "Contact Number",
                  prefix: SvgPicture.asset(
                    "assets/icons/contact.svg",
                    color: const Color.fromARGB(255, 51, 51, 51),
                  ),
                  keyboardType: TextInputType.phone,
                  controller: phoneController,
                ),

                CTextfield(
                  hintText: "New Password",
                  prefix: SvgPicture.asset(
                    "assets/icons/key.svg",
                    color: const Color.fromARGB(255, 51, 51, 51),
                  ),
                  controller: passwordController,
                  obscureText: hidePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      hidePassword ? Icons.visibility_off : Icons.visibility,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                  ),
                ),

                CTextfield(
                  hintText: "Confirm Password",
                  prefix: SvgPicture.asset(
                    "assets/icons/key.svg",
                    color: const Color.fromARGB(255, 51, 51, 51),
                  ),
                  controller: confirmPasswordController,
                  obscureText: hideConfirmPassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      hideConfirmPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        hideConfirmPassword = !hideConfirmPassword;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 30),

                PrimaryButton(
                  text: isLoading ? "Please wait..." : "Register",
                  onPressed: isLoading ? () {} : () async => registerUser(),
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already Have An Account? "),
                    Text.rich(
                      TextSpan(
                        text: "Login Now",
                        style: const TextStyle(
                          color: Color(0xffF58220),
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            );
                          },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                const Text(
                  "----------------- Others Ways to sign-in -------------------",
                  style: TextStyle(fontSize: 14),
                ),

                const SizedBox(height: 15),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/logo/facebook.png"),
                    const SizedBox(width: 20),
                    SvgPicture.asset("assets/logo/google.svg"),
                    const SizedBox(width: 20),
                    SvgPicture.asset("assets/logo/apple.svg"),
                  ],
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
