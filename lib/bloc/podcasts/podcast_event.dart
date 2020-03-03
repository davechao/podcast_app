import 'package:equatable/equatable.dart';

abstract class PodCastEvent extends Equatable {
  const PodCastEvent();
}

class FetchPodCasts extends PodCastEvent {
  @override
  List<Object> get props => [];
}
