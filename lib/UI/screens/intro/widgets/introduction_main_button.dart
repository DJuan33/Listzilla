import 'package:flutter/material.dart';

class IntroButton extends StatelessWidget {
  final VoidCallback nextPage;

  const IntroButton({Key? key, required this.nextPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 900),
      width: double.infinity,
      height: 60,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: TextButton(
          onPressed: () => nextPage(),
          style: TextButton.styleFrom(
            primary: Theme.of(context).brightness == Brightness.light
                ? Colors.white
                : Colors.grey.shade900,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(33)),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          child: Text(
            "Continue".toUpperCase(),
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
