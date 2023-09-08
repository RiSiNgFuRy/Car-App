import 'package:car_app/components/base_rental_card_widget.dart';
import 'package:car_app/components/custom_time_slider.dart';
import 'package:car_app/models/insurance_model.dart';
import 'package:car_app/models/location_model.dart';
import 'package:car_app/models/rental_vehicle_info_model.dart';
import 'package:car_app/utils/colors.dart';
import 'package:car_app/utils/strings.dart';
import 'package:car_app/view_models/renting_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import '../components/custom_calendar.dart';
import '../components/rental_insurance_card.dart';
import '../components/renting_screen_header.dart';
import '../utils/dimen.dart';

class VehicleRentingScreen extends StatelessWidget {
  RentalVehicleInfo rentalVehicleInfo;

  VehicleRentingScreen({super.key, required this.rentalVehicleInfo});

  late RentingScreenProvider provider;

  var insuranceList = [
    InsuranceModel(
      id: "0",
      title: "Basic",
      subTitle: "You pay up to 3200 INR in case of any damage",
      price: 321.0
    ),
    InsuranceModel(
        id: "1",
        title: "Mild Relief",
        subTitle: "You pay up to 999 INR in case of any damage",
        price: 1500.0
    ),
    InsuranceModel(
        id: "2",
        title: "Money Saver",
        subTitle: "You pay up to 90 INR in case of any damage",
        price: 3200.0
    )
  ];

