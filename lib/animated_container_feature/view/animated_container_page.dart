import 'package:animated_square/animated_container_feature/cubit/animated_container_cubit.dart';
import 'package:animated_square/animated_container_feature/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnimatedContainerPage extends StatelessWidget {
  const AnimatedContainerPage({Key? key, this.title = ''}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(title),
      ),
      body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: BlocProvider(
        create: (context) => AnimatedContainerCubit(),
        child: Stack(
          alignment: Alignment.center,
          children: const [
            BackgroundImage(),
            DragableContainer(),
          ],
        ),
      )),
    );
  }
}
