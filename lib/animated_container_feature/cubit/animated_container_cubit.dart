import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'animated_container_state.dart';

class AnimatedContainerCubit extends Cubit<AnimatedContainerState> {
  AnimatedContainerCubit() : super(const AnimatedContainerState());

  void increaseImageIndex() {
    var index = state.sourceImageIndex;
    index++;
    emit(state.copyWith(
        sourceImageIndex: index % AnimatedContainerState.imageSources.length));
  }
}
