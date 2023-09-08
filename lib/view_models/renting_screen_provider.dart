import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class RentingScreenProvider extends ChangeNotifier {
  LatLng? _selectedDealerLocation;
  LatLng? get selectedDealerLocation => _selectedDealerLocation;

  int _selectedDealerIndex = 0;
  int get selectedDealerIndex => _selectedDealerIndex;

  final MapController _selectedDealerMapController = MapController();
  MapController get selectedDealerMapController => _selectedDealerMapController;

  int _selectedCategoryOfServiceIdx = 0;
  int get selectedCategoryOfServiceIdx => _selectedCategoryOfServiceIdx;

  String? _selectedInsurancePackage;
  String? get selectedInsurancePackage => _selectedInsurancePackage;

  changeSelectedDealer(LatLng? dealerLatLng, int index) {
    if(dealerLatLng != null && dealerLatLng != _selectedDealerLocation) {
      _selectedDealerLocation = dealerLatLng;
      _selectedDealerIndex = index;
      _selectedDealerMapController.move(_selectedDealerLocation!, selectedDealerMapController.zoom);
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
