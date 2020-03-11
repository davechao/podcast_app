import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podcastapp/bloc/player/player_event.dart';
import 'package:podcastapp/bloc/player/player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  AudioPlayer _audioPlayer = AudioPlayer();
  AudioPlayerState _audioPlayerState;

  Duration _duration;
  Duration _position;

  StreamSubscription _durationSubscription;
  StreamSubscription _positionSubscription;
  StreamSubscription _playerCompleteSubscription;
  StreamSubscription _playerErrorSubscription;
  StreamSubscription _playerStateSubscription;

  get _durationText => _duration?.toString()?.split('.')?.first ?? '';

  get _positionText => _position?.toString()?.split('.')?.first ?? '';

  @override
  PlayerState get initialState => Loading();

  @override
  Stream<PlayerState> mapEventToState(PlayerEvent event) async* {
    if (event is StartPlayer) {
      int result = await _play(event.contentUrl);
      if (result == 1) {
        yield Play();
      } else {
        yield Loading();
      }
    } else if (event is PausePlayer) {
      int result = await _pause();
      if (result == 1) {
        yield Pause();
      }
    } else if (event is ResumePlayer) {
      int result = await _audioPlayer.resume();
      if (result == 1) {
        yield Resume();
      }
    } else if (event is ReplayPlayer) {
      int result = await _audioPlayer.seek(
        Duration(milliseconds: event.milliseconds),
      );
      if (result == 1) {
        yield Replay();
      }
    } else if (event is ForwardPlayer) {
      int result = await _audioPlayer.seek(
        Duration(milliseconds: event.milliseconds),
      );
      if (result == 1) {
        yield Forward();
      }
    }
  }

  Future<int> _play(String url) async {
    final playPosition = (_position != null &&
            _duration != null &&
            _position.inMilliseconds > 0 &&
            _position.inMilliseconds < _duration.inMilliseconds)
        ? _position
        : null;
    final result = await _audioPlayer.play(url, position: playPosition);
    _audioPlayer.setPlaybackRate(playbackRate: 1.0);
    return result;
  }

  Future<int> _pause() async {
    final result = await _audioPlayer.pause();
    return result;
  }

  Future<int> _stop() async {
    final result = await _audioPlayer.stop();
    if (result == 1) {
      _position = Duration();
    }
    return result;
  }
}
