import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:checklist/todo/bloc/todos_bloc/todos_bloc.dart';
import 'package:checklist/todo/model/models.dart';
import 'package:checklist/todo/todos_repository/lib/src/models/models.dart';
import 'package:equatable/equatable.dart';

part 'filtered_todos_event.dart';
part 'filtered_todos_state.dart';

class FilteredTodosBloc extends Bloc<FilteredTodosEvent, FilteredTodosState> {
  final TodosBloc _todosBloc;
  StreamSubscription? _todosSubscription;

  FilteredTodosBloc({required TodosBloc todosBloc})
      : _todosBloc = todosBloc,
        super(todosBloc.state is TodosLoaded
            ? FilteredTodosLoaded(
                (todosBloc.state as TodosLoaded).todos,
                VisibilityFilter.all,
              )
            : FilteredTodosLoading()) {
    on<UpdateFilter>(_onUpdateFilter);
    on<UpdateTodos>(_onTodosUpdated);

    _todosSubscription = todosBloc.stream.listen((state) {
      if (state is TodosLoaded) {
        add(UpdateTodos((todosBloc.state as TodosLoaded).todos));
      }
    });
  }

  Future<void> _onUpdateFilter(
    UpdateFilter event,
    Emitter<FilteredTodosState> emit,
  ) async {
    final currentState = _todosBloc.state;
    if (currentState is TodosLoaded) {
      emit(
        FilteredTodosLoaded(
          _mapTodosToFilteredTodos(currentState.todos, event.filter),
          event.filter,
        ),
      );
    }
  }

  Future<void> _onTodosUpdated(
    UpdateTodos event,
    Emitter<FilteredTodosState> emit,
  ) async {
    final visibilityFilter = state is FilteredTodosLoaded
        ? (state as FilteredTodosLoaded).activeFilter
        : VisibilityFilter.all;
    emit(
      FilteredTodosLoaded(
        _mapTodosToFilteredTodos(
          (_todosBloc.state as TodosLoaded).todos,
          visibilityFilter,
        ),
        visibilityFilter,
      ),
    );
  }

  List<Todo> _mapTodosToFilteredTodos(
      List<Todo> todos, VisibilityFilter filter) {
    return todos.where((todo) {
      if (filter == VisibilityFilter.all) {
        return true;
      } else if (filter == VisibilityFilter.active) {
        return !todo.complete;
      } else {
        return todo.complete;
      }
    }).toList();
  }

  @override
  Future<void> close() {
    _todosSubscription?.cancel();
    return super.close();
  }
}
