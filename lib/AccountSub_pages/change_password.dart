import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turfnpark/widgets/appbar.dart';
import '../widgets/CTextfield.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();

  bool hidePassword = true;
  bool hideConfirmPassword = true;
  bool hideNewPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F7F7),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppbar(
          leftImage: "assets/logo/Logo.svg",
          rightImage: "assets/icons/notification.svg",
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24.h),

            /// 🔹 Form Container
            Container(
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 14.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 12.r,
                    offset: Offset(0, 6.h),
                  ),
                ],
              ),
              child: Column(
                children: [
                  /// Current Password
                  CTextfield(
                    text: "Current Password",
                    hintText: "Enter current password",
                    controller: passwordController,
                    obscureText: hidePassword,
                    prefix: Icon(
                      Icons.key_outlined,
                      size: 22.sp,
                      color: Colors.black87,
                    ),
                    suffixIcon: IconButton(
                      splashRadius: 20.r,
                      icon: Icon(
                        hidePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        size: 22.sp,
                        color: Colors.grey.shade600,
                      ),
                      onPressed: () =>
                          setState(() => hidePassword = !hidePassword),
                    ),
                  ),

                  SizedBox(height: 16.h),

                  /// New Password
                  CTextfield(
                    text: "New Password",
                    hintText: "Create a strong password",
                    controller: newPasswordController,
                    obscureText: hideNewPassword,
                    prefix: Icon(
                      Icons.lock_outline,
                      size: 22.sp,
                      color: Colors.black87,
                    ),
                    suffixIcon: IconButton(
                      splashRadius: 20.r,
                      icon: Icon(
                        hideNewPassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        size: 22.sp,
                        color: Colors.grey.shade600,
                      ),
                      onPressed: () =>
                          setState(() => hideNewPassword = !hideNewPassword),
                    ),
                  ),

                  SizedBox(height: 16.h),

                  /// Confirm Password
                  CTextfield(
                    text: "Confirm Password",
                    hintText: "Re-enter new password",
                    controller: confirmPasswordController,
                    obscureText: hideConfirmPassword,
                    prefix: Icon(
                      Icons.verified_user_outlined,
                      size: 22.sp,
                      color: Colors.black87,
                    ),
                    suffixIcon: IconButton(
                      splashRadius: 20.r,
                      icon: Icon(
                        hideConfirmPassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        size: 22.sp,
                        color: Colors.grey.shade600,
                      ),
                      onPressed: () => setState(
                        () => hideConfirmPassword = !hideConfirmPassword,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 40.h),

            /// 🔹 Update Button
            SizedBox(
              width: double.infinity,
              height: 54.h,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffF58220),
                  elevation: 6,
                  shadowColor: const Color(0xffF58220).withOpacity(0.4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                child: Text(
                  "Update Password",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
