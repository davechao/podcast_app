import 'package:json_annotation/json_annotation.dart';
import 'package:podcastapp/model/vo/podcast_item.dart';

part 'podcast_list_item.g.dart';

@JsonSerializable(nullable: false)
class PodCastListItem {
  @JsonKey(name: "podcast")
  List<PodCastItem> podCasts = new List<PodCastItem>();

  PodCastListItem(this.podCasts);

  factory PodCastListItem.fromJson(Map<String, dynamic> json) =>
      _$PodCastListItemFromJson(json);

  Map<String, dynamic> toJson(PodCastListItem instance) =>
      _$PodCastListItemToJson(instance);
}
