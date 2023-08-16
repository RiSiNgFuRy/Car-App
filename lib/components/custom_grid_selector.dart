import 'package:car_app/components/search_bar.dart';
import 'package:car_app/components/square_card_widget.dart';
import 'package:car_app/models/place_info_model.dart';
import 'package:car_app/utils/colors.dart';
import 'package:car_app/utils/dimen.dart';
import 'package:flutter/material.dart';
import '../models/base_model.dart';

class CustomGridSelector extends StatefulWidget {
  final List<BaseModel> list;
  final bool searchBar;
  final Function(String? value)? onTapOnItem;
  final Function? onTapNone;

  const CustomGridSelector({super.key, required this.list, this.searchBar = false, this.onTapOnItem, this.onTapNone});

  @override
  State<CustomGridSelector> createState() => _CustomGridSelectorState();
}

class _CustomGridSelectorState extends State<CustomGridSelector> {
  @override
  Widget build(BuildContext context) {
    return contentBox(context);
  }

  contentBox(context) {
    var placesList = widget.list as List<PlaceInfoModel>;
    final mediaQuery = MediaQuery.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Dimen.dim10, vertical: Dimen.dim20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if(widget.searchBar)
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: Dimen.dim600),
            child: const MySearchBar()
          ),
          if(widget.onTapNone != null)
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimen.dim10),
                border: Border.all(color: MyColors.xFFFFFFFF.withOpacity(0.6), width: Dimen.dim2),
              ),
              margin: const EdgeInsets.all(Dimen.dim10),
              child: InkWell(
                borderRadius: BorderRadius.circular(Dimen.dim10),
                onTap: () { widget.onTapNone!(); },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimen.dim10, vertical: Dimen.dim5),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.not_interested, color: MyColors.xFFFFFFFF.withOpacity(0.6),),
                      const SizedBox(width: Dimen.dim10),
                      Text("None", style: TextStyle(
                        color: MyColors.xFFFFFFFF.withOpacity(0.6),
                        fontWeight: FontWeight.bold
                      ),)
                    ],
                  ),
                ),
              )
            ),
          ),
          SizedBox(
            height: mediaQuery.size.width > 600 ? Dimen.dim200 : Dimen.dim400,
            child: GridView.builder(
              scrollDirection: Axis.vertical,
              itemCount: placesList.length,
              padding: const EdgeInsets.all(Dimen.dim5),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: Dimen.dim150,
                mainAxisExtent: Dimen.dim120
              ),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  borderRadius: BorderRadius.circular(Dimen.dim10),
                  onTap: () {
                    if(widget.onTapOnItem != null) {
                      widget.onTapOnItem!(placesList[index].title);
                    }
                  },
                  child: SquareCardWidget(
                    key: ValueKey(placesList[index].id),
                    imgUrl: placesList[index].imgUrl,
                    title: placesList[index].title,
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
