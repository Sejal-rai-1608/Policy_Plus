import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:turfnpark/services/api_service.dart' as ApiService;
import 'package:turfnpark/widgets/appbar.dart';
import '../services/api_service.dart';

class MyPoliciesPage extends StatelessWidget {
  const MyPoliciesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F6FB),
      appBar: const CustomAppbar(leftImage: "assets/logo/Logo.svg"),

      body: Column(
        children: [
          SizedBox(height: 12.h),

          /// 🔹 Summary Card
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 18.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  summaryItem("Total", "-"),
                  divider(),
                  summaryItem("Active", "-"),
                  divider(),
                  summaryItem("Expired", "-"),
                ],
              ),
            ),
          ),

          SizedBox(height: 20.h),

          /// 🔹 Policy List from API
          Expanded(
            child: FutureBuilder(
              future: ApiService.getPolicies(),
              builder: (context, snapshot) {
                print("SNAPSHOT DATA: ${snapshot.data}");
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
                  return const Center(child: Text("No policies found"));
                }

                var policies = snapshot.data as List;

                return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  itemCount: policies.length,
                  itemBuilder: (context, index) {
                    var policy = policies[index];

                    return PolicyCard(
                      title: policy["title"],
                      policyNo: policy["_id"].toString().substring(0, 6),
                      description: policy["description"],
                      coverage: "₹${policy["price"] ?? 0}",
                      premium: "₹${policy["price"] ?? 0}/year",
                      validTill: "2026",
                      status: "Active",
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

  static Widget summaryItem(String title, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4.h),
        Text(
          title,
          style: TextStyle(
            fontSize: 10.sp,
            color: Colors.grey,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  static Widget divider() {
    return Container(height: 28.h, width: 1, color: Colors.grey.shade300);
  }
}

class PolicyCard extends StatelessWidget {
  final String title;
  final String policyNo;
  final String description;
  final String coverage;
  final String premium;
  final String validTill;
  final String status;

  const PolicyCard({
    super.key,
    required this.title,
    required this.policyNo,
    required this.description,
    required this.coverage,
    required this.premium,
    required this.validTill,
    required this.status,
  });

  Color getStatusColor() {
    switch (status) {
      case "Active":
        return Colors.green;
      case "Expired":
        return Colors.red;
      default:
        return Colors.orange;
    }
  }

  IconData getIcon() {
    if (title.contains("Health")) return Icons.favorite;
    if (title.contains("Life")) return Icons.shield;
    return Icons.directions_car;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 18.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          /// Title Row
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: const Color(0xffF58220).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  getIcon(),
                  color: const Color(0xffF58220),
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp,
                  ),
                ),
              ),
              statusBadge(),
            ],
          ),

          SizedBox(height: 14.h),

          infoRow("Policy No", policyNo),
          infoRow("Description", description),
          infoRow("Coverage", coverage),
          infoRow("Premium", premium),
          infoRow("Valid Till", validTill),

          SizedBox(height: 12.h),

          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: Text(
                "View Details →",
                style: TextStyle(
                  color: const Color(0xffF58220),
                  fontWeight: FontWeight.bold,
                  fontSize: 13.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget infoRow(String title, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Row(
        children: [
          Text(
            "$title:",
            style: TextStyle(color: Colors.grey, fontSize: 12.sp),
          ),
          SizedBox(width: 6.w),
          Text(
            value,
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget statusBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: getStatusColor().withOpacity(0.1),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: getStatusColor(),
          fontWeight: FontWeight.bold,
          fontSize: 11.sp,
        ),
      ),
    );
  }
}
