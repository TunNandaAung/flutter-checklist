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
            title: Text(title, style: Theme.of(context).textTheme.headline1),
            content: Text(
              body,
              style: Theme.of(context).textTheme.headline2,
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(DialogAction.abort),
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context)
                      .floatingActionButtonTheme
                      .backgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
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
