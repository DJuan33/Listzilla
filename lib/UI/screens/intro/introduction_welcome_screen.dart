import 'package:flutter/material.dart';

class IntroductionWelcome extends StatelessWidget {
  const IntroductionWelcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Text("Welcome to Listzilla!",
            style: Theme.of(context).textTheme.headline4,
            textAlign: TextAlign.center),
        const Spacer(),
        Image.asset(
          "assets/images/logo.webp",
          height: 300,
          width: 300,
        ),
        const Spacer(),
        Text(
          "Listzilla will help you te be more productive",
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontSize: 24,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
