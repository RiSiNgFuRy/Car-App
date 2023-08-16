import 'package:car_app/views/home_screen.dart';
import 'package:car_app/views/rental_screen.dart';
import 'package:car_app/views/services_screen.dart';
import 'package:flutter/material.dart';

import '../views/account_screen.dart';

class MainProvider extends ChangeNotifier {
   int _selectedIndex = 0;
   int get selectedIndex => _selectedIndex;

   Widget _selectedPage = HomeScreen();
   Widget get selectedPage => _selectedPage;

   void navigate(int index) {
     _selectedIndex = index;
     switch(_selectedIndex) {
       case 0:
         _selectedPage = HomeScreen();
         break;
       case 1:
         _selectedPage = RentalScreen();
         break;
       case 2:
         _selectedPage = const ServicesScreen();
         break;
       case 3:
         _selectedPage = const AccountScreen();
       default:
         throw UnimplementedError("No screen decided for $index index");
     }
     notifyListeners();
   }
}