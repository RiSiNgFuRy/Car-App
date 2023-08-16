import 'package:car_app/components/base_card_widget.dart';
import 'package:car_app/utils/colors.dart';
import 'package:flutter/material.dart';
import '../components/rental_booking_card.dart';
import '../utils/dimen.dart';
import '../utils/helpers/ImageHelper.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return SingleChildScrollView(
      primary: true,
      child: Stack(
        children: [
          Container(
            height: mediaQuery.size.height * 0.4,
            color: MyColors.xFFC2E5C4,
          ),

          SafeArea(
            child: SizedBox(
              width: mediaQuery.size.width,
              child: _contentArea(context),
            ),
          )
        ],
      )
    );
  }

  _contentArea(context) {

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(Dimen.dim10),
          child: _profileHeader(context)
        ),

        _bookings(context),
      ],
    );
  }

  _profileHeader(context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                alignment: Alignment.center,
                width: Dimen.dim100,
                height: Dimen.dim100,
                margin: const EdgeInsets.all(Dimen.dim8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimen.dim300),
                    border: Border.all(
                        width: Dimen.dim5,
                        strokeAlign: BorderSide.strokeAlignOutside,
                        color: MyColors.xFF08BB0E
                    )
                ),
                clipBehavior: Clip.hardEdge,
                child: ImageHelper.network(
                  "cjsn/sn",
                ),
              ),

              Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: Dimen.dim30,
                    height: Dimen.dim30,
                    decoration: BoxDecoration(
                      color: MyColors.xFFFF9200,
                      borderRadius: BorderRadius.circular(Dimen.dim35),
                    ),
                    child: const Icon(Icons.edit, size: Dimen.dim18, color: MyColors.xFFFFFFFF),
                  )
              )
            ],
          ),
          const SizedBox(height: Dimen.dim10,),
          const Text("John Doe", style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Dimen.dim18,
          ),)
        ]
    );
  }

  _bookings(context) {
    return BaseCardWidget(
        "Bookings",
        child: SizedBox(
          height: Dimen.dim200,
          child: ListView.builder(
            itemCount: 1,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return const RentalBookingCard();
            }
          ),
        )
    );
  }

}
