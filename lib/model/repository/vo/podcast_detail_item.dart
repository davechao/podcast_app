import 'package:json_annotation/json_annotation.dart';
import 'package:podcastapp/model/repository/vo/collection_item.dart';

part 'podcast_detail_item.g.dart';

@JsonSerializable(nullable: false)
class PodCastDetailItem {

  @JsonKey(name: "collection")
  final CollectionItem collectionItem;

  PodCastDetailItem(this.collectionItem);

  factory PodCastDetailItem.fromJson(Map<String, dynamic> json) =>
      _$PodCastDetailItemFromJson(json);

  Map<String, dynamic> toJson(PodCastDetailItem instance) =>
      _$PodCastDetailItemToJson(instance);
}
