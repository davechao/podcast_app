import 'package:equatable/equatable.dart';
import 'package:podcastapp/model/vo/podcast_list_item.dart';

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
  final PodCastListItem podCasts;

  Success([this.podCasts]) : assert(podCasts != null);

  @override
  List<Object> get props => [podCasts];
}
