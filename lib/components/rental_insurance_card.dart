import 'package:car_app/models/insurance_model.dart';
import 'package:car_app/utils/colors.dart';
import 'package:car_app/utils/strings.dart';
import 'package:flutter/material.dart';
import '../utils/dimen.dart';

class RentalInsuranceCard extends StatelessWidget {
  final InsuranceModel insuranceModel;
  final String selectedItem;

  const RentalInsuranceCard({
    super.key,
    required this.selectedItem,
    required this.insuranceModel,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = selectedItem == insuranceModel.id;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimen.dim20),
        // color: MyColors.xFFC2E5C4,
        border: Border.all(
          width: isSelected ? Dimen.dim4 : Dimen.dim2,
          color: isSelected ? MyColors.xFF08BB0E : MyColors.xFFC2E5C4
        )
      ),
      padding: const EdgeInsets.all(Dimen.dim20),
      margin: const EdgeInsets.only(bottom: Dimen.dim10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: insuranceModel.title != null,
            maintainSize: true,
            maintainState: true,
            maintainAnimation: true,
            child: RichText(
              text: TextSpan(
                text: "${insuranceModel.title} ",
                style: const TextStyle(
                  fontSize: Dimen.dim18,
                  fontWeight: FontWeight.bold,
                  color: MyColors.xFF000000
                ),
                children: [
                  TextSpan(
                    text: "(${Strings.rupeeSymbol}${insuranceModel.price})",
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                    )
                  )
                ]
              ),
            )
          ),
          Visibility(
            visible: insuranceModel.subTitle != null,
            maintainSize: true,
            maintainState: true,
            maintainAnimation: true,
            child: Text(insuranceModel.subTitle!, style: const TextStyle(
                color: MyColors.xFF6B6A6A
            ),),
          ),
        ],
      ),
    );
  }
}
