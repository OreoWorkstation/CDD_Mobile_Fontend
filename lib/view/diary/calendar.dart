import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:cdd_mobile_frontend/common/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  final Map<DateTime, List> events;
  final List selectedEvents;
  final AnimationController animationController;
  final CalendarController calendarController;
  final DateTime initialSelectedDay;

  CalendarPage({
    Key key,
    this.events,
    this.selectedEvents,
    this.animationController,
    this.calendarController,
    this.initialSelectedDay,
  }) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  Map<DateTime, List> _events;
  AnimationController _animationController;
  CalendarController _calendarController;
  DateTime _initialSelectedDay;

  @override
  void initState() {
    super.initState();
    _events = widget.events;
    _animationController = widget.animationController;
    _calendarController = widget.calendarController;
    _initialSelectedDay = widget.initialSelectedDay;
  }

  void _onDaySelected(DateTime day, List events) {
    print("CALLBACK: _onDaySelected");
    Navigator.of(context)
        .pop([events, _calendarController, cddFormatDatetime(day)]);
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width - sWidth(20),
          height: sHeight(520),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: Radii.k10pxRadius,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: sWidth(10),
              vertical: sHeight(20),
            ),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    textBtnFlatButtonWidget(
                      onPressed: () => Navigator.of(context).pop(),
                      title: "取消",
                      fontSize: 15,
                      textColor: AppColor.secondaryElement,
                    ),
                    Text(
                      "选择日期",
                      style: TextStyle(
                          fontSize: sSp(17), color: Colors.black),
                    ),
                    textBtnFlatButtonWidget(
                      onPressed: () {
                        _calendarController.setSelectedDay(
                          DateTime.now(),
                          runCallback: true,
                        );
                      },
                      title: "今天",
                      fontSize: 15,
                      textColor: AppColor.primaryElement,
                    ),
                  ],
                ),
                _buildTableCalendarWithBuilders(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTableCalendarWithBuilders() {
    return TableCalendar(
      locale: 'zh_CN',
      calendarController: _calendarController,
      events: _events,
      initialSelectedDay: _initialSelectedDay,
      initialCalendarFormat: CalendarFormat.month,
      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableGestures: AvailableGestures.all,
      availableCalendarFormats: const {
        CalendarFormat.month: '',
        CalendarFormat.week: '',
      },
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
        weekendStyle: TextStyle().copyWith(
            color: AppColor.secondaryElement, fontSize: sSp(16)),
        weekdayStyle: TextStyle().copyWith(
            color: AppColor.primaryText, fontSize: sSp(16)),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekendStyle: TextStyle().copyWith(
            color: AppColor.secondaryElement, fontSize: sSp(15)),
        weekdayStyle: TextStyle().copyWith(
            color: AppColor.primaryText, fontSize: sSp(15)),
      ),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        formatButtonVisible: false,
        titleTextStyle: TextStyle()
            .copyWith(color: Colors.black, fontSize: sSp(16)),
      ),
      builders: CalendarBuilders(
        selectedDayBuilder: (context, date, _) {
          return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
            child: Container(
              margin: const EdgeInsets.all(5.0),
              child: CircleAvatar(
                backgroundColor: AppColor.diaryColor,
                child: Text(
                  '${date.day}',
                  textAlign: TextAlign.center,
                  style: TextStyle().copyWith(
                    color: Colors.white,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
        todayDayBuilder: (context, date, _) {
          return Container(
            margin: const EdgeInsets.all(4.0),
            child: CircleAvatar(
              backgroundColor: AppColor.primaryElementRed.withOpacity(0.7),
              child: Text(
                '${date.day}',
                style: TextStyle().copyWith(
                  fontSize: 16.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
        markersBuilder: (context, date, events, holidays) {
          final children = <Widget>[];

          if (events.isNotEmpty) {
            children.add(
              Positioned(
                right: 1,
                bottom: 1,
                child: _buildEventsMarker(date, events),
              ),
            );
          }
          return children;
        },
      ),
      onDaySelected: (date, events) {
        _onDaySelected(date, events);
        _animationController.forward(from: 0.0);
      },
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _calendarController.isSelected(date)
            ? Colors.brown[500]
            : _calendarController.isToday(date)
                ? Colors.brown[300]
                : Colors.blue[400],
      ),
      width: sWidth(8),
      height: sWidth(8),
    );
  }
}
