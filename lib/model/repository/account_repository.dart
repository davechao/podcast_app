import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fimber/fimber.dart';
import 'package:podcastapp/model/repository/vo/login_item.dart';
import 'package:podcastapp/model/repository/vo/login_request.dart';

class AccountRepository {
  String _baseUrl;
  Dio _dio;

  AccountRepository(String baseUrl) {
    _baseUrl = baseUrl;
    _dio = _baseDio();
  }

  Dio _baseDio() {
    Dio dio = Dio(new BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: 5000,
      receiveTimeout: 100000,
      contentType: ContentType.json.toString(),
      responseType: ResponseType.json,
    ));
    return dio;
  }

  Future<LoginItem> login(LoginRequest request) async {
    final response = await _dio.post(
      "v1/basicLogin",
      data: request,
    );

    Fimber.d("response.statusCode: ${response.statusCode}");
    Fimber.d("response.data: ${response.data}");
    return LoginItem.fromJson(response.data["data"]);
  }
}
