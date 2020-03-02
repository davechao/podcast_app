import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podcastapp/bloc/podcast_event.dart';
import 'package:podcastapp/bloc/podcast_state.dart';
import 'package:podcastapp/model/repository/podcast_repository.dart';

class PodCastBloc extends Bloc<PodCastEvent, PodCastState> {
  final PodCastRepository repository;

  PodCastBloc({
    @required this.repository,
  });

  @override
  PodCastState get initialState => Loading();

  @override
  Stream<PodCastState> mapEventToState(PodCastEvent event) async* {
    if (event is FetchPodCast) {
      try {
        final result = await repository.getPodCastRepositories();
        if (result.hasException) {
          yield Error(result.exception.toString());
          return;
        }
        if (result.loading) {
          yield Loading();
        }
        Fimber.d("@@result.data: ${result.data}");
      } catch (error) {
        Fimber.e("Error: $error");
        yield Error(error);
      }
    }
  }
}
