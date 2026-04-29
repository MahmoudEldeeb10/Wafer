import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wafer/core/utils/app_colors.dart';
import 'package:wafer/features/botton_nav_bar/presentation/manager/cubit/bottom_nav_cubit.dart';

import 'package:wafer/features/home/presentation/views/home_view.dart';
import 'package:wafer/features/offers/presentation/views/offers_view.dart';
import 'package:wafer/features/posts/presentation/views/posts_view.dart';
import 'package:wafer/features/profile/presentation/views/profile_view.dart';
import 'package:wafer/features/requests/presentation/views/request_view.dart';

class MainView extends StatelessWidget {
  MainView({super.key});

  final List pages = [
    RequestView(),
    OffersView(),
    PostsView(),
    ProfileView(),
    HomeView(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit, BottomNavState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,

          body: Stack(
            children: [
              pages[state.currentIndex],

              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: BottomNavigationBar(
                      backgroundColor: Colors.white,
                      currentIndex: state.currentIndex,
                      onTap: context.read<BottomNavCubit>().changeTab,

                      showSelectedLabels: false,
                      showUnselectedLabels: false,
                      type: BottomNavigationBarType.fixed,

                      selectedItemColor: AppColors.primaryText,
                      unselectedItemColor: AppColors.tertiaryText,

                      items: const [
                        BottomNavigationBarItem(
                          icon: Icon(Icons.calendar_today),
                          label: '',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.local_offer_outlined),
                          label: '',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.post_add_outlined),
                          label: '',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.person_outline),
                          label: '',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.home_outlined),
                          label: '',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
