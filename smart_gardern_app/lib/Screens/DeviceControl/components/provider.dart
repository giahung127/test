import 'package:flutter/foundation.dart';
import 'package:smart_gardern_app/Models/event.dart';

class EventProvider extends ChangeNotifier {
  final List<Event> _events = [];

  List<Event> get events => _events;
  void addEvent(Event event) {
    _events.add(event);

    notifyListeners();
  }
}
