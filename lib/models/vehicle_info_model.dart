import 'features_info_model.dart';

class VehicleInfoModel {
  String? id;
  String? name;
  String? brandName;
  String? description;
  String? imageUrl;
  CostPriceDetails? costPriceDetails;
  Features? featuresInfo;

  VehicleInfoModel(
      {this.id,
        this.name,
        this.brandName,
        this.description,
        this.imageUrl,
        this.costPriceDetails,
        this.featuresInfo});

  VehicleInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    brandName = json['brandName'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    costPriceDetails = json['costPriceDetails'] != null
        ? new CostPriceDetails.fromJson(json['costPriceDetails'])
        : null;
    featuresInfo = json['featuresInfo'] != null
        ? new Features.fromJson(json['featuresInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['brandName'] = this.brandName;
    data['description'] = this.description;
    data['imageUrl'] = this.imageUrl;
    if (this.costPriceDetails != null) {
      data['costPriceDetails'] = this.costPriceDetails!.toJson();
    }
    if (this.featuresInfo != null) {
      data['featuresInfo'] = this.featuresInfo!.toJson();
    }
    return data;
  }
}

class CostPriceDetails {
  String? currency;
  int? startingPrice;
  int? endingPrice;

  CostPriceDetails({this.currency, this.startingPrice, this.endingPrice});

  CostPriceDetails.fromJson(Map<String, dynamic> json) {
    currency = json['currency'];
    startingPrice = json['startingPrice'];
    endingPrice = json['endingPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currency'] = this.currency;
    data['startingPrice'] = this.startingPrice;
    data['endingPrice'] = this.endingPrice;
    return data;
  }
}
