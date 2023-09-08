import 'package:car_app/components/base_card_widget.dart';
import 'package:car_app/components/settings_card.dart';
import 'package:car_app/models/offer_card_model.dart';
import 'package:car_app/models/settings_model.dart';
import 'package:car_app/utils/colors.dart';
import 'package:flutter/material.dart';
import '../components/offers_card.dart';
import '../components/rental_booking_card.dart';
import '../utils/dimen.dart';
import '../utils/helpers/ImageHelper.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({super.key});

  var offerCardList = [
    OfferCardModel(
      iconData: Icons.local_offer_rounded,
      title: "coupons",
      onTap: () {}
    ),
    OfferCardModel(
        iconData: Icons.handshake_rounded,
        title: "refer to friend",
        onTap: () {}
    )
  ];

  var settingsCardList = [
    SettingsCardModel(
        iconData: Icons.notifications,
        title: "Notifications",
        onTap: () {}
    ),
    SettingsCardModel(
        iconData: Icons.location_pin,
        title: "Location",
        onTap: () {}
    ),
    SettingsCardModel(
        iconData: Icons.phone_in_talk_rounded,
        title: "Contact Us",
        onTap: () {}
    ),
    SettingsCardModel(
        iconData: Icons.file_copy_rounded,
        title: "Terms and Agreement",
        onTap: () {}
    ),
    SettingsCardModel(
        iconData: Icons.logout_rounded,
        title: "Logout",
        onTap: () {}
    )
  ];

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return SingleChildScrollView(
      primary: true,
      child: Stack(
        children: [
          Container(
            height: mediaQuery.size.width < 600 ? Dimen.dim400 : Dimen.dim300,
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

        const SizedBox(height: Dimen.dim10),
        _offers(context),

        const SizedBox(height: Dimen.dim10),
        _moreOptions(context),
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

          const Padding(
            padding: EdgeInsets.only(
              top: Dimen.dim10,
              bottom: Dimen.dim5,
            ),
            child: Text("John Doe", style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Dimen.dim18,
            ),),
          ),

          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimen.dim5),
              color: MyColors.xFFFFFFFF,
            ),
            clipBehavior: Clip.hardEdge,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  color: MyColors.xFF08BB0E,
                  padding: const EdgeInsets.all(Dimen.dim5),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.wallet, color: MyColors.xFFFFFFFF,),
                      Text("Wallet", style: TextStyle(
                        fontSize: Dimen.dim16,
                        fontWeight: FontWeight.bold,
                        color: MyColors.xFFFFFFFF,
                      ),)
                    ],
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimen.dim5),
                  child: Text("\u20B9 10", style: TextStyle(
                    fontSize: Dimen.dim16,
                    fontWeight: FontWeight.bold,
                  ),),
                ),

                const Icon(Icons.add, color: MyColors.xFF08BB0E, grade: Dimen.dim30,),
                
              ],
            )
          )
        ]
    );
  }

  _bookings(context) {
    return BaseCardWidget(
        "Bookings",
        child: SizedBox(
          height: Dimen.dim180,
          child: ListView.builder(
            itemCount: 1,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return const SizedBox(
                width: Dimen.dim250,
                child: RentalBookingCard()
              );
            }
          ),
        )
    );
  }

  _offers(context) {
    return BaseCardWidget(
        "Offers",
        child: SizedBox(
          height: Dimen.dim50,
          child: ListView.builder(
              itemCount: offerCardList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return SizedBox(
                    width: Dimen.dim200,
                    child: OffersCard(
                      offerCardModel: offerCardList[index],
                    )
                );
              }
          ),
        )
    );
  }

  _moreOptions(context) {
    return Padding(
      padding: const EdgeInsets.only(left: Dimen.dim20, right: Dimen.dim20, top: Dimen.dim30),
      child: GridView.builder(
        itemCount: settingsCardList.length,
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: Dimen.dim130,
            childAspectRatio: 1,
            mainAxisSpacing: Dimen.dim5,
            crossAxisSpacing: Dimen.dim5
        ),
        itemBuilder: (context, index) {
          return SettingsCard (
            settingsCardModel: settingsCardList[index],
          );
        },
      ),
    );
  }

}
