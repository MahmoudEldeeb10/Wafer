// import 'package:flutter/material.dart';
// import 'package:wafer/core/widgets/custom_app_bar.dart';

// class ProfileView extends StatelessWidget {
//   const ProfileView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.all(12.0),
//           child: Column(
//             children: [
//               CustomAppBar(
//                 title: 'المــلــف الشــخــصــي',
//                 firstIcon: Icons.search,
//                 secondIcon: Icons.notifications_outlined,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:wafer/core/utils/app_colors.dart';
import 'package:wafer/core/utils/styles.dart';
import 'package:wafer/core/widgets/custom_app_bar.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  // ── Controllers ──────────────────────────────────────────────────────────
  final _usernameController = TextEditingController(text: 'مصر الخير_011');
  final _orgNameController = TextEditingController(text: 'جمعية مصر الخير');
  final _phoneController = TextEditingController(text: '012 7654 3210');
  final _emailController = TextEditingController(text: 'example@gmail.com');
  final _descriptionController = TextEditingController(
    text:
        'أنشئت مؤسسة مصر الخير عام 2007 بهدف الاستمرار لأكثر من '
        '500 عام وذلك بالاستناد على هيكل مؤسسي لا يعتمد على الأشخاص بل على '
        'العمل المؤسسي، حيث تعمل بأحدث منهجيات العمل المؤسسي السنوي والحوكمة من '
        'أجل تنمية الإنسان في خمس مجالات أساسية (التكافل الاجتماعي، التعليم والصحة '
        'والبحث العلمي ومبادئ الحياة). تحت مظلة واحدة هي مؤسسة مصر الخير وتعتبر '
        'مؤسسة مصر الخير مؤسسة أهلية غير هادفة للربح مشهرة تحت رقم 555 لعام 2007 '
        'طبقاً لأحكام القانون رقم 84 لسنة 2002 وتهدف إلى خدمة وتطوير ومكاتب المجتمع '
        'المصري من أجل العودة لحياة الكريمة في جميع ربوع مصر',
  );

  // ── Edit-mode flags ───────────────────────────────────────────────────────
  bool _usernameEditing = false;
  bool _orgNameEditing = false;
  bool _phoneEditing = false;
  bool _emailEditing = false;
  bool _descriptionEditing = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _orgNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  // ── Toggle helpers ────────────────────────────────────────────────────────
  void _toggleUsername() =>
      setState(() => _usernameEditing = !_usernameEditing);
  void _toggleOrgName() => setState(() => _orgNameEditing = !_orgNameEditing);
  void _togglePhone() => setState(() => _phoneEditing = !_phoneEditing);
  void _toggleEmail() => setState(() => _emailEditing = !_emailEditing);
  void _toggleDescription() =>
      setState(() => _descriptionEditing = !_descriptionEditing);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── App Bar ──────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: CustomAppBar(
                  title: 'تعديل الملف الشخصي',
                  firstIcon: Icons.search,
                  secondIcon: Icons.notifications_outlined,
                ),
              ),

              // ── Cover / Banner Image ─────────────────────────────────
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 180,
                    color: const Color(0xFFE8F5E9),
                    child: Image.asset(
                      'assets images Profile_Edit masralkheir.png',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: const Color(0xFFEDE7F6),
                          child: const Center(
                            child: Icon(
                              Icons.volunteer_activism,
                              size: 80,
                              color: AppColors.primaryText,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),

              // ── Delete & Edit banner icons ───────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _BannerActionIcon(
                      icon: Icons.edit_outlined,
                      color: AppColors.primaryText,
                      onTap: () {},
                    ),
                    const SizedBox(width: 16),
                    _BannerActionIcon(
                      icon: Icons.delete_outline,
                      color: Colors.red,
                      onTap: () {},
                    ),
                  ],
                ),
              ),

              // ── Profile Fields ───────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // اسم المستخدم
                    _ProfileFieldLabel(label: 'اسم المستخدم'),
                    const SizedBox(height: 6),
                    _ProfileFieldRow(
                      controller: _usernameController,
                      isEditing: _usernameEditing,
                      onEditTap: _toggleUsername,
                    ),
                    const SizedBox(height: 4),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'لا يمكن تغييره إلا بعد 30 يوم',
                        style: Styles.textStyle14.copyWith(
                          color: Colors.grey.shade500,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // اسم الجمعية
                    _ProfileFieldLabel(label: 'اسم الجمعية'),
                    const SizedBox(height: 6),
                    _ProfileFieldRow(
                      controller: _orgNameController,
                      isEditing: _orgNameEditing,
                      onEditTap: _toggleOrgName,
                    ),
                    const SizedBox(height: 16),

                    // رقم الهاتف
                    _ProfileFieldLabel(label: 'رقم الهاتف'),
                    const SizedBox(height: 6),
                    _ProfileFieldRow(
                      controller: _phoneController,
                      isEditing: _phoneEditing,
                      onEditTap: _togglePhone,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 16),

                    // البريد الإلكتروني
                    _ProfileFieldLabel(label: 'البـريـد الإلكـتـرونـي'),
                    const SizedBox(height: 6),
                    _ProfileFieldRow(
                      controller: _emailController,
                      isEditing: _emailEditing,
                      onEditTap: _toggleEmail,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 20),

                    // ── Address (non-editable) ──────────────────────────
                    _ProfileFieldLabel(label: 'العنوان'),
                    const SizedBox(height: 4),
                    _ProfileFieldRow(
                      controller: TextEditingController(
                        text: 'التجمع الخامس - القاهرة',
                      ),
                      isEditing: false,
                      onEditTap: null,
                    ),
                    const SizedBox(height: 4),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'لا يمكن تعديله',
                        style: Styles.textStyle14.copyWith(
                          color: Colors.grey.shade500,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // ── Organization Description ─────────────────────────
                    _ProfileFieldLabel(label: 'وصف الجمعية الخيرية'),
                    const SizedBox(height: 10),
                    _DescriptionBox(
                      controller: _descriptionController,
                      isEditing: _descriptionEditing,
                      onEditTap: _toggleDescription,
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Helper Widgets
// ─────────────────────────────────────────────────────────────────────────────

/// Icon button shown below the banner (edit / delete).
class _BannerActionIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _BannerActionIcon({
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          // ignore: deprecated_member_use
          color: color.withOpacity(0.08),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 22),
      ),
    );
  }
}

