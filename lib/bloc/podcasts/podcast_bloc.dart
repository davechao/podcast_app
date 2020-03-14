import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podcastapp/bloc/podcasts/podcast_event.dart';
import 'package:podcastapp/bloc/podcasts/podcast_state.dart';
import 'package:podcastapp/model/repository/podcast_repository.dart';
import 'package:podcastapp/model/repository/vo/podcast_list_item.dart';

class PodCastBloc extends Bloc<PodCastEvent, PodCastState> {
  final PodCastRepository repository;

  PodCastBloc({
    @required this.repository,
  });

  @override
  PodCastState get initialState => Loading();

  @override
  Stream<PodCastState> mapEventToState(PodCastEvent event) async* {
    if (event is FetchPodCasts) {
      try {
        final result = await repository.getPodCasts();
        if (result.hasException) {
          yield Error(result.exception.toString());
          return;
        }

        final podCasts = PodCastListItem.fromJson(result.data);
        yield Success(podCasts);
      } catch (error) {
        Fimber.e("Error: $error");
        yield Error(error);
      }
    }
  }
}
