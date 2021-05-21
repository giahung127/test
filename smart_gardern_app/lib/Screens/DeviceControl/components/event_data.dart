import 'package:smart_gardern_app/Models/event.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventDataSource extends CalendarDataSource {
  EventDataSource(List<Event> appointments) {
    this.appointments = appointments;
  }

  Event getEvent(int index) {
    return appointments![index] as Event;
  }

  @override
  DateTime getStartTime(int index) {
    return getEvent(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return getEvent(index)
        .from
        .add(Duration(hours: getEvent(index).duration.round()));
  }

  @override
  String getLocation(int index) {
    return getEvent(index).location;
  }

  @override
  String getSubject(int index) {
    return getEvent(index).title;
  }
}
