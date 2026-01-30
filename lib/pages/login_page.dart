import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          // ✅ prevents overflow
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 120),

                Center(
                  child: Column(
                    children: [
                      Text(
                        "LOGIN",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          color: Color(0xff00BE76),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Have Fun with Friends..!!",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                TextField(
                  decoration: InputDecoration(
                    prefixIcon: Image.asset("assets/Icon.png"),
                    hintText: 'Enter your username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// Password Field
                // Image.asset("assets/key.png", height: 24),
                const SizedBox(width: 12),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Image.asset("assets/key.png"),
                    suffixIcon: Image.asset("assets/eye.png"),
                    hintText: 'Enter your password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                /// Forgot password
                Align(
                  alignment: Alignment.bottomRight, // ✅ correct alignment
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff00BE76),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                /// Login Button
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff00BE76),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Center(
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                      children: [
                        const TextSpan(text: "Didn't Have an Account? "),
                        TextSpan(
                          text: "Sign Up",
                          style: const TextStyle(
                            color: Color(0xff00BE76),
                            fontWeight: FontWeight.bold,
                          ),
                          // optional click action
                          // recognizer: TapGestureRecognizer()
                          //   ..onTap = () {
                          //     // Navigate to signup page
                          //   },
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                Center(
                  child: Text(
                    'Other ways to sign-in',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),

                const SizedBox(height: 20),

                /// Social Icons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/google.png", height: 50),
                    const SizedBox(width: 20),
                    Image.asset("assets/facebook.png", height: 50),
                    const SizedBox(width: 20),
                    Image.asset("assets/apple.png", height: 50),
                  ],
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
