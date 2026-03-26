import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turfnpark/Pages/Stats_page.dart';

import 'package:turfnpark/Categories Sub_Pages/insurance_page.dart';
import 'package:turfnpark/Pages/all_plans_page.dart';
import 'package:turfnpark/utils/spacing.dart';
import 'package:turfnpark/widgets/appbar.dart';
import 'package:turfnpark/widgets/outlined_button.dart';
import 'package:turfnpark/widgets/policy_card.dart';
import 'package:turfnpark/widgets/categories.dart';
import 'package:turfnpark/utils/app_text_styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int bannerIndex = 0;
  int Index = 0;

  /// 🔹 Top banners
  final List<String> banners = [
    'assets/images/banner1.jpg',
    'assets/images/banner2.jpg',
    'assets/images/banner3.jpg',
  ];

  final List<Map<String, String>> policyFeatures = [
    {
      "emoji": "📊",
      "title": "Compare ",
      "desc": "Compare insurance  side by side.",
    },
    {
      "emoji": "💰",
      "title": "Save Money",
      "desc": "Find affordable insurance options.",
    },
    {
      "emoji": "📋",
      "title": "Easy Claims",
      "desc": "File claims easily & quickly.",
    },
  ];

  /// 🔹  banners
  final List<String> Banners = [
    "assets/images/banner1.jpg",
    "assets/images/banner2.jpg",
    "assets/images/banner3.jpg",
  ];

  /// 🔹 Insurance categories
  final List<Map<String, String>> insuranceList = [
    {
      "image": "assets/images/healthinsurance.png",
      "title": "Health\nInsurance",
    },
    {
      "image": "assets/images/travelinsurance.png",
      "title": "Travel\nInsurance",
    },
    {
      "image": "assets/images/twowheelerinsurance.png",
      "title": "Two Wheeler\nInsurance",
    },
    {
      "image": "assets/images/termlifeinsurance.png",
      "title": "Term Life\nInsurance",
    },
    {
      "image": "assets/images/familyinsurance.png",
      "title": "Family\nInsurance",
    },
    {"image": "assets/images/investmentplan.png", "title": "Investment\n"},
    {"image": "assets/images/employeeplan.png", "title": "Employee\n"},
    {"image": "assets/images/carinsurance.png", "title": "Car\nInsurance"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: const CustomAppbar(
        showBackButton: false,
        leftImage: "assets/logo/Logo.svg",
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 👋 Greeting
              Text("Hello, Sejal", style: AppTextStyles.mainTitle),
              AppSpace.h4,
              Text("Welcome Back", style: AppTextStyles.mainTitlewithgrey),

              AppSpace.h10,

              /// 🔥 TOP CAROUSEL
              _buildCarousel(banners, bannerIndex, (i) {
                setState(() => bannerIndex = i);
              }),
              AppSpace.h10,
              _buildStatsSection(),
              AppSpace.h10,

              AppSpace.h10,

              /// 🔹 Categories
              Text("Categories", style: AppTextStyles.subTitle),
              AppSpace.h10,

              _buildInsuranceGrid(),

              AppSpace.h10,

              /// 🔹 View all button
              OutlinedButtonWidget(
                text: "View All ",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AllPlansPage()),
                  );
                },
              ),

              AppSpace.h10,

              /// 🔹 Why Policy Plus
              Text("Why Policy Plus?", style: AppTextStyles.subTitle),
              AppSpace.h10,

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: policyFeatures.map((item) {
                    return PolicyCard(
                      emoji: item["emoji"]!,
                      title: item["title"]!,
                      description: item["desc"]!,
                    );
                  }).toList(),
                ),
              ),

              AppSpace.h10,

              /// 🔹 Popular
              Text("Popular Plus", style: AppTextStyles.subTitle),
              AppSpace.h10,

              _buildCarousel(Banners, Index, (i) {
                setState(() => Index = i);
              }, height: 115.h),
            ],
          ),
        ),
      ),
    );
  }

  // =========================================================
  // 🔥 REUSABLE CAROUSEL
  // =========================================================

  Widget _buildCarousel(
    List<String> images,
    int currentIndex,
    Function(int) onChange, {
    double height = 160,
  }) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: height,
            viewportFraction: 1,
            autoPlay: true,
            onPageChanged: (index, _) => onChange(index),
          ),
          items: images.map((path) {
            return Image.asset(
              path,
              width: double.infinity,
              fit: BoxFit.cover,
            );
          }).toList(),
        ),
        AppSpace.h10,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            images.length,
            (i) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              height: 8.h,
              width: currentIndex == i ? 16.w : 8.w,
              decoration: BoxDecoration(
                color: currentIndex == i
                    ? const Color(0xffF58220)
                    : Colors.grey.shade400,
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // =========================================================
  // 🔥 INSURANCE GRID
  // =========================================================

  Widget _buildInsuranceGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: insuranceList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 20.h,
        crossAxisSpacing: 10.w,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (_, index) {
        final item = insuranceList[index];

        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const InsurancePage()),
          ),
          child: InsuranceItem(
            imagePath: item["image"]!,
            title: item["title"]!,
          ),
        );
      },
    );
  }

  Widget _buildStatsSection() {
    final stats = [
      {
        "title": "Campaign Sent",
        "value": "197",
        "icon": Icons.rocket_launch_rounded,
      },
      {
        "title": "Annual Profit",
        "value": "₹489.4k",
        "icon": Icons.currency_rupee_rounded,
      },
      {
        "title": "Lead Conversion",
        "value": "32.89%",
        "icon": Icons.trending_up_rounded,
      },
      {
        "title": "Daily Avg Income",
        "value": "₹1,596.5",
        "icon": Icons.account_balance_wallet_rounded,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Your Stats", style: AppTextStyles.subTitle),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => StatsPage()),
                );
              },
              child: Row(
                children: [
                  Text(
                    "More",
                    style: TextStyle(
                      color: const Color(0xffF58220),
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 14.sp,
                    color: const Color(0xffF58220),
                  ),
                ],
              ),
            ),
          ],
        ),

        SizedBox(height: 14.h),

        /// Cards
        SizedBox(
          height: 150.h, // 👈 increased height
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: stats.length,
            separatorBuilder: (_, __) => SizedBox(width: 16.w),
            itemBuilder: (_, index) {
              final item = stats[index];

              return Container(
                width: 210.w, // 👈 increased width
                padding: EdgeInsets.all(18.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  gradient: LinearGradient(
                    colors: [Colors.white, const Color(0xffFFF6ED)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xffF58220).withOpacity(0.15),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Icon badge
                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xffF58220).withOpacity(0.15),
                      ),
                      child: Icon(
                        item["icon"] as IconData,
                        color: const Color(0xffF58220),
                        size: 24.sp,
                      ),
                    ),

                    const Spacer(),

                    /// Value
                    Text(
                      item["value"] as String,
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 6.h),

                    /// Title
                    Text(
                      item["title"] as String,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
