import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:podcastapp/model/repository/vo/content_feed_item.dart';

class PlayerPage extends StatefulWidget {
  final ContentFeedItem contentFeedItem;

  PlayerPage(this.contentFeedItem);

  @override
  State<StatefulWidget> createState() {
    return _PlayerPageState();
  }
}

class _PlayerPageState extends State<PlayerPage> {
  FlutterSound flutterSound = FlutterSound();

  @override
  Widget build(BuildContext context) {
    print("@@:" + widget.contentFeedItem.contentUrl);
    flutterSound.startPlayer(widget.contentFeedItem.contentUrl);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Text('Player'),
        ),
      ),
    );
  }

  @override
  void dispose() {
    flutterSound.stopPlayer();
    super.dispose();
  }
}
