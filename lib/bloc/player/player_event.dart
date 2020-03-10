import 'package:equatable/equatable.dart';

abstract class PlayerEvent extends Equatable {
  const PlayerEvent();
}

class PlayMusic extends PlayerEvent {
  @override
  List<Object> get props => [];
}

class PauseMusic extends PlayerEvent {
  @override
  List<Object> get props => [];
}