import 'package:flutter/material.dart';
import 'package:wafer/core/utils/app_colors.dart';
import 'package:wafer/core/widgets/custom_app_bar.dart';
import 'widgets/request_card.dart';

class RequestView extends StatelessWidget {
  const RequestView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> requests = [
      {
        "title": "مطعم بانوراما",
        "description": "متوفر كمية من الدجاج فائضة (130 كيلوجرام)",
        "phone": "+965223485",
        "location": "القاهرة",
      },
      {
        "title": "مصنع حديد عز",
        "description": "بقايا حديد ومستلزمات بناء",
        "phone": "+965332554",
        "location": "المنصورة",
      },
      {
        "title": "مزرعة الدلتا",
        "description": "كمية أرز فائضة (50 كيلوجرام)",
        "phone": "+965974155",
        "location": "أسوان",
      },
      {
        "title": "شركة فواكه",
        "description": "فاكهة طازجة فائضة",
        "phone": "+965364554",
        "location": "الجيزة",
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.logohHaderColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 15),
              const CustomAppBar(
                title: 'الطلبات المقترحة !',
                firstIcon: Icons.search,
                secondIcon: Icons.notifications_none,
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(bottom: 100),
                  itemCount: requests.length,
                  itemBuilder: (context, index) {
                    final request = requests[index];
                    return RequestCard(
                      title: request["title"]!,
                      description: request["description"]!,
                      phone: request["phone"]!,
                      location: request["location"]!,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
