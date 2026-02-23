import 'package:flutter/material.dart';
import 'package:turfnpark/utils/app_text_styles.dart';
import 'package:turfnpark/utils/spacing.dart';
import 'package:turfnpark/widgets/appbar.dart';
import 'package:turfnpark/widgets/CTextfield.dart';
import 'package:turfnpark/widgets/primary_button.dart';

class ClaimPage extends StatefulWidget {
  const ClaimPage({super.key});

  @override
  State<ClaimPage> createState() => _ClaimPageState();
}

class _ClaimPageState extends State<ClaimPage> {
  final TextEditingController descriptionController = TextEditingController();

  String? selectedPolicy;
  String? selectedClaimType;
  bool isSubmitted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA), // 🔥 soft background

      appBar: const CustomAppbar(
        showBackButton: false,
        leftImage: "assets/logo/Logo.svg",
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSpace.h8,

            /// 🔥 FORM CARD CONTAINER
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  /// 🔹 POLICY DROPDOWN
                  CTextfield(
                    text: "Select Policy *",
                    hintText: "Choose Policy",

                    isDropdown: true,
                    dropdownItems: [
                      "Health Insurance",
                      "Car Insurance",
                      "Life Insurance",
                      "Home Insurance",
                    ],
                    value: selectedPolicy,
                    onChanged: (value) {
                      setState(() {
                        selectedPolicy = value;
                      });
                    },
                    errorText: isSubmitted && selectedPolicy == null
                        ? "Please select sub agent"
                        : null,
                  ),

                  AppSpace.h8,

                  /// 🔹 CLAIM TYPE DROPDOWN
                  CTextfield(
                    text: "Claim Type *",
                    hintText: "Select Claim Type",

                    isDropdown: true,
                    dropdownItems: [
                      "Accident",
                      "Hospitalization",
                      "Theft",
                      "Damage",
                    ],
                    value: selectedClaimType,
                    onChanged: (value) {
                      setState(() {
                        selectedClaimType = value;
                      });
                    },
                    errorText: isSubmitted && selectedClaimType == null
                        ? "Please select sub agent"
                        : null,
                  ),

                  AppSpace.h8,

                  /// 🔹 DESCRIPTION BOX
                  CTextfield(
                    text: "Incident Description",
                    hintText: "Describe what happened...",
                    controller: descriptionController,
                    maxLines: 5,
                  ),

                  AppSpace.h8,

                  /// 🔹 UPLOAD DOCUMENT SECTION
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Upload Documents",
                      style: AppTextStyles.fieldLabel,
                    ),
                  ),

                  AppSpace.h8,

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.upload_file, color: Colors.black54),
                        AppSpace.w4,
                        Text(
                          "Upload Files",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),

                  AppSpace.h14,

                  /// 🔥 GRADIENT SUBMIT BUTTON
                  // GestureDetector(
                  //   onTap: () {
                  //     print("Claim Submitted");
                  //   },
                  PrimaryButton(
                    text: "Submit Claim",
                    onPressed: () {
                      setState(() {
                        isSubmitted = true;
                      });

                      if (selectedPolicy != null && selectedClaimType != null) {
                        print("Move to next step");
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
