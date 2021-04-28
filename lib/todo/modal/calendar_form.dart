import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

typedef OnSaveCallback = Function(String task, String note);

class CalendarForm extends StatefulWidget {
  @override
  _CalendarFormState createState() => _CalendarFormState();
}

class _CalendarFormState extends State<CalendarForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  void initState() {
    super.initState();
  }

  DateTime dateTime;

  DateTime _selectedTime;
  DateTime _focusedDay = DateTime.now();

  @override
  void dispose() {
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
              color: Theme.of(context).highlightColor,
              offset: Offset(3.0, 6.0),
              blurRadius: 10.0)
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
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, dateTime);
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: Theme.of(context).buttonColor,
                                onSurface: Colors.grey,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                              ),
                              child: Text('Add',
                                  style: Theme.of(context).textTheme.button),
                            )
                          ],
                        ),
                        SizedBox(height: 12.0),
                        TableCalendar(
                          calendarFormat: _calendarFormat,
                          onFormatChanged: (format) {
                            setState(() {
                              _calendarFormat = format;
                            });
                          },
                          daysOfWeekStyle: DaysOfWeekStyle(
                            weekdayStyle: TextStyle(
                              decoration: TextDecoration.none,
                            ),
                            weekendStyle: TextStyle(
                              decoration: TextDecoration.none,
                            ),
                          ),
                          headerStyle: HeaderStyle(
                            titleTextStyle:
                                TextStyle(decoration: TextDecoration.none),
                            formatButtonTextStyle:
                                TextStyle(decoration: TextDecoration.none),
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
                          firstDay: DateTime.now().subtract(Duration(days: 1)),
                          lastDay: DateTime.utc(2030, 3, 14),
                          focusedDay: _focusedDay,
                          selectedDayPredicate: (day) {
                            return isSameDay(dateTime, day);
                          },
                          onPageChanged: (focusedDay) {
                            _focusedDay = focusedDay;
                          },
                          onDaySelected: (selectedDay, focusedDay) {
                            setState(() {
                              _focusedDay = focusedDay;
                              dateTime = selectedDay;
                            });

                            print(_focusedDay);
                          },
                        ),
                        SizedBox(height: 30.0),
                        GestureDetector(
                          onTap: () {
                            CupertinoRoundedDatePicker.show(context,
                                fontFamily: 'Poppins-Medium',
                                borderRadius: 8.0,
                                textColor: Theme.of(context).dividerColor,
                                initialDatePickerMode:
                                    CupertinoDatePickerMode.time,
                                background: Theme.of(context).canvasColor,
                                onDateTimeChanged: (newTime) {
                              dateTime = new DateTime(
                                  dateTime == null
                                      ? DateTime.now().year
                                      : dateTime.year,
                                  dateTime == null
                                      ? DateTime.now().month
                                      : dateTime.month,
                                  dateTime == null
                                      ? DateTime.now().day
                                      : dateTime.day,
                                  newTime.hour,
                                  newTime.minute,
                                  newTime.second,
                                  newTime.millisecond,
                                  newTime.microsecond);

                              print(dateTime);

                              setState(() {
                                _selectedTime = dateTime;
                              });
                            });
                          },
                          child: Container(
                            width: double.infinity,
                            height: null,
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context).highlightColor,
                                  offset: Offset(0, 10),
                                  blurRadius: 30,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 15.0),
                                child: Row(
                                  children: <Widget>[
                                    Icon(Icons.access_time,
                                        color: Theme.of(context).hintColor),
                                    SizedBox(width: 15.0),
                                    _selectedTime == null
                                        ? Text(
                                            'Set time',
                                            style: Theme.of(context)
                                                .inputDecorationTheme
                                                .hintStyle,
                                          )
                                        : Text(
                                            DateFormat('hh:mm a').format(
                                                _selectedTime.toLocal()),
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline1,
                                          ),
                                    SizedBox(width: 30.0),
                                    Spacer(),
                                    _selectedTime != null
                                        ? Container(
                                            width: 23.0,
                                            height: 23.0,
                                            decoration: BoxDecoration(
                                              color:
                                                  Theme.of(context).hintColor,
                                              shape: BoxShape.circle,
                                            ),
                                            child: RawMaterialButton(
                                              shape: CircleBorder(),
                                              child: Icon(
                                                Icons.close,
                                                size: 20.0,
                                                color: Colors.white,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _selectedTime = null;
                                                });
                                              },
                                            ),
                                          )
                                        : Container()
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
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
