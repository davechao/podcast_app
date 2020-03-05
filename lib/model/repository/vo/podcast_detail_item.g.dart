// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'podcast_detail_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PodCastDetailItem _$PodCastDetailItemFromJson(Map<String, dynamic> json) {
  return PodCastDetailItem(
    CollectionItem.fromJson(json['collection'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PodCastDetailItemToJson(PodCastDetailItem instance) =>
    <String, dynamic>{
      'collection': instance.collectionItem,
    };
