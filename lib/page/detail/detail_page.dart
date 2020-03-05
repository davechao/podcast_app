import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podcastapp/bloc/detail/detail_bloc.dart';
import 'package:podcastapp/bloc/detail/detail_event.dart';
import 'package:podcastapp/bloc/detail/detail_state.dart';
import 'package:podcastapp/model/repository/vo/collection_item.dart';
import 'package:podcastapp/model/repository/vo/content_feed_item.dart';

class DetailPage extends StatefulWidget {
  final String collectionId;

  DetailPage(this.collectionId);

  @override
  State<StatefulWidget> createState() {
    return _DetailState();
  }
}

class _DetailState extends State<DetailPage> {
  DetailBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<DetailBloc>(context);
    bloc.add(FetchPodCastDetail(widget.collectionId));
  }

  Widget _buildContentFeed(List<ContentFeedItem> items) {
    return Expanded(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              '${items[index].title}',
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTitle() {
    return ListTile(
      title: Text(
        'ALL EPISODES',
        style: TextStyle(
          color: Colors.white,
          fontSize: 12.0,
        ),
      ),
    );
  }

  Widget _buildCastDetail(CollectionItem item) {
    return Padding(
      padding: EdgeInsets.only(left: 8.0, right: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          CachedNetworkImage(
            fit: BoxFit.fill,
            imageUrl: item.artworkUrl100,
            placeholder: (context, url) {
              return Center(
                child: CircularProgressIndicator(),
              );
            },
            errorWidget: (context, url, error) {
              return Icon(Icons.error);
            },
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  item.collectionName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  item.artistName,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
          title: Text('Detail'),
        ),
        body: BlocBuilder<DetailBloc, DetailState>(
          builder: (context, state) {
            if (state is Success) {
              final collectionItem = state.podCastDetailItem.collectionItem;
              return Column(
                children: <Widget>[
                  _buildCastDetail(collectionItem),
                  SizedBox(height: 16.0),
                  _buildTitle(),
                  _buildContentFeed(collectionItem.contentFeeds)
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
