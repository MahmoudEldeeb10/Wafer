import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wafer/features/posts/presentation/manager/add_post_cubit/add_post_cubit.dart';
import 'package:wafer/features/posts/presentation/manager/add_post_cubit/add_post_state.dart';

class AddPostSheet extends StatefulWidget {
  final int role; // 0 = charity, 1 = donor

  const AddPostSheet({super.key, required this.role});

  @override
  State<AddPostSheet> createState() => _AddPostSheetState();
}

class _AddPostSheetState extends State<AddPostSheet> {
  final _formKey = GlobalKey<FormState>();
  final _productNameController = TextEditingController();
  final _quantityController = TextEditingController();
  final _descriptionController = TextEditingController();

  int? _selectedCategory;
  int? _selectedUnit;
  int? _selectedPriority;
  File? _productImage;

  List<Map<String, dynamic>> get _categories => widget.role == 1
      ? [
          {'id': 0, 'name': 'غذاء'},
          {'id': 1, 'name': 'ملابس'},
          {'id': 2, 'name': 'طبي'},
          {'id': 3, 'name': 'تعليم'},
          {'id': 4, 'name': 'أخرى'},
        ]
      : [
          {'id': 0, 'name': 'مواد غذائية'},
          {'id': 1, 'name': 'ملابس'},
          {'id': 2, 'name': 'أدوية'},
          {'id': 3, 'name': 'أثاث'},
        ];

  final List<Map<String, dynamic>> _units = [
    {'id': 6, 'name': 'كيلو'},
    {'id': 7, 'name': 'قطعة'},
    {'id': 8, 'name': 'لتر'},
  ];

  final List<Map<String, dynamic>> _priorities = [
    {'id': 1, 'name': 'منخفضة'},
    {'id': 2, 'name': 'متوسطة'},
    {'id': 3, 'name': 'عالية'},
  ];

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => _productImage = File(picked.path));
  }

  void _submit(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedCategory == null ||
        _selectedUnit == null ||
        _selectedPriority == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('يرجى اختيار الفئة والوحدة والأولوية'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    context.read<AddPostCubit>().addPost(
      category: _selectedCategory!,
      productName: _productNameController.text.trim(),
      quantity: double.parse(_quantityController.text.trim()),
      unit: _selectedUnit!,
      priority: _selectedPriority!,
      description: _descriptionController.text.trim(),
      productImage: _productImage,
    );
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _quantityController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // العنوان حسب الـ role
    final sheetTitle = widget.role == 0
        ? 'إضافة احتياج جديد'
        : 'إضافة عرض جديد';
    final buttonLabel = widget.role == 0 ? 'نشر الاحتياج' : 'نشر العرض';

    return BlocProvider(
      create: (_) => AddPostCubit(role: widget.role),
      child: BlocConsumer<AddPostCubit, AddPostState>(
        listener: (context, state) {
          if (state is AddPostError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is AddPostLoading;
          final isSuccess = state is AddPostSuccess;

          return Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 36,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(height: 16),

                        Text(
                          sheetTitle,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 20),

                        _buildDropdown(
                          label: 'الفئة',
                          value: _selectedCategory,
                          items: _categories,
                          onChanged: (v) =>
                              setState(() => _selectedCategory = v),
                        ),
                        const SizedBox(height: 14),

                        _buildTextField(
                          label: 'اسم المنتج',
                          controller: _productNameController,
                          validator: (v) => v!.trim().isEmpty ? 'مطلوب' : null,
                        ),
                        const SizedBox(height: 14),

                        Row(
                          children: [
                            Expanded(
                              child: _buildTextField(
                                label: 'الكمية',
                                controller: _quantityController,
                                keyboardType: TextInputType.number,
                                validator: (v) {
                                  if (v!.trim().isEmpty) return 'مطلوب';
                                  if (double.tryParse(v.trim()) == null) {
                                    return 'أدخل رقماً صحيحاً';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: _buildDropdown(
                                label: 'الوحدة',
                                value: _selectedUnit,
                                items: _units,
                                onChanged: (v) =>
                                    setState(() => _selectedUnit = v),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),

                        _buildDropdown(
                          label: 'الأولوية',
                          value: _selectedPriority,
                          items: _priorities,
                          onChanged: (v) =>
                              setState(() => _selectedPriority = v),
                        ),
                        const SizedBox(height: 14),

                        _buildTextField(
                          label: 'الوصف',
                          controller: _descriptionController,
                          maxLines: 3,
                          validator: (v) => v!.trim().isEmpty ? 'مطلوب' : null,
                        ),
                        const SizedBox(height: 14),

                        GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300]!),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: _productImage != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.file(
                                      _productImage!,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Column(
                                    children: [
                                      Icon(
                                        Icons.add_photo_alternate_outlined,
                                        size: 28,
                                        color: Colors.grey[400],
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        'إضافة صورة (اختياري)',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[500],
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: isLoading || isSuccess
                                ? null
                                : () => _submit(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isSuccess
                                  ? Colors.green.shade600
                                  : const Color(0xFF1D9E75),
                              disabledBackgroundColor: isSuccess
                                  ? Colors.green.shade600
                                  : null,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(
                                    isSuccess
                                        ? '✓ تم النشر بنجاح'
                                        : buttonLabel,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 4),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          validator: validator,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required int? value,
    required List<Map<String, dynamic>> items,
    required ValueChanged<int?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 4),
        DropdownButtonFormField<int>(
          value: value,
          items: items
              .map(
                (e) => DropdownMenuItem<int>(
                  value: e['id'] as int,
                  child: Text(e['name'] as String),
                ),
              )
              .toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
          ),
        ),
      ],
    );
  }
}
