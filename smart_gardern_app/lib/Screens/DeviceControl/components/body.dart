import 'package:flutter/material.dart';
import 'package:smart_gardern_app/screens/DeviceControl/components/control_tab.dart';
import 'package:smart_gardern_app/screens/DeviceControl/components/schedule_tab.dart';
import 'package:smart_gardern_app/constant.dart';

class Body extends StatelessWidget {
  goBack(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: DefaultTabController(
            length: 2,
            child: Scaffold(
                appBar: AppBar(
                  backgroundColor: kPrimaryColor,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      goBack(context);
                    },
                  ),
                  title: Text("Control Device"),
                  bottom: TabBar(
                    tabs: [
                      Tab(
                        icon: Icon(Icons.calendar_today),
                        text: "Schelue",
                      ),
                      Tab(
                        icon: Icon(Icons.settings),
                        text: "Control",
                      ),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: <Widget>[
                    ScheduleTab(),
                    ControlTab(),
                  ],
                ))));
  }
}
