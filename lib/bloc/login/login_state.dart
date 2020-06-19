import 'package:equatable/equatable.dart';
import 'package:podcastapp/model/repository/vo/login_item.dart';

class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class Loading extends LoginState {}

class DataEmpty extends LoginState {}

class Error extends LoginState {}

class Success extends LoginState {
  final LoginItem loginItem;

  Success([this.loginItem]) : assert(loginItem != null);

  @override
  List<Object> get props => [loginItem];
}

class UpdateAnimationResult extends LoginState {
  final String type;

  UpdateAnimationResult([this.type]) : assert(type != null);

  @override
  List<Object> get props => [type];
}
