import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:podcastapp/model/repository/vo/content_feed_item.dart';

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
  FlutterSound flutterSound = FlutterSound();

  @override
  Widget build(BuildContext context) {
    final artworkUrl = widget.artworkUrl;
    final contentFeedItem = widget.contentFeedItem;

//    flutterSound.startPlayer(widget.contentFeedItem.contentUrl);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              CachedNetworkImage(
                width: 250.0,
                height: 250.0,
                fit: BoxFit.fill,
                imageUrl: artworkUrl,
                placeholder: (context, url) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
                errorWidget: (context, url, error) {
                  return Icon(Icons.error);
                },
              ),
              SizedBox(height: 70.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100.0),
                child: Text(
                  contentFeedItem.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                  ),
                ),
              ),
            ],
          ),
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
