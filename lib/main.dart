import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stetho/flutter_stetho.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:podcastapp/app.dart';
import 'package:podcastapp/constant.dart';

void main() {
  Stetho.initialize();
  Fimber.plantTree(DebugTree());

  final HttpLink httpLink = HttpLink(
    uri: 'http://18.222.145.190:8777/graphql',
    headers: {
      Constant.X_GRAPH_AUTH: Constant.X_GRAPH_AUTH_VALUE,
    },
  );

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      cache: InMemoryCache(),
      link: httpLink,
    ),
  );

  final graphQLProvider = GraphQLProvider(
    client: client,
    child: App(),
  );

  runApp(graphQLProvider);
}
