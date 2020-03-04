// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'podcast_list_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PodCastListItem _$PodCastListItemFromJson(Map<String, dynamic> json) {
  return PodCastListItem(
    (json['podcast'] as List)
        .map((e) => PodCastItem.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$PodCastListItemToJson(PodCastListItem instance) =>
    <String, dynamic>{
      'podcast': instance.podCasts,
    };
