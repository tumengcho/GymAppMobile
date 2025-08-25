import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

/// Component pour le calendrier
/// Affiche les dates sous différents format possible (Mois, 1 semaine, 2 semaines)
/// TODO : Faire en sorte de relier des évènements à des dates et de pouvoir avoir un streak.

class GymCalendar extends StatefulWidget {
  const GymCalendar({super.key});

  @override
  State<GymCalendar> createState() => _GymCalendarState();
}

class _GymCalendarState extends State<GymCalendar> {
  CalendarFormat _selectedFormat = CalendarFormat.week;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: const Color(0XFF3F3F3D),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.5), width: 1)),
        child: TableCalendar(
          rowHeight: 60,
          formatAnimationDuration: const Duration(milliseconds: 500),
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: DateTime.now(),
          calendarFormat: _selectedFormat,
          daysOfWeekVisible: _selectedFormat != CalendarFormat.week,
          calendarStyle: CalendarStyle(
            outsideDaysVisible: false,
            todayDecoration: BoxDecoration(
                color: const Color(0xFFD3FF55),
                borderRadius: BorderRadius.circular(20)),
            todayTextStyle: const TextStyle(color: Colors.black),
            defaultTextStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          headerStyle: HeaderStyle(
              formatButtonDecoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFD3FF55)),
              ),
              formatButtonTextStyle: const TextStyle(color: Colors.white),
              leftChevronVisible: false,
              rightChevronVisible: false,
              leftChevronIcon:
                  const Icon(Icons.chevron_left, color: Color(0xFFD3FF55)),
              rightChevronIcon:
                  const Icon(Icons.chevron_right, color: Color(0xFFD3FF55)),
              titleTextStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFFD3FF55))),
          calendarBuilders: CalendarBuilders(
              todayBuilder: (context, otherDates, todayDate) => Container(
                    width: double.maxFinite,
                    margin: const EdgeInsets.all(2),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: const Color(0xFFD3FF55),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white,
                          width: 0.5,
                        )),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _selectedFormat == CalendarFormat.week
                            ? Text(DateFormat.E().format(todayDate),
                                style: const TextStyle(
                                    fontSize: 10, color: Colors.black))
                            : const SizedBox.shrink(),
                        Text(todayDate.day.toString(),
                            style: _selectedFormat == CalendarFormat.week
                                ? const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)
                                : const TextStyle(fontSize: 15, color: Colors.black))
                      ],
                    ),
                  ),
              defaultBuilder: (context, aDate, selectedDate) => Container(
                    width: double.maxFinite,
                    margin: const EdgeInsets.all(2),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: const Color(0xFF323230),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _selectedFormat == CalendarFormat.week
                            ? Text(DateFormat.E().format(aDate),
                                style: const TextStyle(fontSize: 10))
                            : const SizedBox.shrink(),
                        Text(aDate.day.toString(),
                            style: _selectedFormat == CalendarFormat.week
                                ? const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)
                                : const TextStyle(fontSize: 15))
                      ],
                    ),
                  )),
          onFormatChanged: (newFormat) => {
            setState(() {
              _selectedFormat = newFormat;
            })
          },
        ),
      ),
    );
  }
}
