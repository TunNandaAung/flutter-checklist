import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:checklist/todo/bloc/todos_bloc/todos_bloc.dart';
import 'package:checklist/todo/todos_repository/lib/todos_barrel.dart';
import 'package:equatable/equatable.dart';

part 'stats_event.dart';
part 'stats_state.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  StreamSubscription _todosSubscription;

  StatsBloc({TodosBloc todosBloc})
      : assert(todosBloc != null),
        super(StatsLoading()) {
    void onTodosStateChanged(state) {
      if (state is TodosLoaded) {
        add(UpdateStats(state.todos));
      }
    }

    onTodosStateChanged(todosBloc.state);
    _todosSubscription = todosBloc.stream.listen(onTodosStateChanged);
  }

  @override
  Stream<StatsState> mapEventToState(StatsEvent event) async* {
    if (event is UpdateStats) {
      final numActive =
          event.todos.where((todo) => !todo.complete).toList().length;
      final numCompleted =
          event.todos.where((todo) => todo.complete).toList().length;
      yield StatsLoaded(numActive, numCompleted);
    }
  }

  @override
  Future<void> close() {
    _todosSubscription?.cancel();
    return super.close();
  }
}
