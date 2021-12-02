import 'package:flutter/material.dart';
import 'package:listzilla/UI/screens/sidebar/widgets/sidebar_data_list.dart';
import 'package:listzilla/UI/screens/sidebar/widgets/sidebar_header.dart';
import 'package:listzilla/UI/screens/sidebar/widgets/sidebar_navigation_list.dart';
import 'package:listzilla/UI/screens/sidebar/widgets/sidebar_newitems_bar.dart';

class SidebarScreen extends StatelessWidget {
  const SidebarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          SidebarHeader(),
          SidebarNavigationList(),
          Divider(),
          SidebarData(),
          SidebarNewItems(),
        ],
      ),
    );
  }
}
