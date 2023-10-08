import 'package:flutter/material.dart';
import '../models/carousel_list_model.dart';
import '../models/rental_vehicle_info_model.dart';
import '../utils/colors.dart';
import '../utils/dimen.dart';
import 'carousel_slider.dart';

class RentingScreenHeader extends StatelessWidget {
  final RentalVehicleInfo rentalVehicleInfo;

  const RentingScreenHeader({super.key, required this.rentalVehicleInfo});

  @override
  Widget build(BuildContext context) {

    List<CarouselListModel> imgList = [];
    for(String url in rentalVehicleInfo.imgUrl!) {
      imgList.add(CarouselListModel(id: "nb", imgUrl: url));
    }

    return Card(
      elevation: Dimen.dim10,
      // surfaceTintColor: MyColors.xFFFFFFFF,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimen.dim10)
      ),
      margin: const EdgeInsets.symmetric(vertical: Dimen.dim5, horizontal: Dimen.dim10),
      child: Padding(
        padding: const EdgeInsets.all(Dimen.dim10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: Dimen.dim80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimen.dim10)
              ),
              clipBehavior: Clip.hardEdge,
              child: CarouselSliderView(
                  data: imgList,
                  autoPlay: false
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimen.dim10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      rentalVehicleInfo.title!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      softWrap: true,
                    ),

                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(Icons.location_pin,size: Dimen.dim18, color: MyColors.xFF08BB0E),

                        Text(
                            rentalVehicleInfo.city!,
                            style: const TextStyle(
                                color: MyColors.xFF08BB0E,
                                fontWeight: FontWeight.bold
                            )
                        ),
                      ],
                    )
                  ]
              ),
            ),
          ]
        ),
      ),
    );
  }
}

