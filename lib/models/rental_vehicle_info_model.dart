import 'features_info_model.dart';

class RentalVehicleInfo {
  String? id;
  String? title;
  List<String>? imgUrl;
  String? distance;
  String? hourlyRate;
  String? city;
  Features? features;
  String? availableFrom;

  RentalVehicleInfo(
      {this.id,
        this.title,
        this.imgUrl,
        this.distance,
        this.hourlyRate,
        this.city,
        this.features,
        this.availableFrom});

  RentalVehicleInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    imgUrl = json['imgUrl'].cast<String>();
    distance = json['distance'];
    hourlyRate = json['hourlyRate'];
    city = json['city'];
    features = json['features'] != null
        ? new Features.fromJson(json['features'])
        : null;
    availableFrom = json['availableFrom'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['imgUrl'] = this.imgUrl;
    data['distance'] = this.distance;
    data['hourlyRate'] = this.hourlyRate;
    data['city'] = this.city;
    if (this.features != null) {
      data['features'] = this.features!.toJson();
    }
    data['availableFrom'] = this.availableFrom;
    return data;
  }
}
