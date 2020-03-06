import 'package:equatable/equatable.dart';
import 'package:podcastapp/model/repository/vo/podcast_detail_item.dart';

class CollectionState extends Equatable {
  const CollectionState();

  @override
  List<Object> get props => [];
}

class Loading extends CollectionState {}

class DataEmpty extends CollectionState {}

class Error extends CollectionState {
  final String exception;

  Error([this.exception]) : assert(exception != null);

  @override
  List<Object> get props => [exception];
}

class Success extends CollectionState {
  final PodCastDetailItem podCastDetailItem;

  Success([this.podCastDetailItem]) : assert(podCastDetailItem != null);

  @override
  List<Object> get props => [podCastDetailItem];
}
