import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podcastapp/bloc/collections/collection_event.dart';
import 'package:podcastapp/bloc/collections/collection_state.dart';
import 'package:podcastapp/model/repository/podcast_repository.dart';
import 'package:podcastapp/model/repository/vo/podcast_detail_item.dart';

class CollectionBloc extends Bloc<CollectionEvent, CollectionState> {
  final PodCastRepository repository;

  CollectionBloc({
    @required this.repository,
  });

  @override
  CollectionState get initialState => Loading();

  @override
  Stream<CollectionState> mapEventToState(CollectionEvent event) async* {
    if (event is FetchPodCastDetail) {
      try {
        final result = await repository.getPodCastDetail(event.collectionId);
        if (result.hasException) {
          yield Error(result.exception.toString());
          return;
        }
        if (result.loading) {
          yield Loading();
        }

        final podCastDetailItem = PodCastDetailItem.fromJson(result.data);
        yield Success(podCastDetailItem);

      } catch (error) {
        Fimber.e("Error: $error");
        yield Error(error);
      }
    }
  }
}
