import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podcastapp/bloc/podcast_bloc.dart';
import 'package:podcastapp/bloc/podcast_event.dart';
import 'package:podcastapp/bloc/podcast_state.dart';

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
      appBar: AppBar(
        title: Text('Casts'),
      ),
      body: BlocBuilder<PodCastBloc, PodCastState>(
        builder: (context, state) {
          if (state is Success) {
            return Center(
              child: Text('Success'),
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
