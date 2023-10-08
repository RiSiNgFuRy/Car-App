import 'package:car_app/components/arrow_slider.dart';
import 'package:car_app/components/base_card_widget.dart';
import 'package:car_app/components/home_banner_item_card.dart';
import 'package:car_app/components/square_card_widget.dart';
import 'package:car_app/models/brand_info_model.dart';
import 'package:car_app/utils/colors.dart';
import 'package:flutter/material.dart';
import '../components/carousel_slider.dart';
import '../components/home_item_card.dart';
import '../models/carousel_list_model.dart';
import '../models/features_info_model.dart';
import '../models/vehicle_info_model.dart';
import '../utils/dimen.dart';
import '../utils/strings.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  List<CarouselListModel> carouselList = [
    CarouselListModel(id: "0", imgUrl: "https://bull-leds.in/wp-content/uploads/2017/05/Bike-Shed-Paris-Poster-TICKETPAGE.jpg"),
    CarouselListModel(id: "1", imgUrl: "https://img.freepik.com/premium-vector/vintage-cafe-racer-poster_1415-708.jpg"),
    CarouselListModel(id: "2", imgUrl: "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/car-rent-design-template-64ff332fd3dda524f0892559080bb95a_screen.jpg?ts=1620865657")
  ];

  List<BrandInfoModel> brandsList = [
    BrandInfoModel(id: "0", title: "Hero", imgUrl: "https://www.vhv.rs/file/max/14/145035_bike-logo-png.png"),
    BrandInfoModel(id: "1", title: "Honda", imgUrl: "https://www.freepnglogos.com/uploads/honda-logo-png/honda-motorcycle-and-scooter-india-wing-13.png"),
    BrandInfoModel(id: "2", title: "Royal Enfield", imgUrl: "https://listcarbrands.com/wp-content/uploads/2022/12/Royal-Enfield-Emblem.png"),
    BrandInfoModel(id: "3", title: "Ducati", imgUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/6/66/Ducati_red_logo.PNG/723px-Ducati_red_logo.PNG"),
    BrandInfoModel(id: "4", title: "Harley Davidson", imgUrl: "https://www.freepnglogos.com/uploads/harley-davidson-png-logo/harley-davidson-png-logo-0.png")
  ];

  List<VehicleInfoModel> vehicleList = [
    VehicleInfoModel(
      id: "1",
      name: "Yamaha 200X",
      brandName: "Yamaha Pvt. Ltd.",
      description: Strings.mockLongDescription,
      imageUrl: Strings.bikeAssetPath,
      costPriceDetails: CostPriceDetails(
        currency: "Rs.",
        startingPrice: 222000,
        endingPrice: 230000
      ),
      featuresInfo: Features(
          type: "Non Electric",
          engine: "220 CC",
          material: "Foreign Alloy",
          brakes: "Disc 2",
          mileage: "22 km/l",
          topSpeed: "400 km/hr"
      )
    ),
    VehicleInfoModel(
        id: "2",
        name: "Kawasaki 300",
        brandName: "Kawasaki Pvt. Ltd.",
        description: Strings.mockLongDescription,
        imageUrl: Strings.bike2AssetPath,
        costPriceDetails: CostPriceDetails(
            currency: "Rs.",
            startingPrice: 42200000,
            endingPrice: 43000000
        ),
        featuresInfo: Features(
            engine: "360 CC",
            material: "Foreign Alloy",
            mileage: "14 km/l",
            topSpeed: "400 km/hr"
        )
    ),
];

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return SingleChildScrollView (
      scrollDirection: Axis.vertical,
      child: Column (
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              CarouselSliderView(
                data: carouselList,
                aspectRatio: mediaQuery.size.width < 450 ? 9 / 10 : 20 / 9,
              ),
            ],
          ),

          BaseCardWidget(
            "Top Brands",
            padding: const EdgeInsets.symmetric(vertical: Dimen.dim10),
            topRightmostArea: const Text(Strings.viewAll, style: TextStyle(
              fontWeight: FontWeight.bold,
              color: MyColors.xFFFF9200
            ),),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: Dimen.dim120),
              child: ListView.builder(
                  itemCount: brandsList.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return ConstrainedBox(
                      constraints: const BoxConstraints(
                        minWidth: Dimen.dim100,
                        maxWidth: Dimen.dim120,
                        minHeight: Dimen.dim100,
                        maxHeight: Dimen.dim120
                      ),
                      child: SquareCardWidget(
                        imgUrl: brandsList[index].imgUrl,
                        title: brandsList[index].title,
                      ),
                    );
                  }
              ),
            ),
          ),

          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(vehicleList.length, (index) =>
                Container(
                  height: mediaQuery.size.width * 0.3,
                  constraints: const BoxConstraints(minHeight: Dimen.dim140, maxHeight: Dimen.dim160, maxWidth: Dimen.dim500),
                  padding: const EdgeInsets.symmetric(horizontal: Dimen.dim15),
                  margin: const EdgeInsets.symmetric(vertical: Dimen.dim2),
                  child: HomeItemCard(vehicleInfoModel: vehicleList[index]),
                )
            )
          ),

          Container(
            height: mediaQuery.size.width * 0.42,
            constraints: const BoxConstraints(maxHeight: Dimen.dim230, maxWidth: Dimen.dim700),
            padding: const EdgeInsets.symmetric(horizontal: Dimen.dim10),
            child: ArrowSlider(
              contentSize: vehicleList.length,
              child: HomeBannerItemCard(vehicleInfoList: vehicleList),
            ),
          ),
        ],
      ),
    );
  }
}
