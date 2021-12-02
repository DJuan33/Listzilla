import 'package:flutter/material.dart';
import 'package:listzilla/UI/screens/intro/widgets/introduction_theme_chooser.dart';

class IntroductionTheme extends StatefulWidget {
  const IntroductionTheme({Key? key}) : super(key: key);

  @override
  State<IntroductionTheme> createState() => _IntroductionThemeState();
}

class _IntroductionThemeState extends State<IntroductionTheme>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        const Spacer(),
        Text("Choose Theme",
            style: Theme.of(context).textTheme.headline4,
            textAlign: TextAlign.center),
        const Spacer(),
        const IntroThemeChooser(),
        const Spacer(),
        Text(
          "You can change the theme in the Settings",
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontSize: 24,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
