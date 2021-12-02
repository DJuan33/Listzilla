import 'package:flutter/material.dart';
import 'package:listzilla/UI/routes_names.dart';

class SidebarHeader extends StatelessWidget {
  const SidebarHeader({Key? key}) : super(key: key);

  /// Returns a bool that indicate if the app is running in a mobile screen size.
  bool isMobileScreenSize(BuildContext context) {
    return MediaQuery.of(context).size.width <=
        1200;
  }
  @override
  Widget build(BuildContext context) {
    bool appBrightness =
        Theme.of(context).brightness == Brightness.light ? true : false;
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 3),
      leading: isMobileScreenSize(context) ? IconButton(
        icon: const Icon(
          Icons.arrow_back,
          size: 24,
        ),
        onPressed: () => Navigator.pop(context),
      ) : const SizedBox(),
      title: Text(
        "My Lists",
        style: Theme.of(context)
            .textTheme
            .subtitle1!
            .copyWith(color: appBrightness ? Colors.black : Colors.white),
        textAlign: TextAlign.center,
      ),

      // TODO: Add settings.
      trailing: IconButton(
        icon: const Icon(
          Icons.settings,
          size: 24,
        ),
        onPressed: () => Navigator.pushNamed(context,RouteNames.settings),
      ),
    );
  }
}
