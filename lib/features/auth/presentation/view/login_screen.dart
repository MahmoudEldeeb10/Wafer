import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wafer/core/utils/app_colors.dart';
import 'package:wafer/core/utils/styles.dart';
import 'package:wafer/core/widgets/custom_button.dart';
import 'package:wafer/features/auth/presentation/manger/cubit/auth_cubit.dart';
import 'package:wafer/features/auth/presentation/manger/cubit/auth_state.dart';
import 'package:wafer/features/auth/presentation/view/signup_screen.dart';
import 'package:wafer/features/auth/presentation/view/widgets/custom_text_field.dart';
import 'package:wafer/features/botton_nav_bar/presentation/views/main_view.dart';
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
    return BlocProvider(
      create: (_) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => MainView()),
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

                            /// Login Button
                            state is AuthLoading
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : CustomButton(
                                    text: 'تـــســـجـــيـــل الـــدخـــول',
                                    onpressed: () {
                                      context.read<AuthCubit>().login(
                                            usernameOrEmail:
                                                _emailController.text.trim(),
                                            password:
                                                _passwordController.text.trim(),
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
        },
      ),
    );
  }
}