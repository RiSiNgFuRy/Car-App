import 'package:car_app/models/offer_card_model.dart';
import 'package:car_app/utils/colors.dart';
import 'package:flutter/material.dart';

import '../utils/dimen.dart';

class OffersCard extends StatelessWidget {
  OfferCardModel offerCardModel;
  OffersCard({super.key, required this.offerCardModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: offerCardModel.onTap!(),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimen.dim5),
          border: Border.all(
            color: MyColors.xFF6B6A6A
          )
        ),
        margin: const EdgeInsets.only(left: Dimen.dim10),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(Dimen.dim10),
              child: Icon(offerCardModel.iconData, color: MyColors.xFF000000,)
            ),

            Expanded(
              child: Text(offerCardModel.title.toString().toUpperCase(), style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Dimen.dim14,
                color: MyColors.xFF000000,
                ),
                textAlign: TextAlign.center,
              )
            )
          ],
        ),
      ),
    );
  }
}
