import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turfnpark/widgets/CTextfield.dart';
import 'package:turfnpark/widgets/appbar.dart';
import 'package:turfnpark/widgets/primary_button.dart';

class BankDetailsPage extends StatelessWidget {
  const BankDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: const CustomAppbar(leftImage: "assets/logo/Logo.svg"),

        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              CTextfield(
                hintText: "Account Holder Name",
                text: "Account Holder Name",
                errorText: "Enter Account Holder Name",
              ),
              CTextfield(
                hintText: "Bank Name",
                text: "Bank Name",
                errorText: "Enter Bank Name",
              ),
              CTextfield(
                hintText: "Account Number",
                text: "Account Number",
                errorText: "Account Number",
              ),
              CTextfield(
                hintText: "Confirm Account Number",
                text: "Confirm Account Number",
                errorText: "Enter Account Number",
              ),
              CTextfield(
                hintText: "IFSC Code",
                text: "IFSC Code",
                errorText: "Enter IFSC Code",
              ),
              CTextfield(
                hintText: "Branch Name",
                text: "Branch Name",
                errorText: "Enter Branch Name",
              ),

              /// Save Button
              PrimaryButton(text: "Save Details", onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
