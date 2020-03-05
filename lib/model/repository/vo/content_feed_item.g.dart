// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_feed_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContentFeedItem _$ContentFeedItemFromJson(Map<String, dynamic> json) {
  return ContentFeedItem(
    json['title'] as String,
    json['desc'] as String,
    json['contentUrl'] as String,
  );
}

Map<String, dynamic> _$ContentFeedItemToJson(ContentFeedItem instance) =>
    <String, dynamic>{
      'title': instance.title,
      'desc': instance.desc,
      'contentUrl': instance.contentUrl,
    };
