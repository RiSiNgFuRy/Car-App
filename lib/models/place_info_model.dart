import 'package:car_app/models/base_model.dart';
import 'package:car_app/utils/constants.dart';

class PlaceInfoModel extends BaseModel {
  String? id;
  String? title;
  String? imgUrl;

  PlaceInfoModel({this.id, this.title, this.imgUrl});

  PlaceInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    imgUrl = json['imgUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['imgUrl'] = imgUrl;
    return data;
  }

  @override
  int getModelValue() {
    return Constants.PLACES_INFO_MODEL;
  }
}