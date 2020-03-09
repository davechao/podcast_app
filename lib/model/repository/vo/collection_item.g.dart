// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CollectionItem _$CollectionItemFromJson(Map<String, dynamic> json) {
  return CollectionItem(
    json['collectionId'] as int,
    json['collectionName'] as String,
    json['artistId'] as int,
    json['artistName'] as String,
    json['artworkUrl100'] as String,
    json['artworkUrl600'] as String,
    (json['contentFeed'] as List)
        .map((e) => ContentFeedItem.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$CollectionItemToJson(CollectionItem instance) =>
    <String, dynamic>{
      'collectionId': instance.collectionId,
      'collectionName': instance.collectionName,
      'artistId': instance.artistId,
      'artistName': instance.artistName,
      'artworkUrl100': instance.artworkUrl100,
      'artworkUrl600': instance.artworkUrl600,
      'contentFeed': instance.contentFeeds,
    };
