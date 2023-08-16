import 'package:car_app/utils/colors.dart';
import 'package:flutter/material.dart';

import '../utils/dimen.dart';
import '../utils/helpers/ImageHelper.dart';

class RentalBookingCard extends StatelessWidget {
  const RentalBookingCard({super.key});

  @override
  Widget build(BuildContext context) {
    var tagColor = _getTagColor(Tags.PICK_UP);

    return Card(
      elevation: Dimen.dim10,
      surfaceTintColor: MyColors.xFFFFFFFF,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimen.dim40),
          topRight: Radius.circular(Dimen.dim10),
          bottomLeft: Radius.circular(Dimen.dim10),
          bottomRight: Radius.circular(Dimen.dim40),
        )
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                width: Dimen.dim250,
                height: Dimen.dim120,
                child: ImageHelper.network(
                  "ngidf",
                ),
              ),

              Positioned(
                top: Dimen.dim5,
                right: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    color: MyColors.xFF08BB0E,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: Dimen.dim10, vertical: Dimen.dim2),
                  child: const Text("Booked for 22 Aug, 2023",style: TextStyle(
                      color: MyColors.xFFFFFFFF,
                    fontWeight: FontWeight.bold,
                    fontSize: Dimen.dim12
                  ),),
                ),
              )
            ]
          ),

          Padding(
            padding: const EdgeInsets.all(Dimen.dim5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const Text("Car Name", style: TextStyle(
                  fontSize: Dimen.dim18,
                  fontWeight: FontWeight.bold
                ),),

                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimen.dim5),
                        border: Border.all(
                          width: 2,
                          color: tagColor
                        )
                      ),
                      padding: const EdgeInsets.all(Dimen.dim5),
                      child: Text("PICKUP", style: TextStyle(
                        fontSize: Dimen.dim10,
                        fontWeight: FontWeight.bold,
                        color: tagColor
                      ),),
                    ),

                    const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.location_pin, color: MyColors.xFF08BB0E),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: Dimen.dim10),
                          child: Text(
                              "Kanpur",
                              style: TextStyle(
                                  color: MyColors.xFF08BB0E,
                                  fontSize: Dimen.dim18,
                                  fontWeight: FontWeight.bold
                              )
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ]
            ),
          )
        ],
      ),
    );
  }

  _getTagColor(Tags tagType) {
    switch(tagType) {
      case Tags.PICK_UP:
        return MyColors.xFFF7FF00;
        break;
      case Tags.ARRIVE:
        return MyColors.xFF08BB0E;
        break;
      default:
        return MyColors.xFF000000;
    }
  }
}

enum Tags {
  PICK_UP,
  ARRIVE
}
