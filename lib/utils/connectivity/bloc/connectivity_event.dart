import 'package:connectivity/connectivity.dart';
import 'package:equatable/equatable.dart';

abstract class ConnectivityEvent extends Equatable {
  const ConnectivityEvent();

  List<Object> get props => [];
}

class CheckConnectivity extends ConnectivityEvent {}

class ConnectivityChanged extends ConnectivityEvent {
  final ConnectivityResult result;

  const ConnectivityChanged({this.result}) : assert(result != null);

  List<Object> get props => [result];
}
