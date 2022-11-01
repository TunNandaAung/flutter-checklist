import 'package:checklist/data/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:checklist/utils/validators.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:stream_transform/stream_transform.dart';

part 'login_event.dart';
part 'login_state.dart';

const throttleDuration = Duration(milliseconds: 300);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository _userRepository;

  LoginBloc({
    required UserRepository userRepository,
  })  : assert(userRepository != null),
        _userRepository = userRepository,
        super(LoginState.empty()) {
    on<EmailChanged>(
      _onEmailChanged,
      transformer: throttleDroppable(throttleDuration),
    );
    on<PasswordChanged>(
      _onPasswordChanged,
      transformer: throttleDroppable(throttleDuration),
    );
    on<ForgotPasswordPressed>(_onForgotPasswordPressed);
    on<LoginWithGooglePressed>(_onLoginWithGooglePressed);
    on<LoginWithCredentialsPressed>(_onLoginWithCredentialsPressed);
  }

  Future<void> _onEmailChanged(
      EmailChanged event, Emitter<LoginState> emit) async {
    emit(state.update(
      isEmailValid: Validators.isValidEmail(event.email),
    ));
  }

  Future<void> _onPasswordChanged(
      PasswordChanged event, Emitter<LoginState> emit) async {
    emit(state.update(
      isPasswordValid: Validators.isValidPassword(event.password),
    ));
  }

  Future<void> _onLoginWithGooglePressed(
      LoginWithGooglePressed event, Emitter<LoginState> emit) async {
    try {
      await _userRepository.signInWithGoogle();
      emit(LoginState.success());
    } catch (_) {
      emit(LoginState.failure());
    }
  }

  Future<void> _onForgotPasswordPressed(
      ForgotPasswordPressed event, Emitter<LoginState> emit) async {
    try {
      await _userRepository.resetPassword(event.email);
      emit(LoginState.passwordResetMailSent());
    } catch (_) {
      emit(LoginState.passwordResetFailure());
    }
  }

  Future<void> _onLoginWithCredentialsPressed(
      LoginWithCredentialsPressed event, Emitter<LoginState> emit) async {
    emit(LoginState.loading());
    try {
      await _userRepository.signInWithCredentials(event.email, event.password);
      emit(LoginState.success());
    } catch (_) {
      emit(LoginState.failure());
    }
  }
}
