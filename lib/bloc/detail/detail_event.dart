import 'package:equatable/equatable.dart';

abstract class DetailEvent extends Equatable {
  const DetailEvent();
}

class FetchPodCastDetail extends DetailEvent {
  final String collectionId;

  FetchPodCastDetail(this.collectionId);

  @override
  List<Object> get props => [collectionId];
}
