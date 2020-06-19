import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podcastapp/bloc/login/login_event.dart';
import 'package:podcastapp/bloc/login/login_state.dart';
import 'package:podcastapp/model/repository/account_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AccountRepository repository;

  LoginBloc({
    @required this.repository,
  });

  @override
  LoginState get initialState => Loading();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is Login) {
      try {
        final loginItem = await repository.login(event.request);
        yield Success(loginItem);
      } catch (error) {
        Fimber.e("Error: $error");
        yield Error();
      }
    } else if (event is UpdateAnimation) {
      yield UpdateAnimationResult(event.type);
    }
  }
}
