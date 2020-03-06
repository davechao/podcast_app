import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podcastapp/bloc/collections/collection_bloc.dart';
import 'package:podcastapp/bloc/podcasts/podcast_bloc.dart';
import 'package:podcastapp/bloc/podcasts/podcast_event.dart';
import 'package:podcastapp/bloc/podcasts/podcast_state.dart';
import 'package:podcastapp/model/config.dart';
import 'package:podcastapp/model/config_provider.dart';
import 'package:podcastapp/model/repository/podcast_repository.dart';
import 'package:podcastapp/model/repository/vo/podcast_item.dart';
import 'package:podcastapp/model/repository/vo/podcast_list_item.dart';
import 'package:podcastapp/page/collections/collections_page.dart';

class PodCastsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PodCastsState();
  }
}

class _PodCastsState extends State<PodCastsPage> {
  PodCastBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<PodCastBloc>(context);
    bloc.add(FetchPodCasts());
  }

  Widget _buildCastCard(PodCastItem item) {
    return Card(
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CachedNetworkImage(
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
          SizedBox(height: 8.0),
          Text(
            item.artistName,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            item.name,
            style: TextStyle(
              color: Colors.white60,
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Config _config = ConfigProvider.of(context).config;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Casts'),
      ),
      body: BlocBuilder<PodCastBloc, PodCastState>(
        builder: (context, state) {
          if (state is Success) {
            PodCastListItem podCastListItem = state.podCasts;
            List<PodCastItem> podCasts = podCastListItem.podCasts;

            return GridView.builder(
              itemCount: podCasts.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(left: 2.0, right: 2.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => CollectionBloc(
                              repository: PodCastRepository(
                                client: _config.graphQLClient,
                              ),
                            ),
                            child: CollectionsPage(podCasts[index].id),
                          ),
                        ),
                      );
                    },
                    child: _buildCastCard(podCasts[index]),
                  ),
                );
              },
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
