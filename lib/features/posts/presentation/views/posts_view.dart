import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wafer/core/utils/app_colors.dart';
import 'package:wafer/core/utils/styles.dart';
import 'package:wafer/core/widgets/custom_app_bar.dart';
import 'package:wafer/features/posts/presentation/manager/posts_cubit/posts_cubit.dart';
import 'package:wafer/features/posts/presentation/manager/posts_cubit/posts_state.dart';
import 'package:wafer/features/posts/presentation/views/widgets/add_post_shhet.dart';
import 'package:wafer/features/posts/presentation/views/widgets/custom_card.dart';

class PostsView extends StatefulWidget {
  const PostsView({super.key});

  @override
  State<PostsView> createState() => _PostsViewState();
}

class _PostsViewState extends State<PostsView> {
  int _role = -1;
  int? _selectedStatus;
  late PostsCubit _postsCubit;

  @override
  void initState() {
    super.initState();
    _postsCubit = PostsCubit(role: -1);
    _loadRoleAndFetch();
  }

  Future<void> _loadRoleAndFetch() async {
    final prefs = await SharedPreferences.getInstance();
    final role = prefs.getInt('accountType') ?? -1;
    setState(() => _role = role);
    _postsCubit.updateRole(role);
    _postsCubit.getPosts();
  }

  String _getCategoryName(int category) {
    if (_role == 1) {
      const names = {0: 'غذاء', 1: 'ملابس', 2: 'طبي', 3: 'تعليم', 4: 'أخرى'};
      return names[category] ?? 'أخرى';
    }
    const names = {0: 'مواد غذائية', 1: 'ملابس', 2: 'أدوية', 3: 'أثاث'};
    return names[category] ?? 'أخرى';
  }

  void _openAddSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => AddPostSheet(role: _role),
    );
  }

  @override
  void dispose() {
    _postsCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _postsCubit,
      child: Scaffold(
        backgroundColor: AppColors.fourthText,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Builder(
                    builder: (context) => CustomAppBar(
                      title: 'المنشورات !',
                      firstIcon: Icons.add,
                      secondIcon: Icons.notifications_none,
                      onFirstIconTap: () => _openAddSheet(context),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Text(
                        'عرض المنشورات :',
                        style: Styles.textStyle16.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      BlocBuilder<PostsCubit, PostsState>(
                        builder: (context, state) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: DropdownButton<int?>(
                              value: _selectedStatus,
                              underline: const SizedBox(),
                              style: Styles.textStyle14,
                              items: const [
                                DropdownMenuItem(
                                  value: null,
                                  child: Text('جميع المنشورات'),
                                ),
                                DropdownMenuItem(
                                  value: 0,
                                  child: Text('قيد المراجعة'),
                                ),
                                DropdownMenuItem(
                                  value: 1,
                                  child: Text('مقبولة'),
                                ),
                                DropdownMenuItem(
                                  value: 2,
                                  child: Text('مرفوضة'),
                                ),
                                DropdownMenuItem(
                                  value: 3,
                                  child: Text('مكتملة'),
                                ),
                              ],
                              onChanged: (value) {
                                setState(() => _selectedStatus = value);
                                context.read<PostsCubit>().getPosts(
                                  status: value,
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  BlocConsumer<PostsCubit, PostsState>(
                    listener: (context, state) {
                      if (state is PostsError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.message),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is PostsLoading || state is PostsInitial) {
                        return const Padding(
                          padding: EdgeInsets.only(top: 40),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primaryText,
                            ),
                          ),
                        );
                      }

                      if (state is PostsSuccess) {
                        if (state.posts.isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Center(
                              child: Text(
                                'لا توجد منشورات',
                                style: Styles.textStyle16,
                              ),
                            ),
                          );
                        }

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.posts.length,
                          itemBuilder: (context, index) {
                            final post = state.posts[index];
                            return CustomCard(
                              title: post.charityName ?? post.productName ?? '',
                              category: _getCategoryName(post.category ?? 0),
                              description: post.description ?? '',
                              imagePath: post.imageUrl,
                              time: post.createdAt ?? '',
                              status: post.status,
                            );
                          },
                        );
                      }

                      return const SizedBox();
                    },
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
