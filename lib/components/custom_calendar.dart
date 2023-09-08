import 'package:car_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utils/dimen.dart';

class CustomCalendar extends StatefulWidget {
  final DateTimeRange? activeDateRange;
  final Function(DateTime date) onChangeSelectedDate;
  final Function(DateTime? startDate, DateTime? endDate)? onChangeSelectedDateRange;
  final bool restrictToActiveRange;
  final bool isDateRangeSelector;
  final double? columnSpacing;
  DateTime? initiallySelectedDate;

  CustomCalendar({
    super.key,
    this.activeDateRange,
    required this.onChangeSelectedDate,
    this.onChangeSelectedDateRange,
    this.restrictToActiveRange = false,
    this.isDateRangeSelector = false,
    this.initiallySelectedDate,
    this.columnSpacing,
  }) : assert(activeDateRange == null && restrictToActiveRange == false || activeDateRange != null, "To restrict active date range need to set it activeDateRange firstly");

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {

  late DateTime startDate;
  DateTime? selectedRangeStartDate;
  DateTime? selectedRangeEndDate;

  @override
  void initState() {
    super.initState();
    startDate = widget.initiallySelectedDate != null
    ? DateTime(widget.initiallySelectedDate!.year, widget.initiallySelectedDate!.month)
    : widget.activeDateRange?.start ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {

    return Card(
      surfaceTintColor: MyColors.xFFFFFFFF,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimen.dim5)
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _topBar(),
          _calendar(context)
        ],
      ),
    );
  }

  _topBar() {
    return Container(
      color: MyColors.xFF08BB0E,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
            Visibility(
              visible: !widget.restrictToActiveRange || widget.restrictToActiveRange && widget.activeDateRange?.start != null && startDate.month > widget.activeDateRange!.start.month,
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              child: InkResponse(
                child: const Padding(
                  padding: EdgeInsets.all(Dimen.dim10),
                  child: Icon(Icons.keyboard_arrow_left, color: MyColors.xFFFFFFFF)
                ),
                onTap: () {
                  setState(() {
                    startDate = DateTime(startDate.year, startDate.month-1 , 1);
                  });
                },
              ),
            ),
          Text(
            DateFormat("MMMM yyyy").format(startDate),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: MyColors.xFFFFFFFF
            ),
          ),

            Visibility(
              visible: !widget.restrictToActiveRange || widget.activeDateRange?.start != null && startDate.month < widget.activeDateRange!.end.month,
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              child: InkResponse(
                child: const Padding(
                    padding: EdgeInsets.all(Dimen.dim10),
                    child: Icon(Icons.keyboard_arrow_right, color: MyColors.xFFFFFFFF)
                ),
                onTap: () {
                  setState(() {
                    startDate = DateTime(startDate.year, startDate.month+1 , 1);
                  });
                },
              ),
            ),
        ],
      ),
    );
  }

  _calendar(BuildContext context) {
    var weekDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    var selectedDate = widget.initiallySelectedDate;

    return FittedBox(
      child: DataTable(
        headingTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          color: MyColors.xFF000000,
        ),
        columnSpacing: widget.columnSpacing,
        dividerThickness: Dimen.dim0,
        columns: [
          for(var weekDay in weekDays)
            DataColumn(
                label: Container(
                    width: Dimen.dim70,
                    alignment: Alignment.center,
                    child: Text(weekDay, style: const TextStyle(
                      fontSize: Dimen.dim20
                    ),)
                )
            )
        ],
        rows: () {
          var rows = <DataRow>[];
          for (var date = DateTime(startDate.year, startDate.month, 1); date.month == startDate.month;) {
            var weekCells = <DataCell>[];

            for (var i = 1; i < date.weekday; i++) {
              weekCells.add(const DataCell(Text("")));
            }

            while (weekCells.length < 7 && date.month == startDate.month) {
              var capturedDate = date;
              weekCells.add(DataCell(
                  selectedDate != null && _areSameDates(selectedDate, date)
                  || selectedRangeStartDate != null && _areSameDates(selectedRangeStartDate!, date)
                  || selectedRangeEndDate != null && _areSameDates(selectedRangeEndDate!, date)
                ? Container(
                    margin: const EdgeInsets.symmetric(vertical: Dimen.dim2),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: MyColors.xFF08BB0E,
                      borderRadius: BorderRadius.circular(Dimen.dim5),
                    ),
                    child: Text(
                      date.day.toString(),
                      style: const TextStyle(
                        color: MyColors.xFFFFFFFF,
                        fontWeight: FontWeight.bold,
                        fontSize: Dimen.dim20
                      ),
                    ),
                  )

                  : Container(
                    margin: const EdgeInsets.symmetric(vertical: Dimen.dim10),
                    color: selectedRangeEndDate != null && date.isAfter(selectedRangeStartDate!) && date.isBefore(selectedRangeEndDate!)
                        ? MyColors.xFF08BB0E.withOpacity(0.2)
                        : null,
                    alignment: Alignment.center,
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(
                        fontSize: Dimen.dim18,
                        color: _dateInRange(date)
                            ? date.weekday == DateTime.sunday || date.weekday == DateTime.saturday ? MyColors.xFFFF0000 : null
                            : MyColors.xFF6B6A6A,
                      ),
                    ),
                  ),

                onTap: _dateInRange(date) || widget.isDateRangeSelector ? () {
                  setState(() {
                    if(widget.isDateRangeSelector) {
                      if(!_dateInRange(capturedDate)){
                        selectedRangeStartDate = null;
                        selectedRangeEndDate = null;
                      } else if (selectedRangeStartDate == null) {
                        selectedRangeStartDate = capturedDate;
                      } else if (capturedDate.compareTo(selectedRangeStartDate!) < 0) {
                        selectedRangeEndDate = null;
                        selectedRangeStartDate = null;
                      } else {
                        selectedRangeEndDate = capturedDate;
                      }
                    } else {
                      widget.initiallySelectedDate = capturedDate;
                    }
                  });
                  if(widget.isDateRangeSelector && widget.onChangeSelectedDateRange != null) {
                    widget.onChangeSelectedDateRange!(selectedRangeStartDate, selectedRangeEndDate);
                  }
                  widget.onChangeSelectedDate(capturedDate);
                } : null,
              ));
              date = date.add(const Duration(days: 1));
            }

            while (weekCells.length < 7) {
              weekCells.add(const DataCell(Text("")));
            }

            rows.add(DataRow(cells: weekCells));
          }
          return rows;
        }(),
      ),
    );
  }

  bool _dateInRange(DateTime date) {
    if(widget.activeDateRange != null) {
      return _areSameDates(date, widget.activeDateRange!.start)
          || _areSameDates(date, widget.activeDateRange!.end)
          || date.isAfter(widget.activeDateRange!.start) && date.isBefore(widget.activeDateRange!.end);
    }
    return true;
  }

  _areSameDates(DateTime date1, DateTime date2) {
    return DateFormat("ddMMyyyy").format(date1) == DateFormat("ddMMyyyy").format(date2);
  }
}
