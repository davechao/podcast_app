import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:podcastapp/bloc/player/player_event.dart';
import 'package:podcastapp/bloc/player/player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  FlutterSound flutterSound = FlutterSound();

  @override
  PlayerState get initialState => Loading();

  @override
  Stream<PlayerState> mapEventToState(PlayerEvent event) async* {
    if (event is StartPlayer) {
      await flutterSound.startPlayer(event.contentUrl);
      yield Play();
    } else if (event is PausePlayer) {
      flutterSound.pausePlayer();
      yield Pause();
    } else if (event is ResumePlayer) {
      flutterSound.resumePlayer();
      yield Resume();
    }
  }
}
