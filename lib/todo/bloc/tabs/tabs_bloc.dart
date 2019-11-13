import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_integrations/todo/bloc/tabs/tabs_barrel.dart';
import 'package:firebase_integrations/todo/model/models.dart';

class TabBloc extends Bloc<TabEvent, AppTab> {
  @override
  AppTab get initialState => AppTab.todos;

  @override
  Stream<AppTab> mapEventToState(TabEvent event) async* {
    if (event is UpdateTab) {
      yield event.tab;
    }
  }
}
