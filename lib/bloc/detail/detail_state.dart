import 'package:equatable/equatable.dart';

class DetailState extends Equatable {
  const DetailState();

  @override
  List<Object> get props => [];
}

class Loading extends DetailState {}

class DataEmpty extends DetailState {}

class Error extends DetailState {
  final String exception;

  Error([this.exception]) : assert(exception != null);

  @override
  List<Object> get props => [exception];
}

class Success extends DetailState {
  final String podCasts;

  Success([this.podCasts]) : assert(podCasts != null);

  @override
  List<Object> get props => [podCasts];
}
