import 'package:dio/dio.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class Config {
  final String flavor;
  final GraphQLClient graphQLClient;
  final Dio dio;

  Config({
    this.flavor,
    this.graphQLClient,
    this.dio,
  });
}
