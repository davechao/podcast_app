import 'dart:io';

import 'package:dio/dio.dart' as http;
import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stetho/flutter_stetho.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:podcastapp/app.dart';
import 'package:podcastapp/constant.dart';
import 'package:podcastapp/model/config.dart';
import 'package:podcastapp/model/config_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

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

  http.Dio _baseDio() {
    http.Dio dio = http.Dio(new http.BaseOptions(
      baseUrl: 'https://api.moshiqhwh.com/',
      connectTimeout: 5000,
      receiveTimeout: 100000,
      contentType: ContentType.json.toString(),
      responseType: http.ResponseType.json,
    ));
    return dio;
  }

  var configProvider = ConfigProvider(
    config: Config(
      flavor: 'prod',
      graphQLClient: _initGraphQLClient(),
      dio: _baseDio(),
    ),
    child: App(),
  );

  Stetho.initialize();
  Fimber.plantTree(DebugTree());

//  runApp(DevicePreview(
//    builder: (context) => configProvider,
//  ));

  runApp(configProvider);
}
