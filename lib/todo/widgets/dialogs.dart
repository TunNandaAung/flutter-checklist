import 'package:flutter/material.dart';

enum DialogAction { close, abort }

class Dialogs {
  static Future<DialogAction> passwordResetDialog(
      BuildContext context, String title, String body) async {
    final action = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Theme.of(context).cardColor,
            title: Text(title, style: Theme.of(context).textTheme.display1),
            content: Text(
              body,
              style: Theme.of(context).textTheme.display3,
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(DialogAction.abort),
                color:
                    Theme.of(context).floatingActionButtonTheme.backgroundColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0)),
                child: Text(
                  'Close',
                  style: Theme.of(context).textTheme.button,
                ),
              ),
            ],
          );
        });

    return (action != null) ? action : DialogAction.abort;
  }
}
