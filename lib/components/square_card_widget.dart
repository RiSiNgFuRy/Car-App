import 'dart:ui';

import 'package:car_app/utils/colors.dart';
import 'package:car_app/utils/helpers/ImageHelper.dart';
import 'package:flutter/material.dart';

import '../utils/dimen.dart';

class SquareCardWidget extends StatelessWidget {
  String? imgUrl;
  String? title;
  double? side;

  SquareCardWidget({super.key, this.side, required this.imgUrl, this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: MyColors.xFFFFFFFF,
      elevation: Dimen.dim5,
      clipBehavior: Clip.hardEdge,
      child: Column (
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(Dimen.dim5),
              child: ImageHelper.network(
                imgUrl,
                xWidth: side ?? double.infinity,
                xHeight: side ?? double.infinity
              ),
            ),
          ),
          const SizedBox(height: Dimen.dim5),
          if(title != null)
          Container(
            width: double.maxFinite,
            height: Dimen.dim40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: MyColors.xFF000000,
              borderRadius: BorderRadius.circular(Dimen.dim5)
            ),
            child: Text(
              title!.toUpperCase(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle (
                color: MyColors.xFFFFFFFF,
                fontSize: Dimen.dim12,
                fontWeight: FontWeight.bold,
                height: 1
              ),
            ),
          )
        ]
      ),
    );
  }
}
