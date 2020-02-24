import 'package:checklist/todo/modal/calendar_form.dart';
import 'package:flutter/material.dart';

typedef OnSaveCallback = Function(String task, String note);

class CalendarModal {
  final Function(DateTime) onDateSelected;
  CalendarModal({this.onDateSelected});

  mainBottomSheet(BuildContext context, String userId) async {
    DateTime dateTime = await showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return CalendarForm();
        });
    onDateSelected(dateTime);
  }
}
