import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:checklist/data/user_repository.dart';
import 'package:checklist/todo/todos_repository/lib/todos_barrel.dart';
import 'package:equatable/equatable.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final TodosRepository _todosRepository;
  final UserRepository _userRepository;

  StreamSubscription? _todosSubscription;

  TodosBloc(this._userRepository, {required TodosRepository todosRepository})
      : _todosRepository = todosRepository,
        super(TodosLoading()) {
    on<LoadTodos>(_onLoadTodos);
    on<AddTodo>(_onAddTodo);
    on<UpdateTodo>(_onUpdateTodo);
    on<DeleteTodo>(_onDeleteTodo);
    on<ToggleAll>(_onToggleAll);
    on<ClearCompleted>(_onClearCompleted);
    on<TodosUpdated>(_onTodosUpdate);
  }

  Future<void> _onLoadTodos(LoadTodos event, Emitter<TodosState> emit) async {
    _todosSubscription?.cancel();
    final user = await _userRepository.getUser();
    _todosSubscription = _todosRepository.todos(user!.uid).listen(
          (todos) => add(TodosUpdated(todos)),
        );
  }

  Future<void> _onAddTodo(AddTodo event, Emitter<TodosState> emit) async {
    _todosRepository.addNewTodo(event.todo);
  }

  Future<void> _onUpdateTodo(UpdateTodo event, Emitter<TodosState> emit) async {
    _todosRepository.updateTodo(event.updatedTodo);
  }

  Future<void> _onDeleteTodo(DeleteTodo event, Emitter<TodosState> emit) async {
    _todosRepository.deleteTodo(event.todo);
  }

  Future<void> _onToggleAll(ToggleAll event, Emitter<TodosState> emit) async {
    final currentState = state;
    if (currentState is TodosLoaded) {
      final allComplete = currentState.todos.every((todo) => todo.complete);
      final List<Todo> updatedTodos = currentState.todos
          .map((todo) =>
              todo.copyWith(complete: !allComplete, userId: event.userId))
          .toList();
      updatedTodos.forEach((updatedTodo) {
        _todosRepository.updateTodo(updatedTodo);
      });
    }
  }

  Future<void> _onClearCompleted(
      ClearCompleted event, Emitter<TodosState> emit) async {
    final currentState = state;
    if (currentState is TodosLoaded) {
      final List<Todo> completedTodos =
          currentState.todos.where((todo) => todo.complete).toList();
      completedTodos.forEach((completedTodo) {
        _todosRepository.deleteTodo(completedTodo);
      });
    }
  }

  Future<void> _onTodosUpdate(
      TodosUpdated event, Emitter<TodosState> emit) async {
    emit(TodosLoaded(event.todos));
  }

  @override
  Future<void> close() {
    _todosSubscription?.cancel();
    return super.close();
  }
}
