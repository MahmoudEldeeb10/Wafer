import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wafer/core/utils/app_colors.dart';
import 'package:wafer/core/utils/styles.dart';
import 'package:wafer/core/widgets/custom_button.dart';
import 'package:wafer/features/auth/data/models/auth_model.dart';
import 'package:wafer/features/auth/presentation/manger/cubit/auth_cubit.dart';
import 'package:wafer/features/auth/presentation/manger/cubit/auth_state.dart';
import 'package:wafer/features/auth/presentation/view/login_screen.dart';
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
  final _confirmPasswordController = TextEditingController();

  int _accountType = 0; // 0 = جمعية خيرية, 1 = مؤسسة إنتاجية

  @override
  void dispose() {
    _fullNameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('تم إنشاء الحساب! تحقق من بريدك الإلكتروني'),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
            );
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
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
                                'إنـــشـــاء حـــســـاب جـــديـــد',
                                style: Styles.textStyle30.copyWith(
                                  fontWeight: FontWeight.bold,
                                  ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Center(
                              child: Text(
                                'ابدأ رحـــلــتك الأن',
                                style: Styles.textStyle18.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),

                            /// Name + Username
                            Row(
                              textDirection: TextDirection.rtl,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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

                            /// Email
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
                            const SizedBox(height: 18),

                            /// Password
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
                            const SizedBox(height: 18),

                            /// Confirm Password
                            Text(
                              'تأكيد الـــبـــاســـورد',
                              style: Styles.textStyle18.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            CustomTextField(
                              controller: _confirmPasswordController,
                              hint: '••••••••••••••',
                              isPassword: true,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'يجب أن يكون الباسورد من 8 أحرف على الأقل',
                              style: Styles.textStyle14,
                            ),
                            const SizedBox(height: 18),

                            /// Account Type
                            Text(
                              'التسجيل كـ',
                              style: Styles.textStyle18.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            _AccountTypeRow(
                              label: 'جمعية خيرية',
                              value: _accountType == 0,
                              onChanged: (_) =>
                                  setState(() => _accountType = 0),
                            ),
                            const SizedBox(height: 6),
                            _AccountTypeRow(
                              label:
                                  'مؤسسة إنتاجية (مطاعم، شركات، محلات وغيرهم...)',
                              value: _accountType == 1,
                              onChanged: (_) =>
                                  setState(() => _accountType = 1),
                            ),
                            const SizedBox(height: 24),

                            /// Register Button
                            state is AuthLoading
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : CustomButton(
                                    text: 'إنــــشــــاء حـــســــاب',
                                    onpressed: () {
                                      context.read<AuthCubit>().register(
                                            RegisterRequestModel(
                                              accountType: _accountType,
                                              name: _fullNameController.text
                                                  .trim(),
                                              username: _usernameController
                                                  .text
                                                  .trim(),
                                              email: _emailController.text
                                                  .trim(),
                                              password: _passwordController
                                                  .text
                                                  .trim(),
                                              confirmPassword:
                                                  _confirmPasswordController
                                                      .text
                                                      .trim(),
                                              phone: '01033757408',
                                              description: 'مؤسسة خيرية تعمل على مساعدة المحتاجين',
                                              whatsapp: '01033757408',
                                              city: 'default',
                                              governorate: 'default',
                                              postalCode: '00000',
                                            ),
                                          );
                                    },
                                    color: const Color(0xFF171123),
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
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const LoginScreen(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    ' تسجيل الدخول',
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
        },
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
