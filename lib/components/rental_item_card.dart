import 'package:car_app/components/carousel_slider.dart';
import 'package:car_app/models/carousel_list_model.dart';
import 'package:car_app/utils/colors.dart';
import 'package:flutter/material.dart';
import '../models/features_info_model.dart';
import '../models/rental_vehicle_info_model.dart';
import '../utils/dimen.dart';

class RentalItemCard extends StatelessWidget {
  final RentalVehicleInfo rentalVehicleInfo;

  const RentalItemCard({super.key, required this.rentalVehicleInfo});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Card(
      elevation: Dimen.dim5,
      surfaceTintColor: MyColors.xFFFFFFFF,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimen.dim10),
      ),
      clipBehavior: Clip.hardEdge,
      child: mediaQuery.size.width < 600 ?
      Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: contentArea(context, mediaQuery)
      ) :
      FittedBox(
        child: SizedBox(
          height: Dimen.dim140,
          child: Row(
            children: contentArea(context, mediaQuery),
          ),
        ),
      )
    );
  }

  contentArea(context, MediaQueryData mediaQuery) {

    List<CarouselListModel> imgList = [];
    for(String url in rentalVehicleInfo.imgUrl!) {
      imgList.add(CarouselListModel(id: "nb", imgUrl: url));
    }

    return <Widget> [
      CarouselSliderView(
        data: imgList,
        autoPlay: false
      ),

      const SizedBox(height: Dimen.dim10),

      Container(
        width: mediaQuery.size.width > 600 ? Dimen.dim350 : null,
        padding: const EdgeInsets.all(Dimen.dim10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              rentalVehicleInfo.title!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Dimen.dim18,
              ),
              softWrap: true,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            Text(
              getFeatures(rentalVehicleInfo.features)!,
              style: const TextStyle(
                color: MyColors.xFFFF9200,
              ),
            ),

            const SizedBox(height: Dimen.dim5,),

            mediaQuery.size.width > 600 ?
            Expanded(
              child: _availablityInfo(context, mediaQuery)
            ) : _availablityInfo(context, mediaQuery),
          ]
        ),
      )
    ];
  }

  _availablityInfo(context, MediaQueryData mediaQuery) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          "Available by ${rentalVehicleInfo.availableFrom!}",
          style: const TextStyle(
            fontSize: Dimen.dim10,
          ),
        ),

        Row(
          children: [
            Expanded(
              child: Text(
                  "\u20B9 ${rentalVehicleInfo.hourlyRate!}/hr",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Dimen.dim18
                  )
              ),
            ),

            const Icon(Icons.location_pin, color: MyColors.xFF08BB0E),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimen.dim10),
              child: Text(
                  rentalVehicleInfo.city!,
                  style: const TextStyle(
                      color: MyColors.xFF08BB0E,
                      fontSize: Dimen.dim18,
                      fontWeight: FontWeight.bold
                  )
              ),
            ),
          ],
        )
      ],
    );
  }


  String? getFeatures(Features? features) {
    String requiredString = "";

    if(features != null) {
      if(features.type != null) {
        requiredString += "${features.type!} \u2022 ";
      }

      if(features.brakes != null) {
        requiredString += "${features.brakes!} \u2022 ";
      }

      if(features.mileage != null) {
        requiredString += "${features.mileage!} \u2022 ";
      }

      if(features.numberOfSeats != null) {
        requiredString += "${features.numberOfSeats!} \u2022 ";
      }

      if(features.topSpeed != null) {
        requiredString += "${features.topSpeed!} \u2022 ";
      }

      if(features.material != null) {
        requiredString += "${features.material!} \u2022 ";
      }

      return requiredString.substring(0, requiredString.length-3);
    }
  }
}
