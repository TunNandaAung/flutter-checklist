import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'connectivity_event.dart';
part 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final ConnectivityResult result;

  StreamSubscription _connectivitySubscription;

  ConnectivityBloc({@required this.result}) : super(Offline()) {
    Connectivity().onConnectivityChanged.listen((result) {
      add(ConnectivityChanged(result: result));
    });
    on<ConnectivityChanged>(_onConnectivityChanged);
  }

  Future<void> _onConnectivityChanged(
    ConnectivityChanged event,
    Emitter<ConnectivityState> emit,
  ) async {
    if (event.result == ConnectivityResult.mobile) {
      emit(Mobile());
    } else if (event.result == ConnectivityResult.wifi) {
      emit(WiFi());
    } else
      emit(Offline());
  }

  @override
  Future<void> close() {
    _connectivitySubscription?.cancel();
    return super.close();
  }
}
