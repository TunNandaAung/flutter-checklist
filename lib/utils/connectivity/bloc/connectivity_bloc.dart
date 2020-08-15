import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:checklist/utils/connectivity/bloc/connectivity_barrel.dart';
import 'package:meta/meta.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  ConnectivityBloc({@required this.result}) : super(Offline());

  final ConnectivityResult result;

  StreamSubscription _connectivitySubscription;

  @override
  Stream<ConnectivityState> mapEventToState(ConnectivityEvent event) async* {
    _connectivitySubscription?.cancel();

    if (event is ConnectivityChanged) {
      yield* _mapConnectivityChangedToState(event);
    } else
      Connectivity().onConnectivityChanged.listen((result) {
        add(ConnectivityChanged(result: result));
      });
  }

  Stream<ConnectivityState> _mapConnectivityChangedToState(
      ConnectivityChanged event) async* {
    if (event.result == ConnectivityResult.mobile) {
      yield Mobile();
    } else if (event.result == ConnectivityResult.wifi) {
      yield WiFi();
    } else
      yield Offline();
  }

  @override
  Future<void> close() {
    _connectivitySubscription?.cancel();
    return super.close();
  }
}
