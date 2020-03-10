import 'package:equatable/equatable.dart';

class PlayerState extends Equatable {
  const PlayerState();

  @override
  List<Object> get props => [];
}

class Loading extends PlayerState {}

class Play extends PlayerState {}

class Pause extends PlayerState {}
