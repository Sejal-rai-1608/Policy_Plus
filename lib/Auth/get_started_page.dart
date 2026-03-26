import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:turfnpark/auth/login_page.dart';
import 'package:turfnpark/utils/spacing.dart';
import 'package:turfnpark/widgets/primary_button.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF58220),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              /// 🔥 Push content to center
              const Spacer(),

              SvgPicture.asset("assets/logo/Logo .svg", height: 160.h),

              const Spacer(),

              /// 🔥 Button at bottom
              PrimaryButton(
                text: "Get Started",
                textColor: Color(0xFFF58220),
                backgroundColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
              ),
              AppSpace.h20,
            ],
          ),
        ),
      ),
    );
  }
}
