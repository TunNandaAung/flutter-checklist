import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

typedef OnSaveCallback = Function(String task, String note);

class CalendarForm extends StatefulWidget {
  const CalendarForm({super.key});

  @override
  CalendarFormState createState() => CalendarFormState();
}

class CalendarFormState extends State<CalendarForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  void initState() {
    super.initState();
  }

  DateTime? dateTime;

  DateTime? _selectedTime;
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
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
              color: Theme.of(context).highlightColor,
              offset: const Offset(3.0, 6.0),
              blurRadius: 10.0)
        ],
        color: Theme.of(context).canvasColor,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Form(
                key: _formKey,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Text(
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
                              backgroundColor:
                                  Theme.of(context).primaryColorLight,
                              disabledBackgroundColor: Colors.grey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                            ),
                            child: Text('Add',
                                style: Theme.of(context).textTheme.button),
                          )
                        ],
                      ),
                      const SizedBox(height: 12.0),
                      TableCalendar(
                        calendarFormat: _calendarFormat,
                        onFormatChanged: (format) {
                          setState(() {
                            _calendarFormat = format;
                          });
                        },
                        daysOfWeekStyle: const DaysOfWeekStyle(
                          weekdayStyle: TextStyle(
                            decoration: TextDecoration.none,
                          ),
                          weekendStyle: TextStyle(
                            decoration: TextDecoration.none,
                          ),
                        ),
                        headerStyle: HeaderStyle(
                          titleTextStyle:
                              const TextStyle(decoration: TextDecoration.none),
                          formatButtonTextStyle:
                              const TextStyle(decoration: TextDecoration.none),
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
                        firstDay:
                            DateTime.now().subtract(const Duration(days: 1)),
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
                      const SizedBox(height: 30.0),
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
                            dateTime = DateTime(
                                dateTime == null
                                    ? DateTime.now().year
                                    : dateTime!.year,
                                dateTime == null
                                    ? DateTime.now().month
                                    : dateTime!.month,
                                dateTime == null
                                    ? DateTime.now().day
                                    : dateTime!.day,
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
                                offset: const Offset(0, 10),
                                blurRadius: 30,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 15.0),
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.access_time,
                                      color: Theme.of(context).hintColor),
                                  const SizedBox(width: 15.0),
                                  _selectedTime == null
                                      ? Text(
                                          'Set time',
                                          style: Theme.of(context)
                                              .inputDecorationTheme
                                              .hintStyle,
                                        )
                                      : Text(
                                          DateFormat('hh:mm a')
                                              .format(_selectedTime!.toLocal()),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline1,
                                        ),
                                  const SizedBox(width: 30.0),
                                  const Spacer(),
                                  _selectedTime != null
                                      ? Container(
                                          width: 23.0,
                                          height: 23.0,
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).hintColor,
                                            shape: BoxShape.circle,
                                          ),
                                          child: RawMaterialButton(
                                            shape: const CircleBorder(),
                                            child: const Icon(
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
    );
  }
}
