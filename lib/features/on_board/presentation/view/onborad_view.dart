import 'package:flutter/material.dart';
import 'package:wafer/core/utils/styles.dart';
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
                  Colors.black.withOpacity(0.1),
                  Colors.black.withOpacity(0.4),
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
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // النص الرئيسي
                Padding(
                  padding: const EdgeInsets.only(top: 16, right: 24),
                  child: Text(
                    'الأن دورك أنت\nلتصنع تأثيراً فى المجتمع\nو ترتقي به !',
                    style: Styles.textStyle30.copyWith(color: Colors.black),
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
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.85),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // أيقونة السهم
                        GestureDetector(
                          onTap: () {
                            // هنا هتروحي على Login أو Register
                          },
                          child: Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 6,
                                ),
                              ],
                            ),
                            child: IconButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.send,
                                color: Colors.black,
                                size: 20,
                              ),
                            ),
                            //
                            // Icon(
                            //   Icons.send,
                            //   color: Colors.black,
                            //   size: 20,
                            // ),
                          ),
                        ),

                        // النص
                        Text(
                          'ابـدأ رحلـتك الأن',
                          style: Styles.textStyle18.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        // السهمين
                        Text(
                          '<<<',
                          style: Styles.textStyle18.copyWith(
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
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
