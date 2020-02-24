import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

typedef OnSaveCallback = Function(String task, String note);

class CalendarForm extends StatefulWidget {
  @override
  _CalendarFormState createState() => _CalendarFormState();
}

class _CalendarFormState extends State<CalendarForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  CalendarController _calendarController;

  @override
  void initState() {
    _calendarController = CalendarController();
    super.initState();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 600,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
              color: Colors.black12, offset: Offset(3.0, 6.0), blurRadius: 10.0)
        ],
        color: Theme.of(context).canvasColor,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                  fontFamily: "Poppins-Medium",
                                  fontSize: 18.0,
                                  color: Color(0xFF5d74e3),
                                ),
                              ),
                            ),
                            FlatButton(
                              onPressed: () {},
                              color: Theme.of(context).buttonColor,
                              disabledColor: Colors.grey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              child: Text('Add',
                                  style: Theme.of(context).textTheme.button),
                            )
                          ],
                        ),
                        SizedBox(height: 12.0),
                        TableCalendar(
                          headerStyle: HeaderStyle(
                            leftChevronIcon: Icon(
                              Icons.arrow_back_ios,
                              size: 18.0,
                              color: Theme.of(context).dividerColor,
                            ),
                            rightChevronIcon: Icon(
                              Icons.arrow_forward_ios,
                              size: 18.0,
                              color: Theme.of(context).dividerColor,
                            ),
                          ),
                          calendarController: _calendarController,
                          onDaySelected: (day, event) {
                            // print(DateFormat('EEE d MMM hh:mm:ss a')
                            //     .format(day.toLocal()));
                            Navigator.pop(context, day);
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
