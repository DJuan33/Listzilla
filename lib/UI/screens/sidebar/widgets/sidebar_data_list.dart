import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listzilla/DI/app_dependencies.dart';
import 'package:listzilla/UI/screens/sidebar/widgets/sidebar_group_tile.dart';
import 'package:listzilla/UI/screens/sidebar/widgets/sidebar_smartlists_tiles.dart';
import 'package:listzilla/domain/controllers/sidebar/sidebar_screen_controller.dart';
import 'package:listzilla/domain/controllers/sidebar/sidebar_screen_state.dart';
import 'package:listzilla/domain/models/group_list_model.dart';

class SidebarData extends StatefulWidget {
  const SidebarData({Key? key}) : super(key: key);

  @override
  State<SidebarData> createState() => _SidebarDataState();
}

class _SidebarDataState extends State<SidebarData> with AutomaticKeepAliveClientMixin {
  final SidebarScreenController _sidebarScreenController =
      AppDependencies.dependencyInjector.resolve();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<SidebarScreenController, SidebarScreenState>(
        bloc: _sidebarScreenController,
        /* buildWhen: (previous,current){ */
        /*     return previous.taskLists != current.taskLists ? true : false; */
        /*   }, */
        builder: (context, state) {
          return Expanded(
            child: ListView.builder(
              itemCount: state.groupLists.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                GroupList? groupList = state.groupLists.elementAt(index);
                String groupName = "";
                int groupIndex = 0;
                int groupColorCode = 0;
                String groupID = "";

                if (groupList != null) {
                  groupName = groupList.name;
                  groupIndex = groupList.index;
                  groupColorCode = groupList.colorTag;
                  groupID = groupList.id;
                }

                if (index == 0) {
                  return const SidebarSmartLists();
                } else {
                  return SidebarGroupTiles(
                      groupName: groupName,
                      groupIndex: groupIndex,
                      groupColorCode: groupColorCode,
                      groupID: groupID);
                }
              },
            ),
          );
        },
      );
  }

  @override
  bool get wantKeepAlive => true;
}
