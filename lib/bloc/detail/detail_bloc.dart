import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podcastapp/bloc/detail/detail_event.dart';
import 'package:podcastapp/bloc/detail/detail_state.dart';
import 'package:podcastapp/model/repository/podcast_repository.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final PodCastRepository repository;

  DetailBloc({
    @required this.repository,
  });

  @override
  DetailState get initialState => Loading();

  @override
  Stream<DetailState> mapEventToState(DetailEvent event) async* {
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

        Fimber.d("@@Data: ${result.data}");
//        final podCasts = PodCastListItem.fromJson(result.data);
//        yield Success(podCasts);

      } catch (error) {
        Fimber.e("Error: $error");
        yield Error(error);
      }
    }
  }
}
