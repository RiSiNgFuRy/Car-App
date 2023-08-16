import 'package:car_app/utils/helpers/ImageHelper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:car_app/models/carousel_list_model.dart';
import 'package:car_app/utils/strings.dart';
import 'package:car_app/utils/colors.dart';
import 'package:provider/provider.dart';

import '../utils/dimen.dart';

class CarouselSliderView extends StatefulWidget {
  List<CarouselListModel>? data;
  double aspectRatio;
  bool? autoPlay;

  CarouselSliderView({super.key, required this.data, this.aspectRatio = 16/9, this.autoPlay});

  @override
  State<CarouselSliderView> createState() => _CarouselSliderViewState();
}

class _CarouselSliderViewState extends State<CarouselSliderView> {
  final carouselController = CarouselController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.data != null) {
      return Stack(
          children: [
            InkWell(
              child: CarouselSlider(
                  carouselController: carouselController,
                  items: widget.data!.map((item) =>
                      ImageHelper.network(
                        item.imgUrl,
                        xWidth: double.infinity,
                        boxFit: BoxFit.cover
                      )
                  ).toList(),
                  options: CarouselOptions(
                      scrollPhysics: const BouncingScrollPhysics(),
                      aspectRatio: widget.aspectRatio,
                      autoPlay: widget.autoPlay ?? true,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) {
                        setState(() {
                          currentIndex = index;
                        });
                      }
                  )
              ),
              onTap: () => {

              },
            ),
            Positioned(
                bottom: 10,
                right: 0,
                left: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.data!.asMap().entries.map((item) =>
                      GestureDetector(
                        onTap: () => carouselController.animateToPage(item.key),
                        child: Container(
                          width: currentIndex == item.key ? 15 : 5,
                          height: 5,
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: currentIndex == item.key ? MyColors
                                  .xFF08BB0E : MyColors.xFFFFFFFF
                          ),
                        ),
                      )
                  ).toList(),
                )
            )
          ]
      );
    } else {
      throw UnimplementedError("No data found for carousel List");
    }
  }
}
