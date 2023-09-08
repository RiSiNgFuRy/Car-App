import 'package:car_app/models/vehicle_info_model.dart';
import 'package:car_app/utils/routes/route_name.dart';
import 'package:car_app/views/main_screen.dart';
import 'package:car_app/views/vehicle_renting_screen.dart';
import 'package:flutter/material.dart';

import '../../models/rental_vehicle_info_model.dart';
import '../dimen.dart';

class Routes {

  static Route<dynamic> generateRoute(RouteSettings settings) {

    final args = settings.arguments != null ? settings.arguments as Map<String, dynamic> : {"data": null};

    switch(settings.name) {
      case RoutesName.main:
        return MaterialPageRoute(builder: (BuildContext context) => const MainScreen());
      case RoutesName.vehicleRenting:
        return MaterialPageRoute(builder: (BuildContext context) => VehicleRentingScreen(rentalVehicleInfo: args["model"],));
      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text("No Route Defined", style: TextStyle(
                fontSize: Dimen.dim40,
                fontWeight: FontWeight.bold
              ),),
            ),
          );
        });
    }
  }
}