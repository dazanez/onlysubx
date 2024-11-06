import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class SubsCalendarScreen extends StatefulWidget {
  static const name = 'subs-calendar-screen';

  const SubsCalendarScreen({super.key});

  @override
  State<SubsCalendarScreen> createState() => _SubsCalendarScreenState();
}

class _SubsCalendarScreenState extends State<SubsCalendarScreen> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay =
      DateTime.now().subtract(Duration(days: DateTime.now().day));

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'OnlySubx',
          style: TextStyle(color: colors.onBackground),
        ),
      ),
      body: TableCalendar(
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: _focusedDay,
        onFormatChanged: (format) {},
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay; // update `_focusedDay` here as well
          });
        },
      ),
    );
  }
}
