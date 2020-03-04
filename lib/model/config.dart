import 'package:graphql_flutter/graphql_flutter.dart';

class Config {
  final String flavor;
  final GraphQLClient graphQLClient;

  Config({
    this.flavor,
    this.graphQLClient,
  });
}
