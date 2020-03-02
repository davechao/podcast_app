import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:podcastapp/bloc/podcast_bloc.dart';
import 'package:podcastapp/constant.dart';
import 'package:podcastapp/model/repository/podcast_repository.dart';
import 'package:podcastapp/page/home/home_page.dart';

class App extends StatelessWidget {
  GraphQLClient _initGraphQLClient() {
    final HttpLink _httpLink = HttpLink(
      uri: 'http://18.222.145.190:8777/graphql',
      headers: {
        Constant.X_GRAPH_AUTH: Constant.X_GRAPH_AUTH_VALUE,
      },
    );

    return GraphQLClient(
      cache: InMemoryCache(),
      link: _httpLink,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => PodCastBloc(
          repository: PodCastRepository(
            client: _initGraphQLClient(),
          ),
        ),
        child: HomePage(),
      ),
    );
  }
}
