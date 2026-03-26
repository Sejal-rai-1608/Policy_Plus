import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turfnpark/utils/app_text_styles.dart';
import 'package:turfnpark/utils/spacing.dart';
import 'package:turfnpark/widgets/appbar.dart';
import 'package:turfnpark/widgets/outlined_button.dart';
import 'package:turfnpark/widgets/planlist_cards.dart';
import 'package:turfnpark/Pages/plandetail.dart';
import '../services/api_service.dart';

class Plans extends StatelessWidget {
  const Plans({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppbar(
        showBackButton: false,
        leftImage: "assets/logo/Logo.svg",
      ),
      body: Column(
        children: [
          /// 🔹 Top Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Plans for self",
                    style: AppTextStyles.mainTitle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(Icons.tune, size: 22.w, color: Colors.black),
              ],
            ),
          ),

          AppSpace.h10,

          /// 🔹 Plans List from API
          Expanded(
            child: FutureBuilder(
              future: ApiService.getPlans(),
              builder: (context, snapshot) {
                /// Loading
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                /// No Data
                if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
                  return const Center(child: Text("No Plans Available"));
                }

                var plans = snapshot.data as List;

                return ListView.builder(
                  itemCount: plans.length + 1,
                  itemBuilder: (context, index) {
                    /// Last button
                    if (index == plans.length) {
                      return Column(
                        children: [
                          AppSpace.h14,
                          Center(
                            child: OutlinedButtonWidget(
                              text: "View All Plans",
                              onPressed: () {},
                            ),
                          ),
                          AppSpace.h14,
                        ],
                      );
                    }

                    var plan = plans[index];

                    return Column(
                      children: [
                        PlanListCard(
                          imagePath: "assets/insurance/${plan["image"]}",
                          planName: plan["planName"],
                          coverAmount: plan["coverAmount"],
                          price: "₹${plan["price"]}/month",
                          title: "View features",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PlanDetail(),
                              ),
                            );
                          },
                        ),

                        AppSpace.h14,
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
