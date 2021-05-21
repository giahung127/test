import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_gardern_app/Models/event.dart';
import 'package:smart_gardern_app/constant.dart';
import 'package:smart_gardern_app/screens/DeviceControl/components/provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventEditing extends StatefulWidget {
  final Event? event;

  const EventEditing({Key? key, this.event}) : super(key: key);

  @override
  _EventEditingState createState() {
    return _EventEditingState();
  }
}

class _EventEditingState extends State<EventEditing> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final durationController = TextEditingController();

  late DateTime from;
  late String location;

  @override
  void initState() {
    super.initState();
    if (widget.event == null) {
      from = DateTime.now();
      location = "Location 1";
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    durationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: CloseButton(),
          actions: buildEditingActions(),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(kDefaultPadding),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                buildTitle(),
                SizedBox(height: 12),
                buildDateTimePicker(),
                buildDuration(),
              ],
            ),
          ),
        ));
  }

  List<Widget> buildEditingActions() => [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            primary: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          onPressed: saveForm,
          icon: Icon(Icons.done),
          label: Text("SAVE"),
        )
      ];

  Widget buildTitle() {
    return TextFormField(
      style: TextStyle(fontSize: 24),
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        hintText: 'Add Title',
      ),
      onFieldSubmitted: (_) => saveForm(),
      validator: (title) =>
          title != null && title.isEmpty ? 'Title cannot be empty' : null,
      controller: titleController,
    );
  }

  Widget buildDuration() {
    return buildHeader(
        header: 'SELECT DURATION',
        child: TextFormField(
          decoration: InputDecoration(
            border: UnderlineInputBorder(),
            hintText: 'Add Duration',
          ),
          onFieldSubmitted: (_) => saveForm(),
          validator: (duration) => duration != null && duration.isEmpty
              ? 'Title cannot be empty'
              : null,
          controller: durationController,
        ));
  }

  Widget buildDateTimePicker() {
    return Column(
      children: [
        buildForm(),
      ],
    );
  }

  Widget buildForm() {
    return buildHeader(
        header: 'SELECT DATE',
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: buildDropdownField(
                  text: DateFormat.yMMMEd().format(from),
                  onClicked: () {
                    pickDateTime(pickDate: true);
                  }),
            ),
            Expanded(
              child: buildDropdownField(
                  text: DateFormat.Hm().format(from),
                  onClicked: () {
                    pickDateTime(pickDate: false);
                  }),
            ),
          ],
        ));
  }

  Future pickDateTime({required bool pickDate}) async {
    final date = await _pickDateTime(from, pickDate: pickDate);
    if (date == null) return;
    setState(() {
      from = date;
    });
  }

  Future<DateTime?> _pickDateTime(DateTime initialDate,
      {required bool pickDate, DateTime? firstDate}) async {
    if (pickDate) {
      final date = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate ?? DateTime(2015, 8),
        lastDate: DateTime(2101),
      );

      if (date == null) return null;
      final time =
          Duration(hours: initialDate.hour, minutes: initialDate.minute);
      return date.add(time);
    } else {
      final timeOfDay = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDate),
      );

      if (timeOfDay == null) return null;

      final date =
          DateTime(initialDate.year, initialDate.month, initialDate.day);

      final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);
      return date.add(time);
    }
  }

  Widget buildDropdownField({
    required String text,
    required VoidCallback onClicked,
  }) {
    return ListTile(
      title: Text(text),
      trailing: Icon(Icons.arrow_drop_down),
      onTap: onClicked,
    );
  }

  Widget buildHeader({required String header, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          header,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        child,
      ],
    );
  }

  Future saveForm() async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      final event = Event(
          from: from,
          duration: double.parse(durationController.text),
          location: 'Location 1',
          title: titleController.text,
          description: 'Description');

      final provider = Provider.of<EventProvider>(context, listen: false);
      provider.addEvent(event);

      Navigator.of(context).pop();
    }
  }
}
