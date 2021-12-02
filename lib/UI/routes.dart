import 'package:flutter/material.dart';
import 'package:listzilla/UI/routes_names.dart';
import 'package:listzilla/UI/screens/calendar/calendar_screen.dart';
import 'package:listzilla/UI/screens/home/home_screen.dart';
import 'package:listzilla/UI/screens/intro/introduction_main_screen.dart';
import 'package:listzilla/UI/screens/settings/settings_screen.dart';
import 'package:listzilla/UI/screens/task_detail/taskdetail_screen.dart';

class AppRouter {
  Route generateRoute(RouteSettings routes) {
    switch (routes.name) {
      case RouteNames.home:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      case RouteNames.intro:
        return MaterialPageRoute(
          builder: (context) => IntroductionMainScreen(),
        );
      case RouteNames.settings:
        return MaterialPageRoute(
          builder: (context) => const SettingsScreen(),
        );
      case RouteNames.taskDetail:
        return MaterialPageRoute(
          builder: (context) => TaskDetailScreen(),
        );
      case RouteNames.calendar:
        return MaterialPageRoute(
          builder: (context) => const CalendarScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const PageNotFound(),
        );
    }
  }
}

class PageNotFound extends StatelessWidget {
  const PageNotFound({Key? key}) : super(key: key);
 
 /// TODO: build PageNotFound
  @override
  Widget build(BuildContext context) {
    return Container(
      child: null,
    );
  }
}
