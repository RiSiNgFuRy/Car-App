import 'package:car_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utils/dimen.dart';

class CustomTimeSlider extends StatefulWidget {
  final DateTimeRange dateTimeRange;
  final DateTimeRange? restrictedRange;
  final DateTime initialTime;
  final ValueChanged<DateTime> onChangeValue;

  const CustomTimeSlider({
    super.key,
    required this.dateTimeRange,
    this.restrictedRange,
    required this.initialTime,
    required this.onChangeValue,
  });

  @override
  State<CustomTimeSlider> createState() => _CustomTimeSliderState();
}

class _CustomTimeSliderState extends State<CustomTimeSlider> {
  late double _sliderPosition;
  double thumbWidth = Dimen.dim90;

  @override
  void initState() {
    super.initState();
    _sliderPosition = _dateTimeToSliderValue(widget.initialTime);
  }

  double _dateTimeToSliderValue(DateTime dateTime) {
    return (dateTime.millisecondsSinceEpoch -
        widget.dateTimeRange.start.millisecondsSinceEpoch) /
        widget.dateTimeRange.duration.inMilliseconds.toDouble();
  }

  DateTime _sliderValueToDateTime(double value) {
    return widget.dateTimeRange.start.add(
        Duration(milliseconds: (widget.dateTimeRange.duration.inMilliseconds * value).toInt()));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return GestureDetector(

          onPanUpdate: (DragUpdateDetails details) {
            setState(() {
              _sliderPosition += details.delta.dx / constraints.maxWidth;
              _sliderPosition = _sliderPosition.clamp(0.0, 1.0);

              if (widget.restrictedRange != null) {
                double restrictedStart = _dateTimeToSliderValue(widget.restrictedRange!.start);
                double restrictedEnd = _dateTimeToSliderValue(widget.restrictedRange!.end);
                if (_sliderPosition >= restrictedStart && _sliderPosition <= restrictedEnd) {
                  _sliderPosition = (details.delta.dx.isNegative) ? restrictedStart : restrictedEnd;
                }
              }
            });
            widget.onChangeValue(_sliderValueToDateTime(_sliderPosition));
          },
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Container(
                width: constraints.maxWidth,
                height: Dimen.dim3,
                margin: const EdgeInsets.symmetric(vertical: Dimen.dim20),
                color: MyColors.xFF6B6A6A.withOpacity(0.3),
              ),
              AnimatedPositioned(
                left: _sliderPosition * (constraints.maxWidth - thumbWidth),
                duration: const Duration(milliseconds: 1),
                child: Container(
                  width: thumbWidth,
                  padding: const EdgeInsets.symmetric(vertical: Dimen.dim5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimen.dim30),
                    color: MyColors.xFF08BB0E,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    DateFormat("hh:mm a").format(_sliderValueToDateTime(_sliderPosition)),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: MyColors.xFFFFFFFF,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
