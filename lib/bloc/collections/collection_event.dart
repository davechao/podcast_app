import 'package:equatable/equatable.dart';

abstract class CollectionEvent extends Equatable {
  const CollectionEvent();
}

class FetchPodCastDetail extends CollectionEvent {
  final String collectionId;

  FetchPodCastDetail(this.collectionId);

  @override
  List<Object> get props => [collectionId];
}
