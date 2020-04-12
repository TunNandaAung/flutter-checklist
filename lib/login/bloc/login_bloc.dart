import 'dart:async';

import 'package:checklist/data/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:checklist/login/bloc/login_barrel.dart';
import 'package:checklist/utils/validators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository _userRepository;

  LoginBloc({
    @required UserRepository userRepository,
  })  : assert(userRepository != null),
        _userRepository = userRepository;

  String verID = "";
  StreamSubscription subscription;

  @override
  LoginState get initialState => LoginState.empty();

  @override
  Stream<LoginState> transformEvents(
    Stream<LoginEvent> events,
    Stream<LoginState> Function(LoginEvent event) next,
  ) {
    final observableStream = events as Observable<LoginEvent>;
    final nonDebounceStream = observableStream.where((event) {
      return (event is! EmailChanged &&
          event is! PasswordChanged &&
          event is! PhoneChanged);
    });
    final debounceStream = observableStream.where((event) {
      return (event is EmailChanged ||
          event is PasswordChanged ||
          event is PhoneChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super
        .transformEvents(nonDebounceStream.mergeWith([debounceStream]), next);
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is LoginWithGooglePressed) {
      yield* _mapLoginWithGooglePressedToState();
    } else if (event is LoginWithCredentialsPressed) {
      yield* _mapLoginWithCredentialsPressedToState(
        email: event.email,
        password: event.password,
      );
    } else if (event is ResetLoginEvent) {
      yield LoginState.empty();
    } else if (event is PhoneChanged) {
      yield* _mapPhoneChangedToState(event.phone);
    } else if (event is SendOTPPressed) {
      yield* _mapSendOTPPressedToState(event.phoneNumber);
    } else if (event is OtpSentEvent) {
      yield* _mapOtpSentEventToState();
    } else if (event is VerifyOtpEvent) {
      yield LoginState.loading();
      try {
        AuthResult result =
            await _userRepository.verifyAndLogin(verID, event.otp);
        if (result.user != null) {
          yield LoginState.success();
        }
      } catch (e) {
        yield LoginState.failure();
        print(e);
      }
    } else if (event is OtpErrorEvent) {
      yield LoginState.failure();
    }
  }

  Stream<LoginState> _mapEmailChangedToState(String email) async* {
    yield state.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<LoginState> _mapPasswordChangedToState(String password) async* {
    yield state.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }

  Stream<LoginState> _mapLoginWithGooglePressedToState() async* {
    try {
      await _userRepository.signInWithGoogle();
      yield LoginState.success();
    } catch (_) {
      yield LoginState.failure();
    }
  }

  Stream<LoginState> _mapLoginWithCredentialsPressedToState({
    String email,
    String password,
  }) async* {
    yield LoginState.loading();
    try {
      await _userRepository.signInWithCredentials(email, password);
      yield LoginState.success();
    } catch (_) {
      yield LoginState.failure();
    }
  }

  Stream<LoginState> _mapPhoneChangedToState(String phone) async* {
    yield state.update(
      isPhoneValid: Validators.isValidPhone(phone),
    );
  }

  Stream<LoginState> _mapSendOTPPressedToState(String phoneNumber) async* {
    yield LoginState.loading();
    print('phoneNumber');
    try {
      subscription = sendOtp(phoneNumber).listen((event) {
        add(event);
      });
    } catch (_) {
      yield LoginState.failure();
    }
  }

  Stream<LoginState> _mapOtpSentEventToState() async* {
    yield LoginState.otpSent();
  }

  Stream<LoginEvent> sendOtp(String phoneNumber) async* {
    StreamController<LoginEvent> eventStream = StreamController();
    final phoneVerificationCompleted = (AuthCredential authCredential) {
      _userRepository.getUser();
      _userRepository.getUser().catchError((onError) {
        eventStream.add(OtpErrorEvent());
        print('OnError' + onError);
      }).then((user) {
        eventStream.close();
      });
    };
    final phoneVerificationFailed = (AuthException authException) {
      print('Excepion:' + authException.message);
      eventStream.add(OtpErrorEvent());
      eventStream.close();
    };
    final phoneCodeSent = (String verId, [int forceResent]) {
      this.verID = verId;
      eventStream.add(OtpSentEvent());
    };
    final phoneCodeAutoRetrievalTimeout = (String verid) {
      this.verID = verid;
      eventStream.close();
    };

    await _userRepository.sendOtp(
      phoneNumber,
      Duration(seconds: 1),
      phoneVerificationFailed,
      phoneVerificationCompleted,
      phoneCodeSent,
      phoneCodeAutoRetrievalTimeout,
    );

    yield* eventStream.stream;
  }
}
