import 'package:equatable/equatable.dart';

abstract class PodCastEvent extends Equatable {
  const PodCastEvent();
}

class FetchPodCast extends PodCastEvent {
  @override
  List<Object> get props => [];
}
