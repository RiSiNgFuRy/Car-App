import 'package:flutter/cupertino.dart';

class SettingsCardModel {
  IconData iconData;
  String title;
  Function onTap;

  SettingsCardModel({required this.iconData, required this.title, required this.onTap});
}