/// Section label shown above each field.
class _ProfileFieldLabel extends StatelessWidget {
  final String label;

  const _ProfileFieldLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        label,
        style: Styles.textStyle18.copyWith(fontWeight: FontWeight.bold),
        textAlign: TextAlign.right,
      ),
    );
  }
}

/// A display/edit row for profile data with an edit icon on the left.
/// When [isEditing] is true the field becomes an active [TextField].
/// When [onEditTap] is null the edit icon is hidden (address field).
class _ProfileFieldRow extends StatelessWidget {
  final TextEditingController controller;
  final bool isEditing;
  final VoidCallback? onEditTap;
  final TextInputType keyboardType;

  const _ProfileFieldRow({
    required this.controller,
    required this.isEditing,
    this.onEditTap,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (onEditTap != null) ...[
          // Edit / Done icon on the left
          GestureDetector(
            onTap: onEditTap,
            child: Icon(
              isEditing ? Icons.check_circle_outline : Icons.edit_outlined,
              size: 20,
              color: isEditing ? AppColors.primaryText : Colors.grey.shade600,
            ),
          ),
          const SizedBox(width: 8),
        ],
        // Field box
        Expanded(
          child: Container(
            height: 52,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isEditing ? AppColors.primaryText : Colors.grey.shade300,
                width: isEditing ? 1.5 : 1,
              ),
            ),
            alignment: Alignment.centerRight,
            child: TextField(
              controller: controller,
              enabled: isEditing,
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              keyboardType: keyboardType,
              style: Styles.textStyle16.copyWith(color: AppColors.tertiaryText),
              decoration: const InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Description text box for the organization.
/// Becomes editable when [isEditing] is true.
class _DescriptionBox extends StatelessWidget {
  final TextEditingController controller;
  final bool isEditing;
  final VoidCallback onEditTap;

  const _DescriptionBox({
    required this.controller,
    required this.isEditing,
    required this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isEditing ? AppColors.primaryText : Colors.grey.shade300,
              width: isEditing ? 1.5 : 1,
            ),
            boxShadow: [
              BoxShadow(
                // ignore: deprecated_member_use
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            enabled: isEditing,
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
            maxLines: null,
            style: Styles.textStyle14.copyWith(
              color: AppColors.tertiaryText,
              height: 1.7,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
        // Edit / Done icon pinned to top-left corner
        Positioned(
          top: 8,
          left: 8,
          child: GestureDetector(
            onTap: onEditTap,
            child: Icon(
              isEditing ? Icons.check_circle_outline : Icons.edit_outlined,
              size: 20,
              color: isEditing ? AppColors.primaryText : Colors.grey.shade600,
            ),
          ),
        ),
      ],
    );
  }
}
