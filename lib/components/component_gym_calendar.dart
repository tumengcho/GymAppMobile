import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

enum CalendarOptions { standard, week, months }

class GymCalendar extends StatefulWidget {
  GymCalendar({super.key});

  @override
  State<GymCalendar> createState() => _GymCalendarState();
}

class _GymCalendarState extends State<GymCalendar> {
  CalendarFormat _selectedFormat = CalendarFormat.week;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0XFF3F3F3D),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.5),
          width: 1
        )
      ),
      child: TableCalendar(
        rowHeight: 60,
        formatAnimationDuration: Duration(milliseconds: 500),
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: DateTime.now(),
        calendarFormat: _selectedFormat,
        daysOfWeekVisible: _selectedFormat != CalendarFormat.week,
        calendarStyle: CalendarStyle(
          outsideDaysVisible: false,
          todayDecoration: BoxDecoration(
              color: Color(0xFFD3FF55), borderRadius: BorderRadius.circular(20)),
          todayTextStyle: TextStyle(color: Colors.black),
          defaultTextStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        headerStyle: HeaderStyle(
            formatButtonDecoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Color(0xFFD3FF55)),
            ),
            formatButtonTextStyle: TextStyle(color: Colors.white),
            leftChevronVisible: false,
            rightChevronVisible: false,
            leftChevronIcon: Icon(Icons.chevron_left, color: Color(0xFFD3FF55)),
            rightChevronIcon:
                Icon(Icons.chevron_right, color: Color(0xFFD3FF55)),
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFFD3FF55))),
        calendarBuilders: CalendarBuilders(
          todayBuilder: (context, day, tday) => Container(
            width: double.maxFinite,
            margin: EdgeInsets.all(2),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Color(0xFFD3FF55),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white,
                  width: 0.5,
                )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _selectedFormat == CalendarFormat.week?Text(  DateFormat.E().format(tday), style: TextStyle(fontSize: 10, color: Colors.black)):SizedBox.shrink(),
                Text(tday.day.toString(), style: _selectedFormat == CalendarFormat.week? TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black): TextStyle(fontSize: 15, color: Colors.black))
              ],
            ),
          ),
          defaultBuilder:  (context, sDay, cDay) =>
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.all(2),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Color(0xFF323230),
              borderRadius: BorderRadius.circular(20),

            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _selectedFormat == CalendarFormat.week?Text(  DateFormat.E().format(sDay), style: TextStyle(fontSize: 10)):SizedBox.shrink(),
                Text(sDay.day.toString(), style: _selectedFormat == CalendarFormat.week? TextStyle(fontSize: 20, fontWeight: FontWeight.bold): TextStyle(fontSize: 15))
              ],
            ),
          )
        ),
        onFormatChanged: (newFormat) => {
          setState(() {
            _selectedFormat = newFormat;
          })
        },
      ),
    );
  }
}
