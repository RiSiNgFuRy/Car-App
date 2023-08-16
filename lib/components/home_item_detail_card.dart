import 'package:car_app/utils/helpers/ImageHelper.dart';
import 'package:car_app/utils/strings.dart';
import 'package:flutter/material.dart';
import '../models/features_info_model.dart';
import '../utils/dimen.dart';

class ItemDetailCard extends StatelessWidget {
  final Features model;
  final List<ItemWithIconModel> list = [];

  ItemDetailCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    configureData(model);

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      childAspectRatio: 4,
      padding: const EdgeInsets.all(Dimen.dim2),
      physics: const NeverScrollableScrollPhysics(),
      children: [
        for(var item in list)
         Row(
           children: [
             Container(
               padding: const EdgeInsets.symmetric(horizontal: Dimen.dim5),
               child: ImageHelper.assets(
                 item.iconPath,
                 xWidth: Dimen.dim20,
                 xHeight: Dimen.dim20
               )
             ),
             Expanded(
               child: Text(
                 item.data,
                 style: const TextStyle(
                   fontSize: Dimen.dim10,
                   fontWeight: FontWeight.bold,
                   overflow: TextOverflow.fade
                 ),
                 maxLines: 2,
                 softWrap: true,
               ),
             )
           ],
         )
      ]
    );
  }

  void configureData(Features model) {
    if(model.type != null) {
      list.add(ItemWithIconModel(iconPath: Strings.motorbikeAssetPath, data: model.type.toString()));
    }
    if(model.brakes != null) {
      list.add(ItemWithIconModel(iconPath: Strings.discBrakeAssetPath , data: model.brakes.toString()));
    }
    if(model.engine != null) {
      list.add(ItemWithIconModel(iconPath: Strings.engineAssetPath, data: model.engine.toString()));
    }
    if(model.material != null) {
      list.add(ItemWithIconModel(iconPath: Strings.materialAssetPath, data: model.material.toString()));
    }
    if(model.mileage != null) {
      list.add(ItemWithIconModel(iconPath: Strings.mileageAssetPath, data: model.mileage.toString()));
    }
    if(model.topSpeed != null) {
      list.add(ItemWithIconModel(iconPath: Strings.topSpeedAssetPath, data: model.topSpeed.toString()));
    }
  }
}

class ItemWithIconModel {
  String iconPath;
  String data;
  ItemWithIconModel({required this.iconPath, required this.data});
}