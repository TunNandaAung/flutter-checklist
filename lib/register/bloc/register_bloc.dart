import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:checklist/data/user_repository.dart';
import 'package:checklist/register/bloc/register_barrel.dart';
import 'package:checklist/utils/validators.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository _userRepository;

  RegisterBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  RegisterState get initialState => RegisterState.empty();

  @override
  Stream<RegisterState> transformEvents(
    Stream<RegisterEvent> events,
    Stream<RegisterState> Function(RegisterEvent event) next,
  ) {
    final observableStream = events as Observable<RegisterEvent>;
    final nonDebounceStream = observableStream.where((event) {
      return (event is! EmailChanged &&
          event is! PasswordChanged &&
          event is! NameChanged);
    });
    final debounceStream = observableStream.where((event) {
      return (event is EmailChanged ||
          event is PasswordChanged ||
          event is NameChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super
        .transformEvents(nonDebounceStream.mergeWith([debounceStream]), next);
  }

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is NameChanged) {
      yield* _mapNameChangedToState(event.name);
    } else if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is Submitted) {
      yield* _mapFormSubmittedToState(event.name, event.email, event.password);
    }
  }

  Stream<RegisterState> _mapNameChangedToState(String name) async* {
    yield state.update(
      isNameValid: Validators.isValidName(name),
    );
  }

  Stream<RegisterState> _mapEmailChangedToState(String email) async* {
    yield state.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<RegisterState> _mapPasswordChangedToState(String password) async* {
    yield state.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }

  Stream<RegisterState> _mapFormSubmittedToState(
      String name, String email, String password) async* {
    yield RegisterState.loading();
    try {
      await _userRepository.signUp(
        name: name,
        email: email,
        password: password,
      );
      yield RegisterState.success();
    } catch (e) {
      print(e);
      yield RegisterState.failure();
    }
  }
}
