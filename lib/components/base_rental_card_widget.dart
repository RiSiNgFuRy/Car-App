import 'package:car_app/utils/colors.dart';
import 'package:flutter/material.dart';

import '../utils/dimen.dart';

class BaseRentalCardWidget extends StatelessWidget {
  final String heading;
  final Widget? child;

  const BaseRentalCardWidget({super.key, required this.heading, this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(
              width: Dimen.dim10,
              child: Divider(
                thickness: Dimen.dim1,
                color: MyColors.xFF6B6A6A.withOpacity(0.8),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(Dimen.dim5),
              child: Text(heading, style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Dimen.dim16,
                color: MyColors.xFF6B6A6A.withOpacity(0.8),
              ),),
            ),
            Expanded(
              child: Divider(
                thickness: Dimen.dim1,
                color: MyColors.xFF6B6A6A.withOpacity(0.8),
              ),
            ),
          ]
        ),

        const SizedBox(height: Dimen.dim10,),

        if(child != null)
          child!
      ],
    );
  }
}
