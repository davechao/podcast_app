import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podcastapp/bloc/collections/collection_bloc.dart';
import 'package:podcastapp/bloc/collections/collection_event.dart';
import 'package:podcastapp/bloc/collections/collection_state.dart';
import 'package:podcastapp/model/repository/vo/collection_item.dart';
import 'package:podcastapp/page/player/player_page.dart';

class CollectionsPage extends StatefulWidget {
  final String collectionId;

  CollectionsPage(this.collectionId);

  @override
  State<StatefulWidget> createState() {
    return _CollectionPageState();
  }
}

class _CollectionPageState extends State<CollectionsPage> {
  CollectionBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<CollectionBloc>(context);
    bloc.add(FetchPodCastDetail(widget.collectionId));
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
              return Container(
                width: 100.0,
                height: 100.0,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
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

  Widget _buildContentFeed(CollectionItem item) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => Divider(color: Colors.white70),
        itemCount: item.contentFeeds.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              '${item.contentFeeds[index].title}',
              style: TextStyle(color: Colors.white),
            ),
            trailing: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlayerPage(
                      item.artworkUrl600,
                      item.contentFeeds[index],
                    ),
                  ),
                );
              },
              child: Icon(
                Icons.play_circle_outline,
                color: Colors.amber,
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.black,
      ),
      body: BlocBuilder<CollectionBloc, CollectionState>(
        builder: (context, state) {
          if (state is Success) {
            final collectionItem = state.podCastDetailItem.collectionItem;
            return Column(
              children: <Widget>[
                _buildCastDetail(collectionItem),
                SizedBox(height: 16.0),
                _buildTitle(),
                _buildContentFeed(collectionItem)
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
