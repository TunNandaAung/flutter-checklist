import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:checklist/data/user_repository.dart';
import 'package:checklist/utils/validators.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:stream_transform/stream_transform.dart';

part 'register_event.dart';
part 'register_state.dart';

const throttleDuration = Duration(milliseconds: 300);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository _userRepository;

  RegisterBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(RegisterState.empty()) {
    on<EmailChanged>(
      _onEmailChanged,
      transformer: throttleDroppable(throttleDuration),
    );
    on<PasswordChanged>(
      _onPasswordChanged,
      transformer: throttleDroppable(throttleDuration),
    );
    on<NameChanged>(
      _onNameChanged,
      transformer: throttleDroppable(throttleDuration),
    );
    on<Submitted>(_onSubmitted);
  }

  Future<void> _onNameChanged(
      NameChanged event, Emitter<RegisterState> emit) async {
    emit(
      state.update(
        isNameValid: Validators.isValidName(event.name),
      ),
    );
  }

  Future<void> _onEmailChanged(
      EmailChanged event, Emitter<RegisterState> emit) async {
    emit(
      state.update(
        isEmailValid: Validators.isValidEmail(event.email),
      ),
    );
  }

  Future<void> _onPasswordChanged(
      PasswordChanged event, Emitter<RegisterState> emit) async {
    emit(
      state.update(
        isPasswordValid: Validators.isValidPassword(event.password),
      ),
    );
  }

  Future<void> _onSubmitted(
      Submitted event, Emitter<RegisterState> emit) async {
    emit(RegisterState.loading());
    try {
      await _userRepository.signUp(
        name: event.name,
        email: event.email,
        password: event.password,
      );
      emit(RegisterState.success());
    } catch (e) {
      print(e);
      emit(RegisterState.failure());
    }
  }
}