  var locationList = [
    LocationModel(
      placeName: "Suraj Travels",
      latitude: "26.4499",
      longitude: "80.3319",
      city: "Kanpur",
      completeAddress: "M 12 Mukherjee Vihar"
    ),
    LocationModel(
        placeName: "Kartikey Car Services",
        latitude: "36.4599",
        longitude: "76.3319",
        city: "Kanpur",
        completeAddress: "H 122 Keshav chauraha"
    ),
    LocationModel(
        placeName: "Suraj Travels",
        latitude: "56.4199",
        longitude: "80.5319",
        city: "Kanpur",
        completeAddress: "near Swastik Mall Road, Banarsi Dhaba ke saamne"
    ),
  ];

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<RentingScreenProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Renting Area"),
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                primary: true,
                child: _contentArea(context),
              ),
            ),
            _bottomSticky(context),
          ],
        ),
      )
    );
  }

  _contentArea(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Stack(
      children: [
        SizedBox(
          height: mediaQuery.size.height * 0.6,
          child: Consumer<RentingScreenProvider>(
            builder: (context, value, child) {
              return FlutterMap(
                options: MapOptions(
                  center: value.selectedDealerLocation,
                  onMapReady: () {
                    provider.changeSelectedDealer(
                        LatLng(double.parse(locationList[0].latitude!) , double.parse(locationList[0].longitude!)),
                        0
                    );
                  }
                ),
                mapController: value.selectedDealerMapController,
                children: [
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.car_app',
                  ),
                  MarkerLayer(
                    markers: [
                      if(value.selectedDealerLocation != null)
                      Marker(
                          point: value.selectedDealerLocation!,
                          builder: (BuildContext context) {
                            return const Icon(
                              Icons.location_pin,
                              color: MyColors.xFFFF0000,
                              size: Dimen.dim40,
                            );
                          }
                      )
                    ],
                  )
                ],
              );
            },
          ),
        ),

        RentingScreenHeader(rentalVehicleInfo: rentalVehicleInfo),

        Padding(
          padding: EdgeInsets.only(
            top: mediaQuery.size.height * 0.5
          ),
          child: Card(
            elevation: Dimen.dim10,
            surfaceTintColor: MyColors.xFFFFFFFF,
            margin: EdgeInsets.zero,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(Dimen.dim20))
            ),
            child: _optionsArea(context),
          ),
        )
      ],
    );
  }

  _optionsArea(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
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

        IntrinsicWidth(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimen.dim30),
              color: MyColors.xFF6B6A6A.withOpacity(0.2)
            ),
            clipBehavior: Clip.hardEdge,
            alignment: Alignment.center,
            child: Consumer<RentingScreenProvider>(
              builder: (context, value, child) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildOption("Self Pick-up", 0, value),
                    _buildOption("Delivery", 1, value),
                    _buildOption("Airport", 2, value),
                  ],
                );
              },
            ),
          ),
        ),

        const SizedBox(height: Dimen.dim10),

        BaseRentalCardWidget(
          heading: "Select Delivery Location",
          child: Padding (
            padding: const EdgeInsets.symmetric(horizontal: Dimen.dim10),
            child:  _locationSelectionArea(context),
          ),
        ),

        const SizedBox(height: Dimen.dim10),

        BaseRentalCardWidget(
          heading: "Select Booking Period",
          child: Padding (
              padding: const EdgeInsets.symmetric(horizontal: Dimen.dim10),
              child: _dateAndTimeSelectionArea(context)
          ),
        ),

        const SizedBox(height: Dimen.dim10),

        BaseRentalCardWidget(
          heading: "Select a Safety Package",
          child: Padding (
              padding: const EdgeInsets.symmetric(horizontal: Dimen.dim10),
              child: _insuranceSelectionArea(context)
          ),
        )
      ],
    );
  }

  _buildOption(String text, int index, RentingScreenProvider value) {
    bool isSelected = value.selectedCategoryOfServiceIdx == index;
    return GestureDetector(
      onTap: () { value.changeSelectedCategoryOfService(index); },
      child: AnimatedContainer(
        duration: const Duration(microseconds: 500),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: Dimen.dim5, vertical: Dimen.dim8),
        decoration: BoxDecoration(
          color: isSelected ? MyColors.xFF08BB0E : Colors.transparent,
          borderRadius: BorderRadius.circular(Dimen.dim30),
        ),
        child: Container(
          width: Dimen.dim120,
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              fontSize: Dimen.dim16,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Colors.white : null,
            ),
          ),
        ),
      ),
    );
  }

  _bottomSticky(BuildContext context) {
    return Container(
      color: MyColors.xFF6600FF,
      padding: const EdgeInsets.only(
        left: Dimen.dim20,
        right: Dimen.dim20,
        top: Dimen.dim10,
        bottom: Dimen.dim30
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("${Strings.rupeeSymbol}${rentalVehicleInfo.hourlyRate!}/-", style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Dimen.dim24,
            color: MyColors.xFFFFFFFF
          ),),

          ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
              elevation: MaterialStateProperty.all(Dimen.dim5),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimen.dim5)
                )
              ),
              backgroundColor: MaterialStateProperty.all(MyColors.xFFFF9200),
            ),
            child: const Text("Continue", style: TextStyle(
              fontWeight: FontWeight.bold,
              color: MyColors.xFFFFFFFF
            ),)
          )
        ],
      ),
    );
  }

  _locationSelectionArea(BuildContext context) {

    return Container (
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimen.dim5),
          border: Border.all(
              color: MyColors.xFFFF9200,
              width: Dimen.dim2
          )
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(Dimen.dim5),
            child: DropdownButtonHideUnderline(
              child: DropdownButtonFormField(
                  value: "${locationList[provider.selectedDealerIndex].placeName}, ${locationList[provider.selectedDealerIndex!].completeAddress}",
                  menuMaxHeight: Dimen.dim150,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Dealers List",
                  ),
                  items: [
                    for(var idx =0; idx < locationList.length; idx++)
                    DropdownMenuItem(
                      value: "${locationList[idx].placeName}, ${locationList[idx].completeAddress}",
                      child: Text(
                        "${locationList[idx].placeName}, ${locationList[idx].completeAddress}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 2,
                      ),
                      onTap: () {
                        provider.changeSelectedDealer(
                          LatLng(
                            double.parse(locationList[idx].latitude!),
                            double.parse(locationList[idx].longitude!)
                          ),
                          idx
                        );
                      },
                    ),
                  ],
                onChanged: (String? value) {  },
              ),
            ),
          ),
        ],
      ),
    );
  }

  _dateAndTimeSelectionArea(BuildContext context) {
    DateTime currentTime = DateTime.now();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CustomCalendar(
          activeDateRange: DateTimeRange(
            start: DateTime.now(),
            end: DateTime.now().add(const Duration(days: 30))
          ),
          isDateRangeSelector: true,
          restrictToActiveRange: true,
          columnSpacing: Dimen.dim0,
          onChangeSelectedDate: (DateTime date) {},
          onChangeSelectedDateRange: (DateTime? startDate, DateTime? endDate) {},
        ),

        const SizedBox(height: Dimen.dim10,),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimen.dim10),
          child: Row(
            children: [
              const SizedBox(
                width: Dimen.dim60,
                child: Text("Start", style: TextStyle(
                  fontSize: Dimen.dim18,
                  fontWeight: FontWeight.bold
                ),),
              ),

              Expanded(
                child: CustomTimeSlider(
                    dateTimeRange: DateTimeRange(
                      start: currentTime.copyWith(hour: 6, minute: 30),
                      end: currentTime.copyWith(hour: 18, minute: 00),
                    ),
                    initialTime: currentTime.copyWith(hour: 12, minute: 30),
                    onChangeValue: (DateTime newValue) {}
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: Dimen.dim10,),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimen.dim10),
          child: Row(
            children: [
              const SizedBox(
                width: Dimen.dim60,
                child: Text("End", style: TextStyle(
                    fontSize: Dimen.dim18,
                    fontWeight: FontWeight.bold
                ),),
              ),

              Expanded(
                child: CustomTimeSlider(
                    dateTimeRange: DateTimeRange(
                      start: currentTime.copyWith(hour: 6, minute: 30),
                      end: currentTime.copyWith(hour: 18, minute: 00),
                    ),
                    initialTime: currentTime.copyWith(hour: 12, minute: 30),
                    onChangeValue: (DateTime newValue) {}
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _insuranceSelectionArea(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: insuranceList.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Consumer<RentingScreenProvider>(
          builder: (context, value, child) {
            return InkWell(
              splashColor: Colors.transparent,
              onTap: () { provider.changeSelectedInsurancePackage(insuranceList[index].id); },
              child: RentalInsuranceCard(
                selectedItem: value.selectedInsurancePackage ?? "",
                insuranceModel: insuranceList[index],
              ),
            );
          },
        );
      }
    );
  }
}

