import 'package:firebase_integrations/todo/modal/edit_password_form.dart';
import 'package:flutter/material.dart';

class EditPasswordModal {
  mainBottomSheet(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return EditPasswordForm();
        });
  }
}
