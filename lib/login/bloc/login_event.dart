import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class EmailChanged extends LoginEvent {
  final String email;

  const EmailChanged({@required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'EmailChanged { email :$email }';
}

class PasswordChanged extends LoginEvent {
  final String password;

  const PasswordChanged({@required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'PasswordChanged { password: $password }';
}

class Submitted extends LoginEvent {
  final String email;
  final String password;

  const Submitted({
    @required this.email,
    @required this.password,
  });

  @override
  List<Object> get props => [email, password];

  @override
  String toString() {
    return 'Submitted { email: $email, password: $password }';
  }
}

class LoginWithGooglePressed extends LoginEvent {}

class LoginWithCredentialsPressed extends LoginEvent {
  final String email;
  final String password;

  const LoginWithCredentialsPressed({
    @required this.email,
    @required this.password,
  });

  @override
  List<Object> get props => [email, password];

  @override
  String toString() {
    return 'LoginWithCredentialsPressed { email: $email, password: $password }';
  }
}

class SendOTPPressed extends LoginEvent {
  final String phoneNumber;

  const SendOTPPressed({@required this.phoneNumber});

  @override
  List<Object> get props => [phoneNumber];

  @override
  String toString() {
    return 'SendOTPPressed { phoneNumber: $phoneNumber}';
  }
}

class VerifyOtpEvent extends LoginEvent {
  final String otp;

  const VerifyOtpEvent({@required this.otp});

  @override
  List<Object> get props => [otp];

  @override
  String toString() {
    return 'VerifyOtpEvent { otp: $otp}';
  }
}

class PhoneChanged extends LoginEvent {
  final String phone;

  const PhoneChanged({@required this.phone});

  @override
  List<Object> get props => [phone];

  @override
  String toString() => 'PhoneChanged { Phone: $phone }';
}

class OtpSentEvent extends LoginEvent {}

class OtpErrorEvent extends LoginEvent {}

class ResetLoginEvent extends LoginEvent {}
