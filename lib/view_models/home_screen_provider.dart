import 'package:flutter/material.dart';

class HomeScreenProvider extends ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void moveToNextItem(Direction direction,int contentSize) {
    switch(direction) {
      case Direction.FORWARD:
        _currentIndex++;
        if(_currentIndex >= contentSize) {
          _currentIndex = 0;
        }
        break;
      case Direction.BACKWARD:
        _currentIndex--;
        if(_currentIndex < 0) {
          _currentIndex = contentSize -1;
        }
        break;
      default:
        throw UnimplementedError("No such action defined");
    }
    notifyListeners();
  }
}

enum Direction {
  FORWARD,
  BACKWARD
}