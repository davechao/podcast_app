import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podcastapp/bloc/podcast_bloc.dart';
import 'package:podcastapp/bloc/podcast_event.dart';
import 'package:podcastapp/bloc/podcast_state.dart';
import 'package:podcastapp/model/vo/podcast_item.dart';
import 'package:podcastapp/model/vo/podcast_list_item.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<HomePage> {
  PodCastBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<PodCastBloc>(context);
    bloc.add(FetchPodCast());
  }

  @override
  Widget build(BuildContext context) {
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
                return Card(
                  color: Colors.black,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CachedNetworkImage(
                        imageUrl: podCasts[index].artworkUrl100,
                        placeholder: (context, url) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        errorWidget: (context, url, error) {
                          return Icon(Icons.error);
                        },
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        podCasts[index].artistName,
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        podCasts[index].name,
                        style: TextStyle(
                          color: Colors.white60,
                          fontSize: 12.0,
                        ),
                      ),
                    ],
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
