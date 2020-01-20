import 'package:equatable/equatable.dart';

abstract class ConnectivityState extends Equatable {
  const ConnectivityState();

  @override
  List<Object> get props => [];
}

class Offline extends ConnectivityState {}

class Mobile extends ConnectivityState {}

class WiFi extends ConnectivityState {}
