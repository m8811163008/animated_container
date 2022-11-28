import 'package:animated_square/animated_container_feature/cubit/animated_container_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BackgroundImage extends StatefulWidget {
  const BackgroundImage({Key? key}) : super(key: key);

  @override
  _BackgroundImageState createState() => _BackgroundImageState();
}

class _BackgroundImageState extends State<BackgroundImage> {
  String _getImageSource(int index, Size size) =>
      '${AnimatedContainerState.imageSources[index]}/${size.width}/${size.height}?grayscale';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Image.network(
      _getImageSource(
          context.select<AnimatedContainerCubit, int>(
              (cubit) => cubit.state.sourceImageIndex),
          size),
      width: size.width,
      height: size.height,
      fit: BoxFit.cover,
      loadingBuilder: (_, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Align(
          alignment: Alignment.topCenter,
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : 0,
          ),
        );
      },
    );
  }
}
//
// class BackgroundImage extends StatelessWidget {
//   const BackgroundImage({Key? key}) : super(key: key);
//   // Get image source from cubit and mock online image with device width and height dimension.
//   String _getImageSource(int index, Size size) =>
//       '${AnimatedContainerState.imageSources[index]}/${size.width}/${size.height}?grayscale';
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Image.network(
//       _getImageSource(
//           context.select<AnimatedContainerCubit, int>(
//               (cubit) => cubit.state.sourceImageIndex),
//           size),
//       width: size.width,
//       height: size.height,
//       fit: BoxFit.cover,
//       loadingBuilder: (_, child, loadingProgress) {
//         if (loadingProgress == null) return child;
//
//         return Align(
//           alignment: Alignment.topCenter,
//           child: CircularProgressIndicator(
//             value: loadingProgress.expectedTotalBytes != null
//                 ? loadingProgress.cumulativeBytesLoaded /
//                     loadingProgress.expectedTotalBytes!
//                 : 0,
//           ),
//         );
//       },
//     );
//   }
// }
