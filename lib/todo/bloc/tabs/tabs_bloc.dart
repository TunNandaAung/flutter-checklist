import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:checklist/todo/bloc/tabs/tabs_barrel.dart';
import 'package:checklist/todo/model/models.dart';

class TabBloc extends Bloc<TabEvent, AppTab> {
  TabBloc() : super(AppTab.todos);

  @override
  Stream<AppTab> mapEventToState(TabEvent event) async* {
    if (event is UpdateTab) {
      yield event.tab;
    }
  }
}
