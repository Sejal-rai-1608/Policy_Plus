import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:turfnpark/Pages/Home.dart';
import 'package:turfnpark/Pages/claim_page.dart';
import 'package:turfnpark/Pages/Plans.dart';
import 'package:turfnpark/Pages/acoount_page.dart';
import 'package:turfnpark/Pages/help_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomePage(),
    ClaimPage(),
    Plans(),
    AccountPage(),
    HelpPage(),
  ];

  static const Color activeColor = Color(0xffF58220);
  static const Color inactiveColor = Color(0xff8A94A6);

  /// SVG icon builder
  Widget navIcon(String path, bool active) {
    return SvgPicture.asset(
      path,
      height: 22.sp,
      colorFilter: ColorFilter.mode(
        active ? activeColor : inactiveColor,
        BlendMode.srcIn,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: false, // ⭐ allows floating blur

      body: IndexedStack(index: _currentIndex, children: _screens),

      bottomNavigationBar: SafeArea(
        child: Padding(
          // ⭐ floating spacing
          padding: EdgeInsets.fromLTRB(1.w, 0, 1.w, 1.h),

          child: ClipRRect(
            borderRadius: BorderRadius.circular(2.r),

            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),

              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28.r),

                  // ⭐ glass look
                  color: Colors.white.withOpacity(.15),

                  border: Border.all(color: Colors.white.withOpacity(.25)),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.10),
                      blurRadius: 24.r,
                      offset: Offset(0, 12.h),
                    ),
                  ],
                ),

                /// ⭐ removes white material layer
                child: Theme(
                  data: Theme.of(context).copyWith(
                    canvasColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                  child: Material(
                    type: MaterialType.transparency,
                    child: BottomNavigationBar(
                      currentIndex: _currentIndex,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      type: BottomNavigationBarType.fixed,
                      selectedItemColor: activeColor,
                      unselectedItemColor: inactiveColor,
                      showUnselectedLabels: true,
                      selectedFontSize: 12.sp,
                      unselectedFontSize: 11.sp,

                      onTap: (index) {
                        setState(() => _currentIndex = index);
                      },

                      items: [
                        BottomNavigationBarItem(
                          icon: navIcon("assets/bottomnav/home.svg", false),
                          activeIcon: navIcon(
                            "assets/bottomnav/home.svg",
                            true,
                          ),
                          label: "Home",
                        ),

                        BottomNavigationBarItem(
                          icon: navIcon("assets/bottomnav/claim.svg", false),
                          activeIcon: navIcon(
                            "assets/bottomnav/claim.svg",
                            true,
                          ),
                          label: "Claims",
                        ),

                        /// ⭐ CENTER BUTTON
                        BottomNavigationBarItem(
                          icon: Container(
                            height: 50.w,
                            width: 50.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: activeColor,
                              boxShadow: [
                                BoxShadow(
                                  color: activeColor.withOpacity(.35),
                                  blurRadius: 20.r,
                                  spreadRadius: 1,
                                  offset: Offset(0, 6.h),
                                ),
                              ],
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                "assets/bottomnav/policy.svg",
                                height: 24.sp,
                                colorFilter: const ColorFilter.mode(
                                  Colors.white,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ),
                          label: "Policies",
                        ),

                        BottomNavigationBarItem(
                          icon: navIcon("assets/bottomnav/account.svg", false),
                          activeIcon: navIcon(
                            "assets/bottomnav/account.svg",
                            true,
                          ),
                          label: "Account",
                        ),

                        BottomNavigationBarItem(
                          icon: navIcon("assets/bottomnav/help.svg", false),
                          activeIcon: navIcon(
                            "assets/bottomnav/help.svg",
                            true,
                          ),
                          label: "Help",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
