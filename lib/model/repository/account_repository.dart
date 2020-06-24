import 'package:dio/dio.dart';
import 'package:fimber/fimber.dart';
import 'package:podcastapp/model/repository/vo/login_item.dart';
import 'package:podcastapp/model/repository/vo/login_request.dart';

class AccountRepository {
  Dio _dio;

  AccountRepository(Dio dio) {
    _dio = dio;
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
