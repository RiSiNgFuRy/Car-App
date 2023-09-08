import 'package:car_app/models/features_info_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../models/rental_vehicle_info_model.dart';

class RentalScreenProvider extends ChangeNotifier {
  List<RentalVehicleInfo> _rentalVehicleInfo = [];
  List<RentalVehicleInfo> get rentalVehicleInfo => _rentalVehicleInfo;

  String? _priceRangeDropDownSelection;
  String? get priceRangeDropDownSelection => _priceRangeDropDownSelection;

  DateTime _currentlySelectedDate = DateTime.now();
  DateTime get currentlySelectedDate => _currentlySelectedDate;

  String? _selectedCity;
  String? get selectedCity => _selectedCity;

  void fetchRentalVehiclesInfo(int page, int limit) {
    _rentalVehicleInfo = [
      RentalVehicleInfo(
        id: "0",
        title: "Hyundai Elite i20 2016",
        imgUrl: [
          "https://i0.wp.com/gomechanic.in/blog/wp-content/uploads/2020/02/2018-Hyundai-Elite-i20-Review-1.jpg?resize=1000%2C500&ssl=1",
          "https://cdni.autocarindia.com/Utils/ImageResizerWM.ashx?n=http%3A%2F%2Fcdni.autocarindia.com%2FReviews%2F20140823115533_203.jpg&c=0",
          "https://img.indianautosblog.com/crop/1200x675/2014/08/Hyundai-Elite-i20-Diesel-Review-side.jpg"
        ],
        distance: null,
        hourlyRate: "200",
        city: "Kanpur",
        features: Features(
          type: "Manual",
          numberOfSeats: "5 seats"
        ),
        availableFrom: DateFormat("dd MMM").format(DateTime.now())
      )
    ];
    notifyListeners();
  }

  void priceRangeSelectionCallback(String? selectedOption) {
    if(selectedOption != null) {
      _priceRangeDropDownSelection = selectedOption;
      notifyListeners();
    }
  }

  void changeSelectedDate(DateTime selectedDate) {
    if(selectedDate != null) {
      _currentlySelectedDate = selectedDate;
      notifyListeners();
    }
  }

  void changeSelectedCity(String? city) {
    _selectedCity = city;
    notifyListeners();
  }
}