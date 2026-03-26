import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:turfnpark/utils/app_text_styles.dart';
import 'package:turfnpark/utils/spacing.dart';
import 'package:turfnpark/widgets/appbar.dart';
import 'package:turfnpark/widgets/CTextfield.dart';
import 'package:turfnpark/widgets/primary_button.dart';
import 'package:turfnpark/Services/api_service.dart';
import 'package:file_picker/file_picker.dart';

class ClaimPage extends StatefulWidget {
  const ClaimPage({super.key});

  @override
  State<ClaimPage> createState() => _ClaimPageState();
}

class _ClaimPageState extends State<ClaimPage> {
  final TextEditingController descriptionController = TextEditingController();

  File? selectedFile;

  String? selectedPolicy;
  String? selectedClaimType;
  bool isSubmitted = false;

  /// FILE PICKER FUNCTION
  Future pickFile() async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        selectedFile = File(result.files.single.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),

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

            /// FORM CARD
            Container(
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.05),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),

              child: Column(
                children: [
                  /// POLICY DROPDOWN
                  CTextfield(
                    text: "Select Policy *",
                    hintText: "Choose Policy",

                    isDropdown: true,
                    dropdownItems: const [
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
                        ? "Please select policy"
                        : null,
                  ),

                  AppSpace.h8,

                  /// CLAIM TYPE DROPDOWN
                  CTextfield(
                    text: "Claim Type *",
                    hintText: "Select Claim Type",

                    isDropdown: true,
                    dropdownItems: const [
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
                        ? "Please select claim type"
                        : null,
                  ),

                  AppSpace.h8,

                  /// DESCRIPTION FIELD
                  CTextfield(
                    text: "Incident Description",
                    hintText: "Describe what happened...",
                    controller: descriptionController,
                    maxLines: 5,
                  ),

                  AppSpace.h8,

                  /// UPLOAD DOCUMENT LABEL
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Upload Documents",
                      style: AppTextStyles.fieldLabel,
                    ),
                  ),

                  AppSpace.h8,

                  /// FILE PICKER BUTTON
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: pickFile,
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
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
                            const Icon(
                              Icons.upload_file,
                              color: Colors.black54,
                            ),

                            AppSpace.w4,

                            Text(
                              selectedFile == null
                                  ? "Upload Files"
                                  : selectedFile!.path.split('/').last,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  AppSpace.h14,

                  /// SUBMIT BUTTON
                  PrimaryButton(
                    text: "Submit Claim",

                    onPressed: () async {
                      try {
                        setState(() {
                          isSubmitted = true;
                        });

                        if (selectedPolicy != null &&
                            selectedClaimType != null) {
                          print("SENDING CLAIM DATA...");

                          await ApiService.addClaim({
                            "policy": selectedPolicy,
                            "claimType": selectedClaimType,
                            "description": descriptionController.text,
                            "document": selectedFile?.path ?? "no-file",
                          });

                          print("CLAIM SAVED SUCCESSFULLY");

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Claim submitted successfully"),
                            ),
                          );
                        } else {
                          print("VALIDATION FAILED");
                        }
                      } catch (e) {
                        print("CLAIM ERROR: $e");

                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text("Error: $e")));
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
