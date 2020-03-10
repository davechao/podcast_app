import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        return Container(
          width: 250.0,
          height: 250.0,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      errorWidget: (context, url, error) {
        return Icon(Icons.error);
      },
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

  Widget _buildPlayer(String contentUrl) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.skip_previous, color: Colors.white),
            iconSize: 50.0,
          ),
          IconButton(
            icon: Icon(Icons.pause_circle_filled, color: Colors.white),
            iconSize: 70.0,
            onPressed: () {
              flutterSound.startPlayer(contentUrl);
            },
          ),
          IconButton(
            icon: Icon(Icons.skip_next, color: Colors.white),
            iconSize: 50.0,
            onPressed: () {
              flutterSound.stopPlayer();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

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
              SizedBox(height: 10.0),
              _buildSlider(),
              SizedBox(height: 15.0),
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
