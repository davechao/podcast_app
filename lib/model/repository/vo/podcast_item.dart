import 'package:json_annotation/json_annotation.dart';

part 'podcast_item.g.dart';

@JsonSerializable(nullable: false)
class PodCastItem {
  @JsonKey(name: "id")
  final String id;

  @JsonKey(name: "artistName")
  final String artistName;

  @JsonKey(name: "name")
  final String name;

  @JsonKey(name: "artworkUrl100")
  final String artworkUrl100;

  PodCastItem(
    this.id,
    this.artistName,
    this.name,
    this.artworkUrl100,
  );

  factory PodCastItem.fromJson(Map<String, dynamic> json) =>
      _$PodCastItemFromJson(json);

  Map<String, dynamic> toJson(PodCastItem instance) =>
      _$PodCastItemToJson(instance);
}
