import 'package:car_app/models/settings_model.dart';
import 'package:car_app/utils/colors.dart';
import 'package:flutter/material.dart';

import '../utils/dimen.dart';

class SettingsCard extends StatefulWidget {
  final SettingsCardModel settingsCardModel;

  const SettingsCard({super.key, required this.settingsCardModel});

  @override
  State<SettingsCard> createState() => _SettingsCardState();
}

class _SettingsCardState extends State<SettingsCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: Dimen.dim10,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(Dimen.dim30),
      ),
      surfaceTintColor: MyColors.xFFFF9200,
      color: MyColors.xFFFF9200,
      child: Padding(
        padding: const EdgeInsets.all(Dimen.dim5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Icon(widget.settingsCardModel.iconData, color: MyColors.xFFFFFFFF, size: Dimen.dim40,)
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text(widget.settingsCardModel.title.toUpperCase(), style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: Dimen.dim10,
                  color: MyColors.xFFFFFFFF,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
