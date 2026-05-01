import 'package:flutter/material.dart';
import 'package:wafer/core/utils/app_colors.dart';
import 'package:wafer/core/utils/styles.dart';
import 'package:wafer/core/widgets/custom_button.dart';
import 'package:wafer/features/auth/presentation/view/widgets/custom_text_field.dart';
import 'widgets/auth_header.dart';
import 'widgets/auth_divider.dart';
import 'widgets/social_login_buttons.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _fullNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isCharity = true;
  bool _isEnterprise = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _usernameController.dispose();
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
                          'إنشاء حساب جديد',
                          style: Styles.textStyle30.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Center(
                        child: Text(
                          'إبدأ رحلتك الآن',
                          style: Styles.textStyle18.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Full name + username row
                      Row(
                        textDirection: TextDirection.rtl,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'الاسم الكامل',
                                  style: Styles.textStyle18.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                CustomTextField(
                                  controller: _fullNameController,
                                  hint: 'واتسون فيسك',
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'اسم المستخدم',
                                  style: Styles.textStyle18.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                CustomTextField(
                                  controller: _usernameController,
                                  hint: 'فيسك011',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),

                      Text(
                        'البريد الإلكتروني',
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
                      const SizedBox(height: 18),

                      Text(
                        'الباسورد',
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
                        'يجب أن يكون الباسورد من 8 أحرف على الأقل',
                        style: Styles.textStyle14,
                      ),
                      const SizedBox(height: 18),

                      Text(
                        'التسجيل كـ',
                        style: Styles.textStyle18.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),

                      _AccountTypeRow(
                        label: 'جمعية خيرية',
                        value: _isCharity,
                        onChanged: (v) =>
                            setState(() => _isCharity = v ?? false),
                      ),
                      const SizedBox(height: 6),
                      _AccountTypeRow(
                        label:
                            'مؤسسة إنتاجية  (مطاعم، شركات، محلات ماليس و غيرهم ...)',
                        value: _isEnterprise,
                        onChanged: (v) =>
                            setState(() => _isEnterprise = v ?? false),
                      ),
                      const SizedBox(height: 24),

                      CustomButton(
                        text: 'إنشاء حساب',
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
                            'لديك حساب بالفعل؟',
                            style: Styles.textStyle18.copyWith(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(' تسجيل الدخول', style: Styles.textStyle18),
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

class _AccountTypeRow extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool?> onChanged;

  const _AccountTypeRow({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primaryText,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            side: BorderSide(color: AppColors.primaryText, width: 1.5),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: Styles.textStyle14,
            textDirection: TextDirection.rtl,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
