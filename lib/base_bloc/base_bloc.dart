import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseBloc<E, S extends ErrorState> extends Bloc<E, S> {
  BaseBloc(super.initialState) {
    on<E>(
      _eventHandler,
    );
  }

  FutureOr<void> _eventHandler(E event, Emitter<S> emit) async {
    try {
      await eventHandlerMethod(event, emit);
    } on DioException catch (dioError) {
      debugPrint('============ eventHandler DioException: ${dioError.response?.data.toString()}');
      final err = dioError.response?.data as Map<String, dynamic>;
      if (err.containsKey("error")) {
        emit(getErrorState()
          ..errorCode = dioError.response?.statusCode ?? 0
          ..errorMsg = err["error"]);
      } else {
        emit(getErrorState()
          ..errorCode = dioError.response?.statusCode ?? 0
          ..errorMsg = err.toString());
      }
    } catch (err) {
      debugPrint('============ eventHandler catch block: $err');
      emit(getErrorState()
        ..errorCode = 0
        ..errorMsg = err.toString());
    }
  }

  Future<void> eventHandlerMethod(E event, Emitter<S> emit);

  S getErrorState();
}

abstract class ErrorState {
  int errorCode = 0;
  String errorMsg = "";
}


class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    debugPrint('${bloc.runtimeType} $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    debugPrint('onTransition -- bloc: ${bloc.runtimeType}, transition: $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    debugPrint('onError -- bloc: ${bloc.runtimeType}, error: $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    debugPrint('onClose -- bloc: ${bloc.runtimeType}');
  }
}