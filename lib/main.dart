import 'package:car_app/utils/colors.dart';
import 'package:car_app/view_models/home_screen_provider.dart';
import 'package:car_app/view_models/main_provider.dart';
import 'package:car_app/view_models/rental_screen_provider.dart';
import 'package:car_app/views/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainProvider()),
        ChangeNotifierProvider(create: (_) => HomeScreenProvider()),
        ChangeNotifierProvider(create: (_) => RentalScreenProvider())
      ],
      child: MaterialApp(
        title: 'ShowRoom',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: MyColors.xFF08BB0E)
        ),
        home: const MainScreen(),
      ),
    );
  }

}

