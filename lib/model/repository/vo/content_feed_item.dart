import 'package:json_annotation/json_annotation.dart';

part 'content_feed_item.g.dart';

@JsonSerializable(nullable: false)
class ContentFeedItem {
  @JsonKey(name: "title")
  final String title;

  @JsonKey(name: "desc")
  final String desc;

  @JsonKey(name: "contentUrl")
  final String contentUrl;

  ContentFeedItem(
    this.title,
    this.desc,
    this.contentUrl,
  );

  factory ContentFeedItem.fromJson(Map<String, dynamic> json) =>
      _$ContentFeedItemFromJson(json);

  Map<String, dynamic> toJson(ContentFeedItem instance) =>
      _$ContentFeedItemToJson(instance);
}
