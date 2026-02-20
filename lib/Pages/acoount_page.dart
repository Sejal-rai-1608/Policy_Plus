import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:turfnpark/AccountSub_pages/bank_detail_page.dart';
import 'package:turfnpark/AccountSub_pages/change_password.dart';
import 'package:turfnpark/AccountSub_pages/my_policies_page.dart';
import 'package:turfnpark/AccountSub_pages/payment_history_page.dart';

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
      "title": "Contact Us",
      "onTap": () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MyPoliciesPage()),
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
            height: 280,
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
                const SizedBox(height: 30),

                // 👤 Profile Section
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.white,
                      backgroundImage: _image != null
                          ? FileImage(_image!)
                          : null,
                      child: _image == null
                          ? const Icon(
                              Icons.person,
                              size: 55,
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
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                const Text(
                  "Sejal Rai",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 5),

                const Text(
                  "sejal@email.com",
                  style: TextStyle(color: Colors.white70),
                ),

                const SizedBox(height: 25),

                // 🪪 White Container
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      children: [
                        // 📦 Menu Card
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            children: List.generate(menuItems.length, (index) {
                              final item = menuItems[index];

                              return Column(
                                children: [
                                  buildRow(
                                    item["icon"] as IconData,
                                    item["title"] as String,
                                    item["onTap"] as VoidCallback,
                                  ),
                                  if (index != menuItems.length - 1)
                                    const Divider(height: 1),
                                ],
                              );
                            }),
                          ),
                        ),

                        const SizedBox(height: 30),

                        //  Logout Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: () {
                              print("Logout Clicked");
                            },
                            child: const Text(
                              "Logout",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRow(IconData icon, String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Row(
          children: [
            Icon(icon, color: Colors.orange),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }
}
