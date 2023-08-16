
class CarouselListModel {
  String? id;
  String? imgUrl;

  CarouselListModel({required this.id, required this.imgUrl});

  CarouselListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imgUrl = json['imgUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['imgUrl'] = imgUrl;
    return data;
  }
}