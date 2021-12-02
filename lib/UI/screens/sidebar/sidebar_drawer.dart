import 'package:flutter/material.dart';
import 'package:listzilla/UI/screens/sidebar/widgets/sidebar_data_list.dart';
import 'package:listzilla/UI/screens/sidebar/widgets/sidebar_header.dart';
import 'package:listzilla/UI/screens/sidebar/widgets/sidebar_newitems_bar.dart';

class SidebarDrawer extends StatelessWidget {
  const SidebarDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            SidebarHeader(),
            SidebarData(),
            SidebarNewItems(),
          ],
        ),
      ),
    );
  }
}
