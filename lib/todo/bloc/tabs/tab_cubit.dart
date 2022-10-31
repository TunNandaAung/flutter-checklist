import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:checklist/todo/model/models.dart';

class TabCubit extends Cubit<AppTab> {
  TabCubit() : super(AppTab.todos);

  Future<void> updateTab(AppTab tab) async {
    emit(tab);
  }
}
