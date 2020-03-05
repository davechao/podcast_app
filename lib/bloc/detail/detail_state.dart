import 'package:equatable/equatable.dart';
import 'package:podcastapp/model/repository/vo/podcast_detail_item.dart';

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
  final PodCastDetailItem podCastDetailItem;

  Success([this.podCastDetailItem]) : assert(podCastDetailItem != null);

  @override
  List<Object> get props => [podCastDetailItem];
}
