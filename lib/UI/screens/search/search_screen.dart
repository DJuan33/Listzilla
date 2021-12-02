import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listzilla/DI/app_dependencies.dart';
import 'package:listzilla/UI/global_widgets/task_card.dart';
import 'package:listzilla/domain/controllers/search/search_screen_controller.dart';
import 'package:listzilla/domain/controllers/search/search_screen_state.dart';
import 'package:listzilla/domain/models/task_model.dart';

class SearchScreen extends StatelessWidget {
  final SearchScreenController searchScreenController =
      AppDependencies.dependencyInjector.resolve();
  final TextEditingController searchController = TextEditingController();

  SearchScreen({Key? key}) : super(key: key) {
    searchController.addListener(_updateTasks);
  }

  void togglePriority(String taskID) {
    searchScreenController.toggleTaskPriority(taskID);
  }

  void toggleCompleted(String taskID) {
    searchScreenController.toggleTaskCompleted(taskID);
  }

  // Update list of Tasks on search
  void _updateTasks() {
    searchScreenController.searchTasks(searchController.text);
  }

  ListView getUncompletedTasks(SearchScreenState state) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: state.tasksUncompleted.length,
        itemBuilder: (context, index) {
          Task? task = state.tasksUncompleted[index];

          if (task != null) {
            return TaskCard(
                taskName: task.name,
                taskID: task.id,
                taskCompleted: task.completed,
                taskPriority: task.priority,
                completedFunction: () => toggleCompleted(task.id),
                priorityFunction: () => togglePriority(task.id));
          } else {
            return const Text("a");
          }
        });
  }

  ListView getCompletedTasks(SearchScreenState state) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemCount: state.tasksCompleted.length,
        itemBuilder: (context, index) {
          Task? task = state.tasksCompleted[index];

          if (task != null) {
            return TaskCard(
                taskName: task.name,
                taskID: task.id,
                taskCompleted: task.completed,
                taskPriority: task.priority,
                completedFunction: () => toggleCompleted(task.id),
                priorityFunction: () => togglePriority(task.id));
          } else {
            return const Text("a");
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeContext = Theme.of(context);
    // TODO: Change everything to arrow functions.
    return BlocBuilder<SearchScreenController, SearchScreenState>(
      bloc: searchScreenController,
      builder: (context, state) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 9),
                  padding: const EdgeInsets.symmetric(vertical: 9),
                  child: TextField(
                    style: themeContext.textTheme.bodyText2,
                    controller: searchController,
                    decoration: InputDecoration(
                        hintStyle: themeContext.textTheme.bodyText2!
                            .copyWith(color: Colors.grey),
                        counterStyle: themeContext.textTheme.bodyText2!
                            .copyWith(color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              width: 1.0,
                              color: themeContext.colorScheme.primary),
                        ),
                        hintText: 'Search tasks',
                        border: const UnderlineInputBorder()),
                  ),
                ),
              ),
            ],
          ),
          if (state.tasksCompleted.isEmpty && state.tasksUncompleted.isEmpty)
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 33),
                padding: const EdgeInsets.symmetric(vertical: 100),
                child: DottedBorder(
                  color: Colors.grey,
                  radius: const Radius.circular(100),
                  strokeWidth: 3,
                  dashPattern: const [6, 2],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 33, horizontal: 33),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 33.0),
                          child: Icon(
                            Icons.search,
                            color: Colors.grey,
                            size: 66,
                          ),
                        ),
                        Text(
                          "Search some tasks!",
                          style: themeContext.textTheme.bodyText2!.copyWith(
                            color: Colors.grey,
                            fontSize: 36,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          else
            ...tasksWidgets(state, themeContext),
        ],
      ),
    );
  }

  List<Widget> tasksWidgets(SearchScreenState state, ThemeData themeContext) {
    return [
      Expanded(
        child: ListView(
          children: [
            getUncompletedTasks(state),
            Theme(
              data: themeContext.copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                initiallyExpanded: true,
                title: Text(
                  "Done".toUpperCase(),
                  style: themeContext.textTheme.bodyText1,
                ),
                children: [getCompletedTasks(state)],
              ),
            ),
          ],
        ),
      ),
    ];
  }
}
