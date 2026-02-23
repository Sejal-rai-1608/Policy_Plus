import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turfnpark/utils/app_text_styles.dart';
import 'package:turfnpark/utils/spacing.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  static const primaryOrange = Color(0xffF58220);
  static const bgColor = Color(0xffFFF6ED);

  /// animated chart values
  List<double> values = [0, 0, 0, 0, 0, 0];

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 400), () {
      setState(() {
        values = [12, 18, 15, 22, 17, 26];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Dashboard"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            children: [
              /// 🔥 TOP REVENUE CARD
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.r),
                  gradient: const LinearGradient(
                    colors: [Color(0xffF58220), Color(0xffFF9F45)],
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -40.w,
                      top: -40.h,
                      child: Container(
                        height: 140.w,
                        width: 140.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.08),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Revenue",
                          style: AppTextStyles.whiteSubtitle,
                        ),
                        Text(
                          "₹ 4,89,400",
                          style: AppTextStyles.mainTitlewithwhite,
                        ),
                        AppSpace.h4,
                        Text("+18% this month", style: AppTextStyles.badgeText),
                      ],
                    ),
                  ],
                ),
              ),

              AppSpace.h20,

              /// 📊 REVENUE GRAPH CARD
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Revenue Overview", style: AppTextStyles.cardTitle),
                    AppSpace.h10,
                    SizedBox(
                      height: 220.h,
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          maxY: 30,
                          borderData: FlBorderData(show: false),
                          gridData: FlGridData(show: false),
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  const months = [
                                    "Jan",
                                    "Feb",
                                    "Mar",
                                    "Apr",
                                    "May",
                                    "Jun",
                                  ];
                                  return Padding(
                                    padding: EdgeInsets.only(top: 6.h),
                                    child: Text(
                                      months[value.toInt()],
                                      style: AppTextStyles.smallText,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          barGroups: List.generate(
                            values.length,
                            (i) => makeBar(i, values[i]),
                          ),
                        ),
                        swapAnimationDuration: const Duration(
                          milliseconds: 900,
                        ),
                        swapAnimationCurve: Curves.easeOutBack,
                      ),
                    ),
                  ],
                ),
              ),

              AppSpace.h20,

              /// 🫧 DASHBOARD CARDS GRID
              LayoutBuilder(
                builder: (context, constraints) {
                  return GridView.count(
                    crossAxisCount: constraints.maxWidth > 600 ? 4 : 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 20.w,
                    mainAxisSpacing: 20.h,
                    childAspectRatio: 1,
                    children: const [
                      DashboardCard(
                        title: "Total Agents",
                        value: "197",
                        icon: Icons.people,
                      ),
                      DashboardCard(
                        title: "Customers",
                        value: "2,659",
                        icon: Icons.person,
                      ),
                      DashboardCard(
                        title: "Annual Deals",
                        value: "489",
                        icon: Icons.favorite,
                      ),
                      DashboardCard(
                        title: "Conversion",
                        value: "32.8%",
                        icon: Icons.trending_up,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  static BarChartGroupData makeBar(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          width: 14.w,
          borderRadius: BorderRadius.circular(20.r),
          gradient: const LinearGradient(
            colors: [Color(0xffF58220), Color(0xffFFD1A3)],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
      ],
    );
  }
}

/// 🫧 Dashboard Card
class DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const DashboardCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  static const primaryOrange = Color(0xffF58220);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.r),
        gradient: const LinearGradient(
          colors: [Color(0xffFFE5D0), Color(0xffFFD1B0)],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50.w,
            width: 50.w,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.6),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: primaryOrange, size: 24.sp),
          ),
          SizedBox(height: 12.h),
          Text(value, style: AppTextStyles.cardTitle),
          AppSpace.h4,
          Text(title, style: AppTextStyles.smallText),
        ],
      ),
    );
  }
}
