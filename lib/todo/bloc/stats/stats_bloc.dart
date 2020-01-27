import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:checklist/todo/bloc/stats/stats_barrel.dart';
import 'package:checklist/todo/bloc/todos_bloc/todos_bloc_barrel.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  StreamSubscription _todosSubscription;

  StatsBloc({TodosBloc todosBloc}) : assert(todosBloc != null) {
    _todosSubscription = todosBloc.listen((state) {
      if (state is TodosLoaded) {
        add(UpdateStats(state.todos));
      }
    });
  }

  @override
  StatsState get initialState => StatsLoading();

  @override
  Stream<StatsState> mapEventToState(StatsEvent event) async* {
    if (event is UpdateStats) {
      int numActive =
          event.todos.where((todo) => !todo.complete).toList().length;
      int numCompleted =
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
