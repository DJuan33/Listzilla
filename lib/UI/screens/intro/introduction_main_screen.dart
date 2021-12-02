import 'package:flutter/material.dart';
import 'package:listzilla/UI/screens/intro/introduction_screen_finish.dart';
import 'package:listzilla/UI/screens/intro/introduction_theme.dart';
import 'package:listzilla/UI/screens/intro/introduction_welcome_screen.dart';
import 'package:listzilla/UI/screens/intro/widgets/introduction_dot_indicator.dart';
import 'package:listzilla/UI/screens/intro/widgets/introduction_main_button.dart';

class IntroductionMainScreen extends StatefulWidget {
  final List<Widget> screens = [
    const IntroductionWelcome(),
    const IntroductionTheme(),
    const IntroductionFinish(),
  ];

  IntroductionMainScreen({Key? key}) : super(key: key);

  @override
  _IntroductionMainScreenState createState() => _IntroductionMainScreenState();
}

class _IntroductionMainScreenState extends State<IntroductionMainScreen> {
  int currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (int index) => setIndex(index),
                  children: widget.screens,
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    IntroDotIndicator(
                        length: widget.screens.length,
                        currentIndex: currentIndex),
                    const SizedBox(height: 30),
                    IntroButton(
                      nextPage: () => nextPage(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void setIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void nextPage() {
    if (currentIndex++ < 2) {
      _pageController.animateToPage(currentIndex++,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      Navigator.pop(context);
    }
  }
}
