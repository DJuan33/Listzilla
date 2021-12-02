import 'package:flutter/material.dart';

class IntroDotIndicator extends StatelessWidget {
  final int length;
  final int currentIndex;

  const IntroDotIndicator({Key? key, required this.length, required this.currentIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        length,
        (int index) => index == currentIndex
            ? dotGenerator(index, true, context)
            : dotGenerator(index, false, context),
      ),
    );
  }

  Widget dotGenerator(int index, bool selected, BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 30),
      margin: const EdgeInsets.only(right: 6),
      height: 6,
      width: selected ? 12 : 6,
      decoration: BoxDecoration(
        color: selected ? Theme.of(context).colorScheme.primary : Colors.grey,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
