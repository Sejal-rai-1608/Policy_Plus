import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:turfnpark/Categories Sub_Pages/insurance_page.dart';
import 'package:turfnpark/utils/spacing.dart';
import 'package:turfnpark/widgets/appbar.dart';
import 'package:turfnpark/widgets/outlined_button.dart';
import 'package:turfnpark/widgets/policy_card.dart';
import 'package:turfnpark/widgets/categories.dart';
import 'package:turfnpark/utils/app_text_styles.dart';
import 'all_plans_page.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int bannerIndex = 0;
  int plansIndex = 0;

  /// 🔹 Top banners
  final List<String> banners = [
    'assets/images/Banner.jpeg',
    'assets/images/Banner.jpeg',
    'assets/images/Banner.jpeg',
  ];

  final List<Map<String, String>> policyFeatures = [
    {
      "emoji": "📊",
      "title": "Compare Plans",
      "desc": "Compare insurance plans side by side.",
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

  /// 🔹 Plans banners
  final List<String> plansBanners = [
    "assets/images/banner1.jpeg",
    "assets/images/banner2.jpeg",
    "assets/images/banner3.jpeg",
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
    {"image": "assets/images/investmentplan.png", "title": "Investment\nPlans"},
    {"image": "assets/images/employeeplan.png", "title": "Employee\nPlans"},
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

              /// 🔹 Categories
              Text("Categories", style: AppTextStyles.subTitle),
              AppSpace.h10,

              _buildInsuranceGrid(),

              AppSpace.h10,

              /// 🔹 View all button
              OutlinedButtonWidget(
                text: "View All Plans",
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

              /// 🔹 Popular Plans
              Text("Popular Plus", style: AppTextStyles.subTitle),
              AppSpace.h10,

              _buildCarousel(plansBanners, plansIndex, (i) {
                setState(() => plansIndex = i);
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
            viewportFraction: 1.0,
            autoPlay: true,
            enlargeCenterPage: true,
            onPageChanged: (index, _) => onChange(index),
          ),
          items: images.map((path) {
            /// 🔥 detect file type
            final isSvg = path.toLowerCase().endsWith(".svg");

            return ClipRRect(
              borderRadius: BorderRadius.circular(14.r),
              child: isSvg
                  ? SvgPicture.asset(
                      path,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      path,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
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
}
