import 'package:flutter/material.dart';

class IntroductionFinish extends StatelessWidget {
  const IntroductionFinish({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Text("App ready for use",
            style: Theme.of(context).textTheme.headline4,
            textAlign: TextAlign.center),
        const Spacer(),
        Image.asset(
          "assets/images/welcome.webp",
          height: 300,
          width: 300,
        ),
        const Spacer(),
        Text(
          "We create some starter lists. Enjoy using the application :D",
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontSize: 24,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
