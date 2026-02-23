import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turfnpark/utils/app_text_styles.dart';
import 'package:turfnpark/utils/spacing.dart';

class PaymentCard extends StatelessWidget {
  final String title;
  final String date;
  final String amount;
  final String status;

  const PaymentCard({
    super.key,
    required this.title,
    required this.date,
    required this.amount,
    required this.status,
  });

  Color getStatusColor() {
    switch (status) {
      case "Success":
        return Colors.green;
      case "Pending":
        return Colors.orange;
      case "Failed":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 14.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8.r,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(Icons.receipt_long, size: 26.sp, color: Colors.black87),
          ),
          SizedBox(width: 14.w),

          /// Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.cardMeta),
                AppSpace.h8,
                Text(date, style: AppTextStyles.hintText),
              ],
            ),
          ),

          /// Amount + Status
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(amount, style: AppTextStyles.fieldLabel),
              SizedBox(height: 6.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: getStatusColor().withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(status, style: AppTextStyles.successText),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
