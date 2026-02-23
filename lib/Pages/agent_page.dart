import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turfnpark/Pages/add_agent_page.dart';
import 'package:turfnpark/utils/app_text_styles.dart';
import 'package:turfnpark/widgets/agent_card.dart';
import 'package:turfnpark/widgets/appbar.dart';

class AgentPage extends StatefulWidget {
  const AgentPage({super.key});

  @override
  State<AgentPage> createState() => _AgentPageState();
}

class _AgentPageState extends State<AgentPage> {
  final List<Map<String, String>> agents = [
    {
      "name": "Rahul Sharma",
      "email": "rahul@gmail.com",
      "mobile": "4455667788",
      "status": "Active",
      "image": "assets/images/agent.jpg",
    },
    {
      "name": "Priya Mehta",
      "email": "priya@gmail.com",
      "mobile": "7766778899",
      "status": "Active",
      "image": "assets/images/agent.jpg",
    },
  ];

  Future<void> _openAddAgent() async {
    final newAgent = await Navigator.push<Map<String, String>>(
      context,
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.black54,
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (_, __, ___) => const AddAgentPage(),
        transitionsBuilder: (_, animation, __, child) {
          return SlideTransition(
            position: Tween(begin: const Offset(0, 1), end: Offset.zero)
                .animate(
                  CurvedAnimation(parent: animation, curve: Curves.easeOut),
                ),
            child: child,
          );
        },
      ),
    );

    if (newAgent != null) {
      setState(() => agents.add(newAgent));

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Agent added successfully")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          /// HEADER
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("All Agents", style: AppTextStyles.cardTitle),

                ElevatedButton.icon(
                  onPressed: _openAddAgent,
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text(
                    "Add Agent",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffF58220),
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 10.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// AGENT LIST
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: agents.length,
              itemBuilder: (context, index) {
                final agent = agents[index];

                return Dismissible(
                  key: Key(agent["mobile"]!), // unique id

                  direction: DismissDirection.endToStart, // swipe left only

                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    margin: EdgeInsets.only(bottom: 12.h),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),

                  onDismissed: (direction) {
                    final removedAgent = agents[index];

                    setState(() {
                      agents.removeAt(index);
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("${removedAgent["name"]} deleted"),
                        action: SnackBarAction(
                          label: "UNDO",
                          onPressed: () {
                            setState(() {
                              agents.insert(index, removedAgent);
                            });
                          },
                        ),
                      ),
                    );
                  },

                  child: AgentCard(agent: agent),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
