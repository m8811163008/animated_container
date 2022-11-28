import 'dart:async';
import 'dart:math';

import 'package:animated_square/animated_container_feature/cubit/animated_container_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DragableContainer extends StatefulWidget {
  const DragableContainer({Key? key}) : super(key: key);

  @override
  _DragableContainerState createState() => _DragableContainerState();
}

class _DragableContainerState extends State<DragableContainer> {
  final double _circleSize = 80;
  Offset? _circlePosition;
  double _slope = 0;
  double _xDistance = 0;
  int _tapCount = 0;

  void moveRight(double slope, int i) {
    Timer.periodic(const Duration(microseconds: 700), (timer) {
      if (_tapCount != i) {
        timer.cancel();
//Stop moving in this direction when the screen is tapped again
      }
      _xDistance = sqrt(1 / (1 + pow(slope, 2)));
      setState(() {
        _circlePosition = Offset(_circlePosition!.dx + _xDistance,
            _circlePosition!.dy - slope * _xDistance);
      });

//if the ball bounces off the top or bottom

      if (_circlePosition!.dy < 0 ||
          _circlePosition!.dy >
              MediaQuery.of(context).size.height - (_circleSize * 1.7)) {
        timer.cancel();
        moveRight(-slope, i);
      }
//if the ball bounces off the right
      if (_circlePosition!.dx >
          MediaQuery.of(context).size.width - _circleSize) {
        timer.cancel();
        moveLeft(-slope, i);
      }
    });
  }

  void moveLeft(double slope, int i) {
    Timer.periodic(const Duration(microseconds: 700), (timer) {
      if (_tapCount != i) {
        timer.cancel();
//Stop moving in this direction when the screen is tapped again

      }
      _xDistance = sqrt(1 / (1 + pow(slope, 2)));
      setState(() {
        _circlePosition = Offset(_circlePosition!.dx - _xDistance,
            _circlePosition!.dy + slope * _xDistance);
      });

//if the ball bounces off the top or bottom
      if (_circlePosition!.dy < 0 ||
          _circlePosition!.dy >
              MediaQuery.of(context).size.height - (_circleSize * 1.7)) {
        timer.cancel();
        moveLeft(-slope, i);
      }
//if the ball bounces off the left
      if (_circlePosition!.dx < 0) {
        timer.cancel();
        moveRight(-slope, i);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _circlePosition ??= Offset(
        (MediaQuery.of(context).size.width - _circleSize) / 2,
        (MediaQuery.of(context).size.height - _circleSize) / 2);

    return Positioned(
      left: _circlePosition!.dx,
      top: _circlePosition!.dy,
      child: GestureDetector(
        onPanUpdate: (position) {
          _tapCount++; //stop moving
          setState(() {
            _circlePosition =
                _circlePosition! + Offset(position.delta.dx, position.delta.dy);
          });
        },
        onPanEnd: (position) {
          if (position.velocity.pixelsPerSecond.distance < 50) return;
          _tapCount++;
          _slope =
              (-position.velocity.pixelsPerSecond.dy + _circlePosition!.dy) /
                  (position.velocity.pixelsPerSecond.dx - _circlePosition!.dx);
          if (position.velocity.pixelsPerSecond.dx <= 0) {
            moveLeft(_slope, _tapCount);
          }
          if (position.velocity.pixelsPerSecond.dx > 0) {
            moveRight(_slope, _tapCount);
          }
        },
        onTap: () {
          setState(() {
            context.read<AnimatedContainerCubit>().increaseImageIndex();
          });
          _tapCount++; //stop moving
        },
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.pink,
            shape: BoxShape.circle,
          ),
          height: _circleSize,
          width: _circleSize,
        ),
      ),
    );
  }
}
