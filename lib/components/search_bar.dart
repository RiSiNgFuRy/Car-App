
import 'package:car_app/utils/colors.dart';
import 'package:flutter/material.dart';
import '../utils/dimen.dart';
import '../utils/strings.dart';

class MySearchBar extends StatefulWidget {
  const MySearchBar({super.key});

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  final searchController = TextEditingController();
  final myFocusNode = FocusNode();

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: MyColors.xFFC2E5C4.withOpacity(0.5),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      elevation: 10,
      child: TextFormField (
        focusNode: myFocusNode,
        keyboardType: TextInputType.text,
        controller: searchController,
        textInputAction: TextInputAction.search,
        onTapOutside: (_) {
          myFocusNode.unfocus();
        },
        onFieldSubmitted: (_) {
          myFocusNode.unfocus();
        },
        decoration: const InputDecoration (
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search, color: MyColors.xFF6B6A6A),
          suffixIcon: InkResponse(
            radius: Dimen.dim15,
            child: Icon(Icons.arrow_right_alt, color: MyColors.xFF6B6A6A),
          ),
          hintText: Strings.search,
          hintStyle: TextStyle(
            color: MyColors.xFF6B6A6A,
            fontWeight: FontWeight.bold,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: Dimen.dim15, horizontal: Dimen.dim10),
        ),
      )
    );
  }
}
