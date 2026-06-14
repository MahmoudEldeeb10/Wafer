import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wafer/core/utils/app_colors.dart';
import 'package:wafer/core/widgets/custom_app_bar.dart';
import 'package:wafer/features/profile/data/models/profile_model.dart';
import 'package:wafer/features/profile/presentation/manger/profile_cubit.dart';
import 'package:wafer/features/profile/presentation/manger/profile_state.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final _nameCtrl = TextEditingController();
  final _usernameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _whatsappCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _cityCtrl = TextEditingController();
  final _governorateCtrl = TextEditingController();
  final _postalCodeCtrl = TextEditingController();

  int _verificationState = 0;
  ProfileModel? _cachedProfile;

  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getProfile();
  }

  void _fillControllers(ProfileModel profile) {
    _nameCtrl.text =
        profile.charityDetails?.charityName ??
        profile.donorDetails?.donorOrganizationName ??
        '';
    _usernameCtrl.text = profile.userName ?? '';
    _phoneCtrl.text = _stripCountryCode(profile.phone ?? '');
    _whatsappCtrl.text = _stripCountryCode(profile.whatsapp ?? '');
    _emailCtrl.text = profile.email ?? '';
    _cityCtrl.text = profile.city ?? '';
    _governorateCtrl.text = profile.governorate ?? '';
    _postalCodeCtrl.text = profile.postalCode ?? '';
    setState(() {
      _verificationState = profile.verificationState ?? 0;
      _cachedProfile = profile;
    });
  }

  String _stripCountryCode(String phone) {
    if (phone.startsWith('+20')) return phone.substring(3);
    if (phone.startsWith('20')) return phone.substring(2);
    return phone;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _usernameCtrl.dispose();
    _phoneCtrl.dispose();
    _whatsappCtrl.dispose();
    _emailCtrl.dispose();
    _cityCtrl.dispose();
    _governorateCtrl.dispose();
    _postalCodeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is ProfileLoaded) {
              _cachedProfile = state.profile;
              _fillControllers(state.profile);
            }

            if (state is ProfileUpdateSuccess) {
              context.read<ProfileCubit>().submitVerification();
            }

            if (state is ProfileVerificationSuccess) {
              setState(() => _verificationState = 1);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('تم إرسال طلب التحقق بنجاح'),
                  backgroundColor: Colors.green,
                ),
              );
            }

            if (state is ProfileVerificationCancelled) {
              setState(() => _verificationState = 0);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('تم إلغاء طلب التحقق'),
                  backgroundColor: Colors.orange,
                ),
              );
            }

            if (state is ProfileError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is ProfileLoading;

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: CustomAppBar(
                      title: 'تعديل الملف الشخصي',
                      firstIcon: Icons.search,
                      secondIcon: Icons.notifications_outlined,
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// Profile Image
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: _cachedProfile?.imageUrl != null
                          ? Image.network(
                              _cachedProfile!.imageUrl!,
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => _imagePlaceholder(),
                            )
                          : _imagePlaceholder(),
                    ),
                  ),

                  const SizedBox(height: 24),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (isLoading)
                          const Padding(
                            padding: EdgeInsets.only(bottom: 16),
                            child: Center(child: CircularProgressIndicator()),
                          ),

                        _buildSection(
                          title: 'بيانات الحساب',
                          children: [
                            _buildField(
                              label: 'اسم الجمعية',
                              controller: _nameCtrl,
                              icon: Icons.business_outlined,
                            ),
                            _buildField(
                              label: 'اسم المستخدم',
                              controller: _usernameCtrl,
                              icon: Icons.person_outline,
                              hint: '(لا يمكن تغييره إلا بعد 30 يوم)',
                              hintColor: Colors.orange.shade700,
                            ),
                            _buildField(
                              label: 'البريد الإلكتروني',
                              controller: _emailCtrl,
                              icon: Icons.email_outlined,
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        _buildSection(
                          title: 'بيانات التواصل',
                          children: [
                            _buildField(
                              label: 'رقم الهاتف',
                              controller: _phoneCtrl,
                              icon: Icons.phone_outlined,
                              keyboardType: TextInputType.phone,
                            ),
                            _buildField(
                              label: 'واتساب',
                              controller: _whatsappCtrl,
                              icon: Icons.chat_outlined,
                              keyboardType: TextInputType.phone,
                            ),
                          ],
                        ),

                        const SizedBox(height: 32),

                        /// الزرار - يظهر بس لما البيانات تتحمل
                        if (_cachedProfile != null)
                          SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _verificationState == 1
                                    ? Colors.red
                                    : AppColors.primaryText,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              onPressed: isLoading
                                  ? null
                                  : () {
                                      if (_verificationState == 1) {
                                        context
                                            .read<ProfileCubit>()
                                            .cancelVerification();
                                      } else {
                                        context
                                            .read<ProfileCubit>()
                                            .updateProfile(
                                              ProfileModel(
                                                userName: _usernameCtrl.text,
                                                email: _emailCtrl.text,
                                                phone: _phoneCtrl.text,
                                                whatsapp: _whatsappCtrl.text,
                                                city: _cityCtrl.text,
                                                governorate:
                                                    _governorateCtrl.text,
                                                postalCode:
                                                    _postalCodeCtrl.text,
                                              ),
                                            );
                                      }
                                    },
                              child: isLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      _verificationState == 1
                                          ? 'إلغاء الطلب'
                                          : 'حفظ التعديلات',
                                      style: const TextStyle(
                                        color: AppColors.fourthText,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),

                        const SizedBox(height: 120),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryText,
            ),
          ),
          const Divider(height: 20),
          ...children,
        ],
      ),
    );
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    String? hint,
    Color? hintColor,
    TextInputType? keyboardType,
    bool enabled = true,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: controller,
            enabled: enabled,
            textAlign: TextAlign.right,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              prefixIcon: Icon(icon, size: 20, color: Colors.grey.shade500),
              filled: true,
              fillColor: enabled ? Colors.grey.shade50 : Colors.grey.shade100,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: AppColors.primaryText,
                  width: 1.5,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
            ),
          ),
          if (hint != null) ...[
            const SizedBox(height: 4),
            Text(
              hint,
              style: TextStyle(fontSize: 11, color: hintColor ?? Colors.grey),
            ),
          ],
        ],
      ),
    );
  }

  Widget _imagePlaceholder() => Container(
    height: 200,
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.grey.shade200,
      borderRadius: BorderRadius.circular(24),
    ),
    child: const Icon(Icons.image_outlined, size: 60, color: Colors.grey),
  );
}
