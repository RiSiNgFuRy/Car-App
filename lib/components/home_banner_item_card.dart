
import 'dart:math';
import 'package:car_app/components/home_item_detail_card.dart';
import 'package:car_app/models/vehicle_info_model.dart';
import 'package:car_app/utils/colors.dart';
import 'package:car_app/utils/helpers/ImageHelper.dart';
import 'package:car_app/utils/strings.dart';
import 'package:car_app/view_models/home_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import '../utils/dimen.dart';

class HomeBannerItemCard extends StatefulWidget {

  List<VehicleInfoModel> vehicleInfoList;

  HomeBannerItemCard({super.key, required this.vehicleInfoList});

  @override
  State<HomeBannerItemCard> createState() => _HomeBannerItemCardState();
}

class _HomeBannerItemCardState extends State<HomeBannerItemCard> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Stack(
      children: [
        Positioned(
          bottom: 0,
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: Dimen.dim350, maxHeight: Dimen.dim300),
                  child: Container(
                    width: mediaQuery.size.width * 0.55,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: SweepGradient(
                        colors: [
                          Colors.green.shade300,
                          Colors.blue.shade400,
                          Colors.blue.shade800,
                          Colors.green.shade600,
                          Colors.green.shade200
                      ],
                        tileMode: TileMode.mirror
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: MyColors.xFF000000,
                          blurRadius: Dimen.dim10,
                          blurStyle: BlurStyle.inner,
                          offset: Offset(0,30)
                        ),
                        BoxShadow(
                            color: MyColors.xFFFFFFFF,
                            blurRadius: Dimen.dim10,
                            blurStyle: BlurStyle.outer,
                            offset: Offset(4,30)
                        )
                      ]
                    ),
                    transform: Matrix4.identity()..rotateX(pi/2.3),
                    transformAlignment: Alignment.bottomCenter,
                  ),
                ),
              ),

              Consumer<HomeScreenProvider>(
                builder: (BuildContext context, value, Widget? child) {
                  return ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: Dimen.dim350, maxHeight: Dimen.dim220),
                      child: ImageHelper.assets(
                          widget.vehicleInfoList[value.currentIndex].imageUrl,
                          xWidth: mediaQuery.size.width * 0.55,
                          xHeight: mediaQuery.size.width * 0.4
                      )
                  );
                },
              ),
            ]
          ),
        ),

        Positioned(
          bottom: 0,
          right: 0,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: Dimen.dim190, maxWidth: Dimen.dim250),
            child: Consumer<HomeScreenProvider>(
              builder: (context, value, child) {
                return Column (
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      constraints: const BoxConstraints(minWidth: Dimen.dim210),
                      padding: const EdgeInsets.all(Dimen.dim2),
                      width: mediaQuery.size.width * 0.5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(Dimen.dim10),
                          color: MyColors.xFFC2E5C4.withOpacity(0.9)
                      ),
                      child: ItemDetailCard(model: widget.vehicleInfoList[value.currentIndex].featuresInfo!),
                    ),
                    if(mediaQuery.size.width > 600)
                      Container(
                          padding: const EdgeInsets.symmetric(vertical: Dimen.dim5),
                          child: RichText(
                              text: TextSpan (
                                  text: "${Strings.description} : ",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Dimen.dim10,
                                      color: MyColors.xFF000000
                                  ),
                                  children: [
                                    TextSpan(
                                        text: widget.vehicleInfoList[value.currentIndex].description,
                                        style: const TextStyle(
                                          fontSize: Dimen.dim10,
                                          fontWeight: FontWeight.normal,
                                        )
                                    ),
                                  ]
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis
                          )
                      ),

                     Text(
                        widget.vehicleInfoList[value.currentIndex].name!,
                        style: const TextStyle (
                            fontWeight: FontWeight.bold,
                            fontSize: Dimen.dim20,
                            fontStyle: FontStyle.italic
                        )
                    ),
                    Container(
                      padding: const EdgeInsets.all(Dimen.dim6),
                      decoration: ShapeDecoration (
                          color: MyColors.xFF000000,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(Dimen.dim10)
                          )
                      ),
                      child: const Text("Starting at 2 Lakhs", style: TextStyle(
                        color: MyColors.xFFFFFFFF,
                        fontSize: Dimen.dim14,
                        fontWeight: FontWeight.bold,
                      ),),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
