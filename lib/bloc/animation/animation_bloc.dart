import 'package:flutter_bloc/flutter_bloc.dart';

enum AnimationEvent { idle, cover_eyes_in, cover_eyes_out, success, fail }

class AnimationBloc extends Bloc<AnimationEvent, String> {
  @override
  String get initialState => "idle";

  @override
  Stream<String> mapEventToState(AnimationEvent event) async* {
    switch (event) {
      case AnimationEvent.idle:
        yield "idle";
        break;
      case AnimationEvent.cover_eyes_in:
        yield "cover_eyes_in";
        break;
      case AnimationEvent.cover_eyes_out:
        yield "cover_eyes_out";
        break;
      case AnimationEvent.success:
        yield "success";
        break;
      case AnimationEvent.fail:
        yield "fail";
        break;
    }
  }

  bool isCoverEyesIn() {
    return state == "cover_eyes_in";
  }
}
