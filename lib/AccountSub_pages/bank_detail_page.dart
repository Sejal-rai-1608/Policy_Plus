import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turfnpark/widgets/appbar.dart';

class BankDetailsPage extends StatelessWidget {
  const BankDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
     appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppbar(
          leftImage: "assets/logo/Logo.svg",
          rightImage: "assets/icons/notification.svg",
        ),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            _buildTextField("Account Holder Name"),
            _buildTextField("Bank Name"),
            _buildTextField("Account Number", isNumber: true),
            _buildTextField("Confirm Account Number", isNumber: true),
            _buildTextField("IFSC Code"),
            _buildTextField("Branch Name"),

            SizedBox(height: 30.h),

            /// Save Button
            SizedBox(
              width: double.infinity,
              height: 52.h,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),
                child: Text(
                  "Save Details",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, {bool isNumber = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 14.h),
      child: TextField(
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        style: TextStyle(fontSize: 14.sp),
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 14.h,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.r),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}