import 'package:car_app/components/custom_grid_selector.dart';
import 'package:car_app/utils/colors.dart';
import 'package:car_app/view_models/rental_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/place_info_model.dart';
import '../utils/dimen.dart';
import 'custom_calendar.dart';

class RentalSearchBar extends StatefulWidget {
  final List<PlaceInfoModel> placesList;
  final RentalScreenProvider provider;

  const RentalSearchBar({super.key, required this.placesList, required this.provider});

  @override
  State<RentalSearchBar> createState() => _RentalSearchBarState();
}

class _RentalSearchBarState extends State<RentalSearchBar> {
  @override
  Widget build(BuildContext context) {
    final searchTextController = TextEditingController();
    final placeTextController = TextEditingController();
    final myFocusNode = FocusNode();
    final mediaQuery = MediaQuery.of(context);
    var currentDate = DateTime.now();
    var tomorrowDate = DateTime.now().add(const Duration(days: 1));

    @override
    void dispose() {
      myFocusNode.dispose();
      placeTextController.dispose();
      searchTextController.dispose();
      super.dispose();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimen.dim20, horizontal: Dimen.dim10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimen.dim10),
              color: MyColors.xFFFFFFFF
            ),
            clipBehavior: Clip.hardEdge,
            child: TextFormField(
              controller: searchTextController,
              style: const TextStyle(
                  fontSize: Dimen.dim14
              ),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.search,
              maxLines: 1,
              onTapOutside: (_) {
                myFocusNode.unfocus();
              },
              onFieldSubmitted: (_) {
                myFocusNode.unfocus();
              },
              decoration: InputDecoration(
                prefixIcon: Container(
                  decoration: const BoxDecoration(
                    color: MyColors.xFF6B6A6A,
                  ),
                  margin: const EdgeInsets.only(right: Dimen.dim10),
                  child: const Icon(Icons.car_rental),
                ),
                prefixIconColor: MyColors.xFFFFFFFF,
                hintMaxLines: 1,
                hintText: "Enter Vehicle Name, Brand or Type here...",
                hintStyle: const TextStyle(
                  fontSize: Dimen.dim14
                ),
                border: InputBorder.none,
              ),
            ),
          ),

          const SizedBox(height: Dimen.dim10),

          Row(
            children: [
              Container(
                width: Dimen.dim150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimen.dim10),
                  color: MyColors.xFFFFFFFF
                ),
                clipBehavior: Clip.hardEdge,
                child: Consumer<RentalScreenProvider>(
                  builder: (context, value, child) {
                    placeTextController.text = widget.provider.selectedCity ?? "";
                    return child!;
                  },
                  child: TextFormField(
                    controller: placeTextController,
                    maxLines: 1,
                    readOnly: true,
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: Dimen.dim14
                    ),
                    onTap: () {
                      showDialog(context: context, builder: (context) {
                        return Dialog(
                          backgroundColor: MyColors.xFF000000.withOpacity(0.4),
                          surfaceTintColor: MyColors.xFFFFFFFF,
                          child: CustomGridSelector(
                            list: widget.placesList,
                            searchBar: true,
                            onTapNone: () {
                              widget.provider.changeSelectedCity(null);
                              Navigator.of(context).pop();
                            },
                            onTapOnItem: (value) {
                              widget.provider.changeSelectedCity(value);
                              Navigator.of(context).pop();
                            },
                          ),
                        );
                      });
                    },
                    onTapOutside: (_) {
                      myFocusNode.unfocus();
                    },
                    onFieldSubmitted: (_) {
                      myFocusNode.unfocus();
                    },
                    decoration: InputDecoration(
                      prefixIcon: Container(
                        decoration: const BoxDecoration(
                          color: MyColors.xFF6B6A6A,
                        ),
                        margin: const EdgeInsets.only(right: Dimen.dim10),
                        child: const Icon(Icons.fort),
                      ),
                      prefixIconColor: MyColors.xFFFFFFFF,
                      suffixIcon: const Icon(Icons.arrow_drop_down),
                      hintMaxLines: 1,
                      hintText: "Place",
                      hintStyle: const TextStyle(
                          fontSize: Dimen.dim14
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                )
              ),

              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    InkWell(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.calendar_month),

                          Consumer<RentalScreenProvider>(
                            builder: (context, value, child) {
                              return Text(DateFormat("dd/MM").format(value.currentlySelectedDate), style: const TextStyle(
                                  fontWeight: FontWeight.bold
                              ),);
                            },
                          ),
                        ],
                      ),
                      onTap: () {
                        showDialog(context: context, builder: (context) {
                          return Dialog(
                            backgroundColor: Colors.transparent,
                            child: CustomCalendar(
                              initiallySelectedDate: widget.provider.currentlySelectedDate,
                              activeDateRange: DateTimeRange(
                                  start: DateTime.now(),
                                  end: DateTime.now().add(const Duration(days: 30))
                              ),
                              restrictToActiveRange: true,
                              onChangeSelectedDate: (DateTime date) {
                                widget.provider.changeSelectedDate(date);
                                Navigator.of(context).pop();
                              },
                            ),
                          );
                        });
                      },
                    ),

                    const SizedBox(width: Dimen.dim10),

                    Consumer<RentalScreenProvider>(
                      builder: (context, value, child) {
                        return InkWell(
                          child: Text(
                            "Today",
                            style: TextStyle(
                              fontSize: Dimen.dim15,
                              color: _areSameDates(value.currentlySelectedDate, currentDate)
                                  ? MyColors.xFFFF9200
                                  : MyColors.xFF6B6A6A,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () {
                            widget.provider.changeSelectedDate(currentDate);
                          },
                        );
                      },
                    ),

                    const Text(
                      " | ",
                      style: TextStyle(
                        color: MyColors.xFF6B6A6A,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                        Consumer<RentalScreenProvider>(
                        builder: (context, value, child) {
                          return InkWell(
                            child: Text(
                              "Tomorrow",
                              style: TextStyle(
                                color: _areSameDates(value.currentlySelectedDate, tomorrowDate)
                                    ? MyColors.xFFFF9200
                                    : MyColors.xFF6B6A6A,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: () {
                              widget.provider.changeSelectedDate(tomorrowDate);
                            },
                          );
                        }
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  _areSameDates(DateTime date1, DateTime date2) {
    return DateFormat("ddMMYYYY").format(date1) == DateFormat("ddMMYYYY").format(date2);
  }
}
