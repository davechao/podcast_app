import 'package:json_annotation/json_annotation.dart';

part 'login_item.g.dart';

@JsonSerializable(nullable: false)
class LoginItem {
  @JsonKey(name: "accessToken")
  String accessToken;

  @JsonKey(name: "expiresIn")
  int expiresIn;

  @JsonKey(name: "refreshExpiresIn")
  int refreshExpiresIn;

  @JsonKey(name: "refreshToken")
  String refreshToken;

  LoginItem(
    this.accessToken,
    this.expiresIn,
    this.refreshExpiresIn,
    this.refreshToken,
  );

  factory LoginItem.fromJson(Map<String, dynamic> json) =>
      _$LoginItemFromJson(json);

  Map<String, dynamic> toJson() => _$LoginItemToJson(this);
}
