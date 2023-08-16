import 'package:car_app/utils/colors.dart';
import 'package:car_app/view_models/rental_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utils/dimen.dart';

class CustomCalendar extends StatefulWidget {
  final DateTimeRange? activeDateRange;
  final Function(DateTime date) onChangeSelectedDate;
  final bool restrictToRange;
  final double? columnSpacing;
  final RentalScreenProvider provider;

  const CustomCalendar({
    super.key,
    this.activeDateRange,
    required this.onChangeSelectedDate,
    required this.provider,
    this.restrictToRange = false,
    this.columnSpacing
  }): assert(activeDateRange == null && restrictToRange == false || activeDateRange != null);

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {

  late DateTime startDate;

  @override
  void initState() {
    super.initState();
    startDate = widget.activeDateRange?.start ?? DateTime.now();
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
              visible: !widget.restrictToRange || widget.restrictToRange && widget.activeDateRange?.start != null && startDate.month > widget.activeDateRange!.start.month,
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
              visible: !widget.restrictToRange || widget.activeDateRange?.start != null && startDate.month < widget.activeDateRange!.end.month,
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
    var selectedDate = widget.provider.currentlySelectedDate;

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
                    width: Dimen.dim40,
                    alignment: Alignment.center,
                    child: Text(weekDay)
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
                  _areSameDates(selectedDate, date) ?
                  Container(
                    width: Dimen.dim40,
                    height: Dimen.dim40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: MyColors.xFFFF9200,
                      borderRadius: BorderRadius.circular(Dimen.dim5),
                    ),
                    child: Text(
                      date.day.toString(),
                      style: const TextStyle(
                        color: MyColors.xFFFFFFFF,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ) :
                  InkWell(
                    onTap: _dateInRange(date) ? () {
                      setState(() {
                        selectedDate = capturedDate;
                      });
                      widget.onChangeSelectedDate(capturedDate);
                    } : null,
                    child: Container(
                      constraints: const BoxConstraints.expand(),
                      alignment: Alignment.center,
                      child: Text(
                        date.day.toString(),
                        style: TextStyle(
                          color: _dateInRange(date) ?
                          date.weekday == DateTime.sunday || date.weekday == DateTime.saturday ? MyColors.xFFFF0000 : null :
                          MyColors.xFF6B6A6A,
                        ),
                      ),
                    ),
                  )
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
    return DateFormat("ddMMYYYY").format(date1) == DateFormat("ddMMYYYY").format(date2);
  }
}
