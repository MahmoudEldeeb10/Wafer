import 'package:flutter/material.dart';
import 'package:wafer/core/utils/app_colors.dart';
import 'package:wafer/core/utils/styles.dart';
import 'package:wafer/core/widgets/custom_button.dart';
import 'package:wafer/features/auth/presentation/view/signup_screen.dart';
import 'package:wafer/features/auth/presentation/view/widgets/custom_text_field.dart';
import 'widgets/auth_header.dart';
import 'widgets/auth_divider.dart';
import 'widgets/social_login_buttons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.logohHaderColor,
      body: SafeArea(
        child: Column(
          children: [
            const AuthHeader(),
            Expanded(
              child: Container(
                width: double.infinity,

                margin: const EdgeInsets.only(top: 8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 28,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'تسجيل الدخول',
                          style: Styles.textStyle30.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Center(
                        child: Text(
                          'مرحباً بعودتك!',
                          style: Styles.textStyle18.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),

                      Text(
                        'البـــريـــد الإلكـــتــروني',
                        style: Styles.textStyle18.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      CustomTextField(
                        controller: _emailController,
                        hint: 'eg. johnfrans@gmail.com',
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 20),

                      Text(
                        'الـــبـــاســـورد',
                        style: Styles.textStyle18.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      CustomTextField(
                        controller: _passwordController,
                        hint: '••••••••••••••',
                        isPassword: true,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'يجب أن يتكون الباسورد من 8 أحرف على الأقل.',
                        style: Styles.textStyle14,
                      ),
                      const SizedBox(height: 28),

                      CustomButton(
                        text: 'تسجيل الدخول',
                        onpressed: () {},
                        color: AppColors.primaryText,
                        textColor: AppColors.fourthText,
                      ),
                      const SizedBox(height: 20),

                      const AuthDivider(),
                      const SizedBox(height: 20),

                      const SocialLoginButtons(),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Text(
                            'لـــيـــس لـــديـــك حـــســـاب؟',
                            style: Styles.textStyle18.copyWith(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const SignupScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'إنـــشـــاء حـــســـاب',
                              style: Styles.textStyle18,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
