import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wafer/features/botton_nav_bar/presentation/manager/cubit/bottom_nav_cubit.dart';
import 'package:wafer/features/botton_nav_bar/presentation/views/main_view.dart';

void main() {
  runApp(const Wafer());
}

class Wafer extends StatelessWidget {
  const Wafer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavCubit(),
      child: MaterialApp(home: MainView()),
    );
  }
}
