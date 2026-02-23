import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turfnpark/utils/app_text_styles.dart';
import 'package:turfnpark/utils/spacing.dart';
import 'package:turfnpark/widgets/CTextfield.dart';
import 'package:turfnpark/widgets/primary_button.dart';

class AddAgentPage extends StatefulWidget {
  const AddAgentPage({super.key});

  @override
  State<AddAgentPage> createState() => _AddAgentPageState();
}

class _AddAgentPageState extends State<AddAgentPage> {
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();

  String? gender;
  String? agentType;
  String? status;

  void _saveAgent() {
    if (nameController.text.isEmpty ||
        mobileController.text.isEmpty ||
        agentType == null ||
        gender == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill required fields")),
      );
      return;
    }

    Navigator.pop(context, {
      "name": nameController.text,
      "email": emailController.text,
      "mobile": mobileController.text,
      "status": status ?? "Active",
      "image": "assets/images/agent.jpg",
    });
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(top: 18.h, bottom: 8.h),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(title, style: AppTextStyles.subTitle),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// TITLE
              Center(
                child: Text(
                  "Add Agent",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              AppSpace.h10,

              /// 👤 PERSONAL DETAILS
              sectionTitle("Personal Details"),

              CTextfield(
                text: "Agent Name",
                hintText: "Agent Name",
                controller: nameController,
              ),

              Row(
                children: [
                  Expanded(
                    child: CTextfield(
                      text: "Agent Type",
                      hintText: "Select Type",
                      isDropdown: true,
                      value: agentType,
                      dropdownItems: const ["Agent", "Sub Agent", "Manager"],
                      onChanged: (val) => setState(() => agentType = val),
                    ),
                  ),
                  AppSpace.w10,
                  Expanded(
                    child: CTextfield(
                      text: "Gender",
                      hintText: "Gender",
                      isDropdown: true,
                      value: gender,
                      dropdownItems: const ["Male", "Female", "Other"],
                      onChanged: (val) => setState(() => gender = val),
                    ),
                  ),
                ],
              ),

              Row(
                children: [
                  Expanded(
                    child: CTextfield(
                      text: "Mobile",
                      hintText: "Mobile Number",
                      controller: mobileController,
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                  AppSpace.w10,
                  Expanded(
                    child: CTextfield(
                      text: "Email",
                      hintText: "Email",
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                ],
              ),

              /// 📍 ADDRESS DETAILS
              sectionTitle("Address Details"),

              Row(
                children: [
                  Expanded(
                    child: CTextfield(text: "State", hintText: "State"),
                  ),
                  AppSpace.w10,
                  Expanded(
                    child: CTextfield(text: "City", hintText: "City"),
                  ),
                ],
              ),

              Row(
                children: [
                  Expanded(
                    child: CTextfield(text: "Pincode", hintText: "Pincode"),
                  ),
                  Expanded(child: SizedBox()), // empty space for alignment
                ],
              ),

              CTextfield(text: "Address Line 1", hintText: "Address Line 1"),
              CTextfield(text: "Address Line 2", hintText: "Address Line 2"),

              /// 🪪 IDENTITY DETAILS
              sectionTitle("Identity Details"),

              Row(
                children: [
                  Expanded(
                    child: CTextfield(text: "PAN", hintText: "PAN Number"),
                  ),
                  AppSpace.w10,
                  Expanded(
                    child: CTextfield(
                      text: "Aadhar",
                      hintText: "Aadhar Number",
                    ),
                  ),
                ],
              ),

              /// 🏦 BANKING DETAILS
              sectionTitle("Banking Details"),

              CTextfield(text: "Bank Name", hintText: "Bank Name"),

              Row(
                children: [
                  Expanded(
                    child: CTextfield(text: "IFSC", hintText: "IFSC Code"),
                  ),
                  AppSpace.w10,
                  Expanded(
                    child: CTextfield(text: "UPI", hintText: "UPI ID"),
                  ),
                ],
              ),

              /// ⚙️ STATUS
              sectionTitle("Status"),

              CTextfield(
                hintText: "Select Status",
                isDropdown: true,
                value: status,
                dropdownItems: const ["Active", "Inactive"],
                onChanged: (val) => setState(() => status = val),
              ),

              AppSpace.h20,

              /// SAVE BUTTON
              PrimaryButton(onPressed: _saveAgent, text: 'Save Agent'),

              AppSpace.h20,
            ],
          ),
        ),
      ),
    );
  }
}
