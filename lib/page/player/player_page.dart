import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:podcastapp/model/repository/vo/content_feed_item.dart';
import 'package:podcastapp/widget/customer_progress_indicator.dart';

enum PlayerState { stopped, playing, paused }

class PlayerPage extends StatefulWidget {
  final String artworkUrl;
  final ContentFeedItem contentFeedItem;

  PlayerPage(
    this.artworkUrl,
    this.contentFeedItem,
  );

  @override
  State<StatefulWidget> createState() {
    return _PlayerPageState();
  }
}

class _PlayerPageState extends State<PlayerPage> {
  AudioPlayer _audioPlayer;
  AudioPlayerState _audioPlayerState;

  Duration _duration;
  Duration _position;

  PlayerState _playerState = PlayerState.stopped;
  StreamSubscription _durationSubscription;
  StreamSubscription _positionSubscription;
  StreamSubscription _playerCompleteSubscription;
  StreamSubscription _playerErrorSubscription;
  StreamSubscription _playerStateSubscription;

  get _isPlaying => _playerState == PlayerState.playing;

  get _durationText => _duration?.toString()?.split('.')?.first ?? '';

  get _positionText => _position?.toString()?.split('.')?.first ?? '';

  void _initAudioPlayer() {
    _audioPlayer = AudioPlayer();

    _durationSubscription = _audioPlayer.onDurationChanged.listen((duration) {
      setState(() => _duration = duration);
    });

    _positionSubscription = _audioPlayer.onAudioPositionChanged.listen((p) {
      setState(() {
        _position = p;
      });
    });

    _playerCompleteSubscription =
        _audioPlayer.onPlayerCompletion.listen((event) {
      _onComplete();
      setState(() {
        _position = _duration;
      });
    });

    _playerErrorSubscription = _audioPlayer.onPlayerError.listen((msg) {
      print('audioPlayer error : $msg');
      setState(() {
        _duration = Duration(seconds: 0);
        _position = Duration(seconds: 0);
      });
    });

    _audioPlayer.onPlayerStateChanged.listen((state) {
      if (!mounted) return;
      setState(() {
        _audioPlayerState = state;
      });
    });
  }

  Future<int> _play(String url) async {
    final playPosition = (_position != null &&
            _duration != null &&
            _position.inMilliseconds > 0 &&
            _position.inMilliseconds < _duration.inMilliseconds)
        ? _position
        : null;
    final result = await _audioPlayer.play(url, position: playPosition);
    if (result == 1) setState(() => _playerState = PlayerState.playing);
    _audioPlayer.setPlaybackRate(playbackRate: 1.0);
    return result;
  }

  Future<int> _pause() async {
    final result = await _audioPlayer.pause();
    if (result == 1) setState(() => _playerState = PlayerState.paused);
    return result;
  }

  Future<int> _stop() async {
    final result = await _audioPlayer.stop();
    if (result == 1) {
      setState(() {
        _playerState = PlayerState.stopped;
        _position = Duration();
      });
    }
    return result;
  }

  void _onComplete() {
    setState(() => _playerState = PlayerState.stopped);
  }

  Widget _buildImg(String artworkUrl) {
    return CachedNetworkImage(
      width: 250.0,
      height: 250.0,
      fit: BoxFit.fill,
      imageUrl: artworkUrl,
      placeholder: (context, url) {
        return Container(
          width: 250.0,
          height: 250.0,
          child: CustomerProgressIndicator(),
        );
      },
      errorWidget: (context, url, error) {
        return Icon(Icons.error);
      },
    );
  }

  Widget _buildSlider() {
    return Slider(
      activeColor: Colors.white,
      inactiveColor: Colors.white30,
      value: (_position != null &&
              _duration != null &&
              _position.inMilliseconds > 0 &&
              _position.inMilliseconds < _duration.inMilliseconds)
          ? _position.inMilliseconds / _duration.inMilliseconds
          : 0.0,
      onChanged: (value) {
        final position = value * _duration.inMilliseconds;
        _audioPlayer.seek(
          Duration(milliseconds: position.round()),
        );
      },
    );
  }

  Widget _buildTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(left: 16.0, right: 16.0),
      child: Text(
        title,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
        ),
      ),
    );
  }

  Widget _buildPlayer(String url) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.replay_30, color: Colors.white70),
            iconSize: 50.0,
            onPressed: () {
              if (_isPlaying) {
                _position = Duration(
                  milliseconds: _position.inMilliseconds - 30000,
                );
                _play(url);
              } else {
                _position = null;
              }
            },
          ),
          _isPlaying
              ? IconButton(
                  icon: Icon(Icons.pause_circle_filled, color: Colors.white),
                  iconSize: 70.0,
                  onPressed: _isPlaying ? () => _pause() : null,
                )
              : IconButton(
                  icon: Icon(Icons.play_circle_filled, color: Colors.white),
                  iconSize: 70.0,
                  onPressed: _isPlaying ? null : () => _play(url),
                ),
          IconButton(
            icon: Icon(Icons.forward_30, color: Colors.white70),
            iconSize: 50.0,
            onPressed: () {
              if (_isPlaying) {
                _position = Duration(
                  milliseconds: _position.inMilliseconds + 30000,
                );
                _play(url);
              } else {
                _position = null;
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _initAudioPlayer();
    _play(widget.contentFeedItem.contentUrl);
  }

  @override
  void dispose() {
    _audioPlayer.stop();
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _playerCompleteSubscription?.cancel();
    _playerErrorSubscription?.cancel();
    _playerStateSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _buildImg(widget.artworkUrl),
              SizedBox(height: 25.0),
              _buildSlider(),
              SizedBox(height: 20.0),
              _buildTitle(widget.contentFeedItem.title),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _buildPlayer(widget.contentFeedItem.contentUrl),
          ),
        ],
      ),
    );
  }
}
