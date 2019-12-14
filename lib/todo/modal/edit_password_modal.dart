import 'package:firebase_integrations/todo/modal/edit_password_form.dart';
import 'package:flutter/material.dart';

typedef OnSaveCallback = Function(String currentPassword, String newPassword);

class EditPasswordModal {
  mainBottomSheet({BuildContext context, OnSaveCallback onSave}) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return EditPasswordForm(onSave: onSave);
        });
  }
}
