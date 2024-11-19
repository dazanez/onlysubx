import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:only_subx_ui/config/helpers/subscriptions_helpers.dart';
import 'package:only_subx_ui/domain/entities/entities.dart';
import 'package:only_subx_ui/presentations/providers/subscriptions_provider.dart';
import 'package:only_subx_ui/presentations/screens/subscriptions/custom_subscriptions_listview.dart';
import 'package:table_calendar/table_calendar.dart';

class SubsCalendarScreen extends ConsumerStatefulWidget {
  static const name = 'subs-calendar-screen';

  const SubsCalendarScreen({super.key});

  @override
  _SubsCalendarScreenState createState() => _SubsCalendarScreenState();
}

class _SubsCalendarScreenState extends ConsumerState<SubsCalendarScreen> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  List<String> _getSubscriptionsForDay(DateTime day) {
    List<Subscription> subs = ref.watch(subscriptionsProvider);

    return SubscriptionsHelpers.getSubscriptionsForDay(subs, day)
        .map((sub) => sub.name)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Subscription> subscriptions = ref.watch(subscriptionsProvider);
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'OnlySubx',
          style: TextStyle(color: colors.onBackground),
        ),
      ),
      body: Column(
        children: [
          TableCalendar(
              firstDay: DateTime.utc(2000, 10, 16),
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
              eventLoader: _getSubscriptionsForDay,
              calendarStyle:  CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: colors.tertiary,
                  shape: BoxShape.circle,
                ),
              )),
          CustomSubscriptionsListView(
              title: 'Subscripciones del día',
              subscriptions: SubscriptionsHelpers.getSubscriptionsForDay(
                  subscriptions, _focusedDay))
        ],
      ),
    );
  }
}
