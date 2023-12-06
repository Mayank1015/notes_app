import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
    required this.backButton,
    required this.finalFunc,
    required this.title,
  }) : super(key: key);

  final void Function() backButton;
  final void Function() finalFunc;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leadingWidth: 70,
      scrolledUnderElevation: 0,
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          letterSpacing: 0.3,
          color: Colors.black87
        ),
      ),
      backgroundColor: Colors.yellow,
      leading: IconButton(
        onPressed: backButton,
        icon: const Icon(Icons.arrow_back),
      ),
      actions: [
        IconButton(
          onPressed: finalFunc,
          icon: const Icon(
            Icons.check_rounded,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
