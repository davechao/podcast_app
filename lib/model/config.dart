import 'package:graphql_flutter/graphql_flutter.dart';

class Config {
  final String flavor;
  final GraphQLClient graphQLClient;
  final String apiBaseUrl;

  Config({
    this.flavor,
    this.graphQLClient,
    this.apiBaseUrl,
  });
}
