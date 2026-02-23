import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turfnpark/utils/app_text_styles.dart';
import 'package:turfnpark/utils/spacing.dart';

class AgentCard extends StatelessWidget {
  final Map<String, String> agent;

  const AgentCard({super.key, required this.agent});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 14.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          /// 👤 Image
          CircleAvatar(
            radius: 28.r,
            backgroundImage: AssetImage(agent["image"] ?? ""),
          ),

          AppSpace.w10,

          /// Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(agent["name"] ?? "", style: AppTextStyles.fieldLabel),
                AppSpace.h4,
                Text(agent["email"] ?? "", style: AppTextStyles.hintText),
                AppSpace.h4,
                Row(
                  children: [
                    Icon(Icons.call, size: 16.sp),
                    AppSpace.w10,
                    Text(agent["mobile"] ?? "", style: AppTextStyles.smallText),
                    AppSpace.w10,
                    Icon(Icons.work_outline, size: 16.sp),
                    AppSpace.w4,
                    Text(agent["status"] ?? "", style: AppTextStyles.smallText),
                  ],
                ),
              ],
            ),
          ),

          /// Buttons
          Column(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.remove_red_eye_outlined,
                  color: Color(0xffF58220),
                ),
                onPressed: () => showAgentDetails(context, agent),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// ✅ Bottom Sheet
  void showAgentDetails(BuildContext context, Map<String, String> agent) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return SafeArea(
          top: false,
          child: DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.75,
            minChildSize: 0.5,
            maxChildSize: 0.95,
            builder: (_, controller) {
              return Padding(
                padding: EdgeInsets.all(16.w),
                child: SingleChildScrollView(
                  controller: controller,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// drag indicator
                      Center(
                        child: Container(
                          height: 4.h,
                          width: 40.w,
                          margin: EdgeInsets.only(bottom: 12.h),
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                      ),

                      /// Header
                      Center(
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 40.r,
                              backgroundImage: AssetImage(agent["image"] ?? ""),
                            ),
                            AppSpace.h4,
                            Text(
                              agent["name"] ?? "",
                              style: AppTextStyles.subTitle,
                            ),
                            Text(
                              agent["status"] ?? "",
                              style: const TextStyle(color: Colors.green),
                            ),
                          ],
                        ),
                      ),

                      AppSpace.h16,

                      sectionTitle("Personal Information"),
                      infoRow("Email", agent["email"]),
                      infoRow("Mobile", agent["mobile"]),
                      infoRow("WhatsApp", agent["mobile"]),
                      infoRow("Gender", "Male"),
                      infoRow("Nationality", "Indian"),
                      infoRow("Status", agent["status"]),

                      AppSpace.h12,

                      sectionTitle("Address"),
                      infoRow("State", "Andhra Pradesh"),
                      infoRow("City", "Port Blair"),
                      infoRow("Pincode", "401201"),
                      infoRow("Address", "98 Second Lane"),

                      AppSpace.h12,

                      sectionTitle("Banking Information"),
                      infoRow("Bank Account", "Hedy"),
                      infoRow("UPI ID", "58848488"),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

/// 🔹 Section Title
Widget sectionTitle(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Text(
      title,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
  );
}

/// 🔹 Info Row
Widget infoRow(String label, String? value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(flex: 4, child: Text(value ?? "-")),
      ],
    ),
  );
}
