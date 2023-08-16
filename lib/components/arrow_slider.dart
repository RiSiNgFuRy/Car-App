import 'package:car_app/utils/colors.dart';
import 'package:car_app/utils/helpers/ImageHelper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/dimen.dart';
import '../utils/strings.dart';
import '../view_models/home_screen_provider.dart';

class ArrowSlider extends StatelessWidget {
  Widget child;
  int contentSize;
  ArrowSlider({super.key, required this.child, required this.contentSize});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final provider = Provider.of<HomeScreenProvider>(context, listen: false);

    return Stack(
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimen.dim20, vertical: Dimen.dim5),
            child: child
        ),

        Positioned(
          top: 0,
          bottom: 0,
          child: Container(
            width: mediaQuery.size.width * 0.08,
            padding: const EdgeInsets.all(Dimen.dim5),
            constraints: const BoxConstraints(maxWidth: Dimen.dim50, minWidth: Dimen.dim30),
            child: InkResponse(
              onTap: () => {
                provider.moveToNextItem(Direction.BACKWARD, contentSize)
              },
              splashColor: MyColors.xFFC2E5C4.withOpacity(0.2),
              radius: Dimen.dim15,
              child: ImageHelper.assets(
                Strings.leftArrowAssetPath
              ),
            ),
          ),
        ),

        Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          child: Container(
            width: mediaQuery.size.width * 0.08,
            padding: const EdgeInsets.all(Dimen.dim5),
            constraints: const BoxConstraints(maxWidth: Dimen.dim50, minWidth: Dimen.dim30),
            child: InkResponse(
              onTap: () => {
                provider.moveToNextItem(Direction.FORWARD, contentSize)
              },
              splashColor: MyColors.xFFC2E5C4.withOpacity(0.2),
              radius: Dimen.dim15,
              child: ImageHelper.assets(
                Strings.rightArrowAssetPath
              ),
            ),
          ),
        ),
      ],
    );
  }
}
