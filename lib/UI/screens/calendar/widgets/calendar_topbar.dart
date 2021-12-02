import 'package:flutter/material.dart';

class CalendarTopBar extends StatelessWidget {

  final Function calendarFormatCallback;

  const CalendarTopBar({Key? key, required this.calendarFormatCallback}) : super(key: key);

  /// Returns a bool that indicate if the app is running in a mobile screen size.
  bool isMobileScreenSize(BuildContext context) {
    return MediaQuery.of(context).size.width <= 1200;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeContext = Theme.of(context);

    return AppBar(
      automaticallyImplyLeading: isMobileScreenSize(context),
      title: const Text("Calendar"),
      actions: [
        PopupMenuButton(
            onSelected: (value) => {
                  if (value == CalendarOptions.calendarMonth)
                    {
                      calendarFormatCallback(0)
                    }
                  else
                    {
                      calendarFormatCallback(1)
                    }
                },
            itemBuilder: (context) => <PopupMenuEntry<CalendarOptions>>[
                  PopupMenuItem<CalendarOptions>(
                    value: CalendarOptions.calendarMonth,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Icon(
                            Icons.calendar_view_month,
                            color: themeContext.colorScheme.primary,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Month",
                            textAlign: TextAlign.start,
                            style: themeContext.textTheme.bodyText2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem<CalendarOptions>(
                    value: CalendarOptions.calendarWeek,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Icon(
                            Icons.calendar_view_week,
                            color: themeContext.colorScheme.primary,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Week",
                            textAlign: TextAlign.start,
                            style: themeContext.textTheme.bodyText2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
            icon: const Icon(
              Icons.more_vert,
            ),
            padding: const EdgeInsets.all(0)),
      ],
    );
  }
}

enum CalendarOptions { calendarMonth, calendarWeek,}

