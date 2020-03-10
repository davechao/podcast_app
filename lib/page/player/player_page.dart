import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
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

  Widget _buildImg(String artworkUrl) {
    return CachedNetworkImage(
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
    );
  }

  Widget _buildTitle(String title) {
    return Text(
      title,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: 25.0,
      ),
    );
  }

  Widget _buildPlayer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.skip_previous,
            color: Colors.white,
            size: 50.0,
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.pause_circle_filled,
            color: Colors.white,
            size: 50.0,
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.skip_next,
            color: Colors.white,
            size: 50.0,
          ),
        ),
      ],
    );
  }

  Widget _buildSlider() {
    return Slider(
      value: 5,
      min: 0,
      max: 100,
      activeColor: Colors.white,
      inactiveColor: Colors.white30,
      onChanged: (rating) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        body: Column(
          children: <Widget>[
            _buildImg(widget.artworkUrl),
            SizedBox(height: 20.0),
            _buildSlider(),
            SizedBox(height: 40.0),
            _buildTitle(widget.contentFeedItem.title),
            SizedBox(height: 60.0),
            _buildPlayer(),
          ],
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
