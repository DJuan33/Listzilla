import 'package:equatable/equatable.dart';
import 'package:listzilla/domain/models/group_list_model.dart';
import 'package:listzilla/domain/models/task_list_model.dart';

/// This class defines the State for the `HomeScreenController`.
class SidebarScreenState extends Equatable {
  /// The list of [GroupList] showed in screen.
  final List<GroupList?> groupLists;

  /// The list of lists of [TaskList] showed in screen.
  /// Every item of the list contains the list of taskLists of the respective [GroupList]
  final Map<String,List<TaskList?>> taskLists;

  /// The current TaskList Selected.
  /// Useful for setting the [TaskListScreen] in the [HomeScreen].
  final String currentTaskListID;

  const SidebarScreenState({
    required this.groupLists,
    required this.taskLists,
    required this.currentTaskListID,
  });

  SidebarScreenState copyWith({
    List<GroupList?>? groupLists,
    Map<String,List<TaskList?>>? taskLists,
    String? currentTaskListID,
  }) {
    return SidebarScreenState(
      groupLists: groupLists ?? this.groupLists,
      taskLists: taskLists ?? this.taskLists,
      currentTaskListID: currentTaskListID ?? this.currentTaskListID,
    );
  }

  static SidebarScreenState initial = const SidebarScreenState(
    taskLists: {},
    groupLists: [],
    currentTaskListID: "Priority",
  );

  @override
  List<Object?> get props => [
        groupLists,
        taskLists,
        currentTaskListID,
      ];
}
