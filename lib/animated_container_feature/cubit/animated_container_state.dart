part of 'animated_container_cubit.dart';

class AnimatedContainerState extends Equatable {
  const AnimatedContainerState({this.sourceImageIndex = 0});
  final int sourceImageIndex;
  static const List<String> imageSources = [
    'https://picsum.photos/id/10',
    'https://picsum.photos/id/11',
    'https://picsum.photos/id/12',
    'https://picsum.photos/id/13',
    // 'https://picsum.photos/id/13/${size.width}/${size.height}?grayscale',
  ];

  @override
  List<Object> get props => [sourceImageIndex];

  AnimatedContainerState copyWith({
    int? sourceImageIndex,
  }) {
    return AnimatedContainerState(
      sourceImageIndex: sourceImageIndex ?? this.sourceImageIndex,
    );
  }
}
