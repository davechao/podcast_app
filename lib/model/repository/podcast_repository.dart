import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:podcastapp/model/graphql/queries.dart' as queries;

class PodCastRepository {
  final GraphQLClient client;

  PodCastRepository({@required this.client}) : assert(client != null);

  Future<QueryResult> getPodCastRepositories() async {
    final QueryOptions _options = QueryOptions(
      documentNode: gql(queries.readPodCast),
    );
    return await client.query(_options);
  }
}
