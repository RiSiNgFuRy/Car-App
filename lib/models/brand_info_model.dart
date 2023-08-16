class BrandInfoModel {
  String? id;
  String? title;
  String? imgUrl;

  BrandInfoModel({this.id, this.title, this.imgUrl});

  BrandInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    imgUrl = json['imgUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['imgUrl'] = imgUrl;
    return data;
  }
}