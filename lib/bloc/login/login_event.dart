import 'package:equatable/equatable.dart';
import 'package:podcastapp/model/repository/vo/login_request.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class Login extends LoginEvent {
  final LoginRequest request;

  Login(this.request);

  @override
  List<Object> get props => [request];
}
