import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podcastapp/bloc/podcasts/podcast_bloc.dart';
import 'package:podcastapp/model/config.dart';
import 'package:podcastapp/model/config_provider.dart';
import 'package:podcastapp/model/repository/podcast_repository.dart';
import 'package:podcastapp/page/podcasts/podcasts_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Config _config = ConfigProvider.of(context).config;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => PodCastBloc(
          repository: PodCastRepository(
            client: _config.graphQLClient,
          ),
        ),
        child: PodCastsPage(),
      ),
    );
  }
}
