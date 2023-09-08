import 'package:car_app/components/base_card_widget.dart';
import 'package:car_app/components/custom_calendar.dart';
import 'package:car_app/components/rental_item_card.dart';
import 'package:car_app/components/rental_search_bar.dart';
import 'package:car_app/utils/colors.dart';
import 'package:car_app/utils/routes/route_name.dart';
import 'package:car_app/view_models/rental_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/features_info_model.dart';
import '../models/place_info_model.dart';
import '../models/rental_vehicle_info_model.dart';
import '../utils/dimen.dart';

class RentalScreen extends StatefulWidget {
  const RentalScreen({super.key});

  @override
  State<RentalScreen> createState() => _RentalScreenState();
}

class _RentalScreenState extends State<RentalScreen> {
  int _page = 0;
  final List<PlaceInfoModel> placesList = [
    PlaceInfoModel(
      id: "0",
      title: "Kanpur",
      imgUrl: "https://img.freepik.com/free-icon/big-ben_318-381637.jpg"
    ),
    PlaceInfoModel(
      id: "1",
      title: "Delhi",
      imgUrl: "https://cdn-icons-png.flaticon.com/512/3806/3806655.png"
    )
  ];

  final List<RentalVehicleInfo> rentalVehicleInfo =  [
    RentalVehicleInfo(
        id: "0",
        title: "Hyundai Elite i20 2016",
        imgUrl: [
          "https://i0.wp.com/gomechanic.in/blog/wp-content/uploads/2020/02/2018-Hyundai-Elite-i20-Review-1.jpg?resize=1000%2C500&ssl=1",
          "https://cdni.autocarindia.com/Utils/ImageResizerWM.ashx?n=http%3A%2F%2Fcdni.autocarindia.com%2FReviews%2F20140823115533_203.jpg&c=0",
          "https://img.indianautosblog.com/crop/1200x675/2014/08/Hyundai-Elite-i20-Diesel-Review-side.jpg"
        ],
        distance: null,
        hourlyRate: "200",
        city: "Kanpur",
        features: Features(
            type: "Manual",
            numberOfSeats: "5 seats"
        ),
        availableFrom: DateFormat("dd MMMM").format(DateTime.now())
    ),
    RentalVehicleInfo(
        id: "2",
        title: "Hyundai Elite i20 2016",
        imgUrl: [
          "https://i0.wp.com/gomechanic.in/blog/wp-content/uploads/2020/02/2018-Hyundai-Elite-i20-Review-1.jpg?resize=1000%2C500&ssl=1",
          "https://cdni.autocarindia.com/Utils/ImageResizerWM.ashx?n=http%3A%2F%2Fcdni.autocarindia.com%2FReviews%2F20140823115533_203.jpg&c=0",
          "https://img.indianautosblog.com/crop/1200x675/2014/08/Hyundai-Elite-i20-Diesel-Review-side.jpg"
        ],
        distance: null,
        hourlyRate: "200",
        city: "Kanpur",
        features: Features(
            type: "Manual",
            numberOfSeats: "5 seats"
        ),
        availableFrom: DateFormat("dd MMMM").format(DateTime.now())
    )
  ];

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final provider = Provider.of<RentalScreenProvider>(context, listen: false);

    return SingleChildScrollView(
      primary: true,
      child: Container(
        color: MyColors.xFFC2E5C4,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SafeArea(
              bottom: false,
              child: RentalSearchBar(
                placesList: placesList,
                provider: provider,
              )
            ),
            Container(
              width: mediaQuery.size.width,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Dimen.dim40),
                  topLeft: Radius.circular(Dimen.dim40)
                ),
                color: MyColors.xFFFFFFFF
              ),
              child: contentArea(context, provider),
            ),
          ],
        ),
      ),
    );
  }

  contentArea(context, provider) {
    final mediaQuery = MediaQuery.of(context);
    final priceRangeFocusNode = FocusNode();
    // final dealsListScrollController = ScrollController();
    //
    // dealsListScrollController.addListener(_loadMoreData(dealsListScrollController, provider));

    @override
    void dispose() {
      priceRangeFocusNode.dispose();
      super.dispose();
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: Dimen.dim100,
          margin: const EdgeInsets.symmetric(vertical: Dimen.dim20),
          padding: const EdgeInsets.symmetric(vertical: Dimen.dim2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimen.dim10),
            border: Border.all(
              color: MyColors.xFF6B6A6A,
            ),
            color: MyColors.xFF6B6A6A.withOpacity(0.7)
          ),
        ),

        Flexible(
          child: BaseCardWidget(
            "Top Deals",
            topRightmostArea: SizedBox(
              width: Dimen.dim150,
              child: Consumer<RentalScreenProvider>(
                builder: (context, value, child) {
                  return DropdownButtonHideUnderline(
                    child: DropdownButtonFormField(
                      value: value.priceRangeDropDownSelection,
                      menuMaxHeight: Dimen.dim200,
                      isExpanded: true,
                      focusNode: priceRangeFocusNode,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Price Range")
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: "\u20B9200 - \u20B9300",
                          child: Text("\u20B9200 - \u20B9300"),
                        ),
                        DropdownMenuItem(
                          value: "\u20B9300 - \u20B9400"     ,
                          child: Text("\u20B9300 - \u20B9400")
                        ),
                      ],
                      onChanged: (value) {
                        priceRangeFocusNode.unfocus();
                        provider.priceRangeSelectionCallback(value);
                      }
                    ),
                  );
                },
              )
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimen.dim10),
              child: Consumer<RentalScreenProvider>(
                builder: (context, value, child) {
                  return ListView.builder(
                      itemCount: rentalVehicleInfo.length,
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(vertical: Dimen.dim1),
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                             Navigator.pushNamed(context, RoutesName.vehicleRenting, arguments: { "model": rentalVehicleInfo[index] });
                          },
                          child: RentalItemCard(rentalVehicleInfo: rentalVehicleInfo[index])
                        );
                      }
                  );
                },
              ),
            )
          ),
        )
      ],
    );
  }

  // _loadMoreData(ScrollController scrollController, RentalScreenProvider provider) {
  //   if(scrollController.position.pixels == scrollController.position.maxScrollExtent) {
  //     provider.fetchRentalVehiclesInfo(_page++, 10);
  //   }
  // }
}

