import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turfnpark/widgets/CTextfield.dart';
import 'package:turfnpark/widgets/appbar.dart';
import 'package:turfnpark/widgets/primary_button.dart';

class BankDetailsPage extends StatefulWidget {
  const BankDetailsPage({super.key});

  @override
  State<BankDetailsPage> createState() => _BankDetailsPageState();
}

class _BankDetailsPageState extends State<BankDetailsPage> {
  String? nameError;
  String? bankError;
  String? accountError;
  String? confirmAccountError;
  String? ifscError;
  String? branchError;
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final bankController = TextEditingController();
  final accountController = TextEditingController();
  final confirmAccountController = TextEditingController();
  final ifscController = TextEditingController();
  final branchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppbar(leftImage: "assets/logo/Logo.svg"),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CTextfield(
                  text: "Enter Account Holder Name",
                  hintText: "Account Holder Name",
                  controller: nameController,
                  errorText: accountError,
                  // validator: (v) =>
                  //     v!.isEmpty ? "Enter Account Holder Name" : null,
                ),
                CTextfield(
                  text: "Enter Bank Name",
                  hintText: "Bank Name",
                  controller: bankController,
                  errorText: bankError,

                  ///   validator: (v) => v!.isEmpty ? "Enter Bank Name" : null,
                ),
                CTextfield(
                  text: "Enter Account Number",
                  hintText: "Account Number",
                  controller: accountController,
                  errorText: accountError,
                  // validator: (v) =>
                  //     v!.isEmpty ? "Enter Account Number" : null,
                ),
                CTextfield(
                  text: "Confirm Account Number",
                  hintText: "Confirm Account Number",
                  controller: confirmAccountController,
                  errorText: accountError,
                  // validator: (v) {
                  //   if (v!.isEmpty) return "Confirm Account Number";
                  //   if (v != accountController.text) {
                  //     return "Account numbers do not match";
                  //   }
                  //   return null;
                  // },
                ),
                CTextfield(
                  text: "Enter IFSC",
                  hintText: "IFSC Code",
                  controller: ifscController,
                  errorText: ifscError,
                  //  validator: (v) => v!.isEmpty ? "Enter IFSC Code" : null,
                ),
                CTextfield(
                  text: "Enter Branch Name",
                  hintText: "Branch Name",
                  controller: branchController,
                  errorText: branchError,
                  // validator: (v) => v!.isEmpty ? "Enter Branch Name" : null,
                ),

                SizedBox(height: 20.h),

                PrimaryButton(
                  text: "Save Details",
                  onPressed: () {
                    setState(() {
                      nameError = nameController.text.isEmpty
                          ? "Enter Account Holder Name"
                          : null;

                      bankError = bankController.text.isEmpty
                          ? "Enter Bank Name"
                          : null;

                      accountError = accountController.text.isEmpty
                          ? "Enter Account Number"
                          : null;

                      confirmAccountError =
                          confirmAccountController.text.isEmpty
                          ? "Confirm Account Number"
                          : confirmAccountController.text !=
                                accountController.text
                          ? "Account numbers do not match"
                          : null;

                      ifscError = ifscController.text.isEmpty
                          ? "Enter IFSC Code"
                          : null;

                      branchError = branchController.text.isEmpty
                          ? "Enter Branch Name"
                          : null;
                    });

                    if (nameError == null &&
                        bankError == null &&
                        accountError == null &&
                        confirmAccountError == null &&
                        ifscError == null &&
                        branchError == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Details Saved")),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
