import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turfnpark/widgets/appbar.dart';
import 'package:turfnpark/widgets/primary_button.dart';
import '../services/api_service.dart';

class BankDetailsPage extends StatefulWidget {
  const BankDetailsPage({super.key});

  @override
  State<BankDetailsPage> createState() => _BankDetailsPageState();
}

class _BankDetailsPageState extends State<BankDetailsPage> {
  final holderController = TextEditingController();
  final bankController = TextEditingController();
  final accountController = TextEditingController();
  final confirmAccountController = TextEditingController();
  final ifscController = TextEditingController();
  final branchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F6FB),
      appBar: const CustomAppbar(leftImage: "assets/logo/Logo.svg"),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(18.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Bank Details",
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 6.h),

            Text(
              "Add your bank account for secure transactions",
              style: TextStyle(fontSize: 12.sp, color: Colors.grey),
            ),

            SizedBox(height: 20.h),

            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.05),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),

              child: Column(
                children: [
                  _inputField(
                    "Account Holder Name",
                    holderController,
                    Icons.person_outline,
                  ),

                  _inputField(
                    "Bank Name",
                    bankController,
                    Icons.account_balance_outlined,
                  ),

                  _inputField(
                    "Account Number",
                    accountController,
                    Icons.credit_card_outlined,
                    isNumber: true,
                  ),

                  _inputField(
                    "Confirm Account Number",
                    confirmAccountController,
                    Icons.credit_card,
                    isNumber: true,
                  ),

                  _inputField("IFSC Code", ifscController, Icons.code),

                  _inputField(
                    "Branch Name",
                    branchController,
                    Icons.location_on_outlined,
                  ),
                ],
              ),
            ),

            SizedBox(height: 30.h),

            PrimaryButton(
              text: "Save Details",
              onPressed: () async {
                try {
                  if (accountController.text != confirmAccountController.text) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Account numbers do not match"),
                      ),
                    );
                    return;
                  }

                  print("SENDING BANK DATA...");
                  print(holderController.text);

                  final response = await ApiService.addBankDetails({
                    "accountHolder": holderController.text,
                    "bankName": bankController.text,
                    "accountNumber": accountController.text,
                    "ifsc": ifscController.text,
                    "branch": branchController.text,
                  });

                  print("BANK SAVED SUCCESSFULLY");

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Bank details saved successfully"),
                    ),
                  );
                } catch (e) {
                  print("BANK ERROR: $e");

                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("Error: $e")));
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputField(
    String hint,
    TextEditingController controller,
    IconData icon, {
    bool isNumber = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 14.h),
      child: TextField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: const Color(0xffF58220)),
          hintText: hint,
          filled: true,
          fillColor: const Color(0xffF8F9FD),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.r),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
