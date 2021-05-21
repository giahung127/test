import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_gardern_app/constant.dart';
import 'package:smart_gardern_app/screens/DeviceControl/components/calendar.dart';
import 'package:smart_gardern_app/screens/DeviceControl/components/event_editing.dart';
import 'package:smart_gardern_app/screens/DeviceControl/components/provider.dart';

class ScheduleTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CalendarWidget(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: kPrimaryColor,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => EventEditing()),
          );
        },
      ),
    );
  }
}
