import 'package:car_app/utils/colors.dart';
import 'package:car_app/view_models/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/dimen.dart';
import '../utils/strings.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MainProvider>(context, listen: false);

    print("build");
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text(
      //     "ShowRoom",
      //     style: TextStyle(
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      //   centerTitle: false,
      // ),
      drawer: Container(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if(constraints.maxWidth < 450) {
            return Consumer<MainProvider> (
              builder: (context, value, child) {
                return Column(
                    children: [
                      Expanded(
                        child: value.selectedPage
                      ),
                      BottomNavigationBar(
                        items: const [
                          BottomNavigationBarItem(
                              icon: Icon(Icons.home_outlined),
                              label: Strings.home
                          ),
                          BottomNavigationBarItem(
                              icon: Icon(Icons.car_rental_outlined),
                              label: Strings.rental
                          ),
                          BottomNavigationBarItem(
                              icon: Icon(Icons.car_repair_outlined),
                              label: Strings.services
                          ),
                          BottomNavigationBarItem(
                              icon: Icon(Icons.settings_outlined),
                              label: Strings.account
                          ),
                        ],
                        currentIndex: value.selectedIndex,
                        onTap: (index) => provider.navigate(index),
                        selectedItemColor: MyColors.xFF08BB0E,
                        unselectedItemColor: MyColors.xFF000000,
                        selectedLabelStyle: const TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                      )]
                );
              }
            );
          } else {
            return Consumer<MainProvider>(
              builder: (context, value, child) {
                return SafeArea(
                  bottom: false,
                  child: Row(
                      children: [
                        SizedBox(
                          width: 200,
                          child: NavigationRail(
                            extended: constraints.maxWidth >= 600,
                            destinations: const [
                              NavigationRailDestination(
                                  icon: Icon(Icons.home_outlined),
                                  label: Text(Strings.home)
                              ),
                              NavigationRailDestination(
                                  icon: Icon(Icons.car_rental_outlined),
                                  label: Text(Strings.rental)
                              ),
                              NavigationRailDestination(
                                  icon: Icon(Icons.car_repair_outlined),
                                  label: Text(Strings.services)
                              ),
                              NavigationRailDestination(
                                  icon: Icon(Icons.settings_outlined),
                                  label: Text(Strings.account)
                              ),
                            ],
                            selectedIndex: value.selectedIndex,
                            onDestinationSelected: (index) => provider.navigate(index),
                          ),
                        ),
                        Expanded(child: value.selectedPage)
                      ]
                  ),
                );
              }
            );
          }
        },
      ),
    );
  }
}
