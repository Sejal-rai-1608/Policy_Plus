import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turfnpark/widgets/appbar.dart';
import 'package:turfnpark/widgets/payment_card.dart';

class PaymentHistoryPage extends StatelessWidget {
  const PaymentHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
     appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppbar(
          leftImage: "assets/logo/Logo.svg",
          rightImage: "assets/icons/notification.svg",
        ),
      ),

      body: ListView.builder(
        padding: EdgeInsets.all(16.w),
        itemCount: 10,
        itemBuilder: (context, index) {
          return const PaymentCard(
            title: "Premium Policy Booking",
            date: "12 Feb 2026",
            amount: "₹1,200",
            status: "Success",
          );
        },
      ),
    );
  }
}