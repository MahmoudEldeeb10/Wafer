import 'package:flutter/material.dart';
import 'package:wafer/core/utils/app_colors.dart';
import 'package:wafer/core/utils/styles.dart';
import 'package:wafer/core/widgets/custom_button.dart';
import 'package:wafer/features/auth/presentation/view/login_screen.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // الصورة Background كاملة الشاشة
          SizedBox.expand(
            child: Image.asset(
              'assets/images/onboardimage.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // طبقة شفافة فوق الصورة
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.tertiaryText.withOpacity(0.1),
                  AppColors.tertiaryText.withOpacity(0.4),
                ],
              ),
            ),
          ),

          // المحتوى
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // اسم التطبيق
                Padding(
                  padding: const EdgeInsets.only(top: 24, right: 24),
                  child: Text(
                    'وَافِــر',
                    style: Styles.textStyle30.copyWith(
                      color: AppColors.tertiaryText,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // النص الرئيسي
                Padding(
                  padding: const EdgeInsets.only(top: 16, right: 24),
                  child: Text(
                    'الأن دورك أنت\nلتصنع تأثيراً فى المجتمع\nو ترتقي به !',
                    style: Styles.textStyle30.copyWith(
                      color: AppColors.tertiaryText,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),

                const Spacer(),

                // زرار ابدأ رحلتك الآن
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 32,
                  ),
                  child: CustomButton(
                    text: 'ابدأ رحلتك الآن',
                    onpressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    color: AppColors.fourthText,
                    textColor: AppColors.tertiaryText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
