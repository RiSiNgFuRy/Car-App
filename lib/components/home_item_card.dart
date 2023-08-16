import 'package:car_app/utils/colors.dart';
import 'package:car_app/utils/helpers/ImageHelper.dart';
import 'package:flutter/material.dart';
import '../models/vehicle_info_model.dart';
import '../utils/dimen.dart';
import '../utils/strings.dart';

class HomeItemCard extends StatelessWidget {

  VehicleInfoModel vehicleInfoModel;

  HomeItemCard({super.key, required this.vehicleInfoModel});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    
    return Card(
      elevation: Dimen.dim5,
      child: Stack(
        children: [
          Container(
            constraints: const BoxConstraints(maxHeight: Dimen.dim250, minWidth: Dimen.dim165, maxWidth: Dimen.dim200),
            child: ImageHelper.assets(
              vehicleInfoModel.imageUrl,
            ),
          ),
          Container(
            width: mediaQuery.size.width,
            alignment: Alignment.centerRight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimen.dim10),
              image: const DecorationImage(
                image: AssetImage(Strings.itemCardBgAssetPath),
                fit: BoxFit.fill,
              )
            ),
            child: Container(
                constraints: const BoxConstraints(minWidth: Dimen.dim165, maxWidth: Dimen.dim190),
                padding: const EdgeInsets.all(Dimen.dim5),
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    Text(vehicleInfoModel.name!, style: const TextStyle(
                      fontSize: Dimen.dim14,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.fade
                    ),
                      maxLines: 1,
                    ),
                    Text(vehicleInfoModel.brandName!, style: const TextStyle(
                      fontSize: Dimen.dim12
                    ),),
                    const SizedBox(height: Dimen.dim5),
                    const Text("Starting from", style: TextStyle(
                      fontSize: Dimen.dim8,
                      color: MyColors.xFF1D3AF6,
                      fontWeight: FontWeight.bold
                    )),
                    Text("${vehicleInfoModel.costPriceDetails!.currency}"
                        " ${vehicleInfoModel.costPriceDetails!.startingPrice}/-", style: const TextStyle(
                        fontSize: Dimen.dim16,
                        fontWeight: FontWeight.bold
                    ),
                      maxLines: 1,
                    ),
                    const SizedBox(height: Dimen.dim5),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimen.dim5),
                          color: MyColors.xFFFF9200
                        ),
                        padding: const EdgeInsets.all(Dimen.dim5),
                        margin: const EdgeInsets.all(Dimen.dim5),
                        child: const Text("Know More", style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Dimen.dim12,
                          color: MyColors.xFFFFFFFF
                        ),),
                      ),
                    )
                  ],
                )
            ),
          ),
        ],
      ),
    );
  }

}
