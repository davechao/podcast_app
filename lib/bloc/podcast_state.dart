import 'package:equatable/equatable.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class PodCastState extends Equatable {
  const PodCastState();

  @override
  List<Object> get props => [];
}

class Loading extends PodCastState {}

class DataEmpty extends PodCastState {}

class Error extends PodCastState {
  final String exception;

  Error([this.exception]) : assert(exception != null);

  @override
  List<Object> get props => [exception];
}

class Success extends PodCastState {
  final String podCastListItem;

  Success({this.podCastListItem}) : assert(podCastListItem != null);

  @override
  List<Object> get props => [podCastListItem];
}
