import 'package:json_annotation/json_annotation.dart';

part 'login_request.g.dart';

@JsonSerializable(nullable: false)
class LoginRequest {
  @JsonKey(name: "namespace")
  String namespace;

  @JsonKey(name: "username")
  String username;

  @JsonKey(name: "password")
  String password;

  LoginRequest(
    this.namespace,
    this.username,
    this.password,
  );

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}
