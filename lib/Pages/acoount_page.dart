import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:turfnpark/AccountSub_pages/bank_detail_page.dart';
import 'package:turfnpark/AccountSub_pages/change_password.dart';
import 'package:turfnpark/AccountSub_pages/my_policies_page.dart';
import 'package:turfnpark/AccountSub_pages/payment_history_page.dart';
import 'package:turfnpark/Pages/agent_page.dart';
import 'package:turfnpark/utils/app_text_styles.dart';
import 'package:turfnpark/utils/spacing.dart';
import 'package:turfnpark/widgets/app_card.dart';
import 'package:turfnpark/widgets/menu_tile.dart';
import 'package:turfnpark/widgets/primary_button.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  late final List<Map<String, dynamic>> menuItems = [
    {
      "icon": Icons.description,
      "title": "My Policies",
      "onTap": () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MyPoliciesPage()),
        );
      },
    },
    {
      "icon": Icons.payment,
      "title": "Payment History",
      "onTap": () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PaymentHistoryPage()),
        );
      },
    },
    {
      "icon": Icons.account_balance,
      "title": "Bank Details",
      "onTap": () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const BankDetailsPage()),
        );
      },
    },
    {
      "icon": Icons.lock,
      "title": "Change Password",
      "onTap": () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ChangePassword()),
        );
      },
    },

    {
      "icon": Icons.contact_emergency,
      "title": "Agents",
      "onTap": () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AgentPage()),
        );
      },
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🔶 Gradient Header
          Container(
            height: 260.h,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xffF58220), Color(0xffF9A825)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                AppSpace.h20,

                // 👤 Profile Section
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: 55.sp,
                      backgroundColor: Colors.white,
                      backgroundImage: _image != null
                          ? FileImage(_image!)
                          : null,
                      child: _image == null
                          ? Icon(
                              Icons.person,
                              size: 55.sp,
                              color: Colors.orange,
                            )
                          : null,
                    ),

                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: pickImage,
                        child: Container(
                          padding: EdgeInsets.all(6.w),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 18.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                AppSpace.h16,

                Text("Sejal Rai", style: AppTextStyles.whiteSubtitle),

                Text("sejal@email.com", style: AppTextStyles.badgeText),

                AppSpace.h14,

                // 🪪 White Container
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30.r),
                      ),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          // 📦 Menu Card
                          AppCard(
                            child: Column(
                              children: List.generate(menuItems.length, (
                                index,
                              ) {
                                final item = menuItems[index];

                                return MenuTile(
                                  icon: item["icon"] as IconData,
                                  title: item["title"] as String,
                                  onTap: item["onTap"] as VoidCallback,
                                  showDivider: index != menuItems.length - 1,
                                );
                              }),
                            ),
                          ),
                          AppSpace.h24,

                          //  Logout Button
                        ],
                      ),
                    ),
                  ),
                ),
                PrimaryButton(text: "Logout", onPressed: () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
