import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podcastapp/bloc/pod_cast_event.dart';
import 'package:podcastapp/bloc/pod_cast_state.dart';

class PodCastBloc extends Bloc<PodCastEvent, PodCastState> {
  @override
  PodCastState get initialState => Loading();

  @override
  Stream<PodCastState> mapEventToState(PodCastEvent event) async* {
    if (event is FetchPodCast) {
      yield Loading();


//      try {
////        final BikeListItem bikeListItem = await apiProvider.fetchBikes();
////        yield Success(bikeListItem: bikeListItem);
//      } on DioError catch (e) {
//        Fimber.e("Dio Error: $e");
//        yield Error();
//      }


    }
  }
}
