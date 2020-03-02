import 'package:equatable/equatable.dart';

class PodCastState extends Equatable {
  const PodCastState();

  @override
  List<Object> get props => [];
}

class Loading extends PodCastState {}

class DataEmpty extends PodCastState {}

class Error extends PodCastState {}

class Success extends PodCastState {
  final String podCastListItem;

  Success({this.podCastListItem}) : assert(podCastListItem != null);

  @override
  List<Object> get props => [podCastListItem];
}