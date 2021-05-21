import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_gardern_app/screens/DeviceControl/components/event_data.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:smart_gardern_app/constant.dart';
import 'package:smart_gardern_app/Screens/DeviceControl/components/provider.dart';

class CalendarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final events = Provider.of<EventProvider>(context).events;

    return SfCalendar(
      view: CalendarView.month,
      todayHighlightColor: kPrimaryColor,
      firstDayOfWeek: 7,
      dataSource: EventDataSource(events),
      initialSelectedDate: DateTime.now(),
      cellBorderColor: Colors.transparent,
      monthViewSettings: MonthViewSettings(
        showAgenda: true,
        dayFormat: 'EEE',
      ),
    );
  }
}
