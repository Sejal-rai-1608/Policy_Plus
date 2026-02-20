import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turfnpark/widgets/appbar.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {
        "title": "Policy Approved",
        "subtitle": "Your health insurance policy has been approved.",
        "time": "2 min ago",
        "icon": Icons.verified,
      },
      {
        "title": "Payment Successful",
        "subtitle": "₹2,500 payment received successfully.",
        "time": "1 hour ago",
        "icon": Icons.payment,
      },
      {
        "title": "Reminder",
        "subtitle": "Your policy renewal is due tomorrow.",
        "time": "Yesterday",
        "icon": Icons.notifications_active,
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xffF7F7F7),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppbar(
          leftImage: "assets/logo/Logo.svg",
          rightImage: "assets/icons/notification.svg",
        ),
      ),

      body: notifications.isEmpty
          ? Center(
              child: Text(
                "No notifications yet",
                style: TextStyle(fontSize: 16.sp, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(16.w),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final item = notifications[index];

                return Container(
                  margin: EdgeInsets.only(bottom: 12.h),
                  padding: EdgeInsets.all(14.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          color: const Color(0xffF58220).withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          item["icon"] as IconData,
                          color: const Color(0xffF58220),
                          size: 22.sp,
                        ),
                      ),
                      SizedBox(width: 14.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item["title"] as String,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15.sp,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              item["subtitle"] as String,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 13.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        item["time"] as String,
                        style: TextStyle(color: Colors.grey, fontSize: 11.sp),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}