// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'podcast_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PodCastItem _$PodCastItemFromJson(Map<String, dynamic> json) {
  return PodCastItem(
    json['id'] as String,
    json['artistName'] as String,
    json['name'] as String,
    json['artworkUrl100'] as String,
  );
}

Map<String, dynamic> _$PodCastItemToJson(PodCastItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'artistName': instance.artistName,
      'name': instance.name,
      'artworkUrl100': instance.artworkUrl100,
    };
