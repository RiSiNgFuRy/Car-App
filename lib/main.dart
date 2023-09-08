import 'package:car_app/utils/colors.dart';
import 'package:car_app/utils/routes/route.dart';
import 'package:car_app/utils/routes/route_name.dart';
import 'package:car_app/view_models/home_page_provider.dart';
import 'package:car_app/view_models/main_provider.dart';
import 'package:car_app/view_models/rental_page_provider.dart';
import 'package:car_app/view_models/renting_screen_provider.dart';
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
        ChangeNotifierProvider(create: (_) => RentalScreenProvider()),
        ChangeNotifierProvider(create: (_) => RentingScreenProvider())
      ],
      child: MaterialApp(
        title: 'ShowRoom',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: MyColors.xFF08BB0E)
        ),
        initialRoute: RoutesName.main,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }

}

