import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RentingScreenProvider extends ChangeNotifier {
  LatLng? _selectedDealerLocation;
  LatLng? get selectedDealerLocation => _selectedDealerLocation;

  int _selectedDealerIndex = 0;
  int get selectedDealerIndex => _selectedDealerIndex;

  final Completer<GoogleMapController> _selectedDealerMapController = Completer<GoogleMapController>();
  Completer<GoogleMapController> get selectedDealerMapController => _selectedDealerMapController;

  int _selectedCategoryOfServiceIdx = 0;
  int get selectedCategoryOfServiceIdx => _selectedCategoryOfServiceIdx;

  String? _selectedInsurancePackage;
  String? get selectedInsurancePackage => _selectedInsurancePackage;

  changeSelectedDealer(LatLng? dealerLatLng, int index) async {
    if(dealerLatLng != null && dealerLatLng != _selectedDealerLocation) {
      _selectedDealerLocation = dealerLatLng;
      _selectedDealerIndex = index;
      final GoogleMapController mapController = await _selectedDealerMapController.future;
      await mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: dealerLatLng
        )
      ));
      notifyListeners();
    }
  }

  changeSelectedCategoryOfService(int newIndex) {
    _selectedCategoryOfServiceIdx = newIndex;
    notifyListeners();
  }

  changeSelectedInsurancePackage(String insurancePackageId) {
    _selectedInsurancePackage = insurancePackageId;
    notifyListeners();
  }
}
