import 'package:equatable/equatable.dart';

/// This class defines the State for the `HomeScreenController`.
class HomeScreenState extends Equatable {
  /// Tab index for the `Tabview` navigator of the app.
  final int tabIndex;

  /// The ID of the current user.
  final String userID;

  /// Indicates the user watched the introduction screen.
  final bool dataAdded;

  /// Keep the app loading if true.
  final bool isLoading;

  /// Indicates if the controllers (Sidebar,Calendar,Pomodoro) are loaded;
  final bool controllersLoaded;

  /// Indicates if the [TaskDetail] screen in the [HomeScreen] is showing.
  final bool showTaskDetail;

  const HomeScreenState({
    required this.tabIndex,
    required this.userID,
    required this.dataAdded,
    required this.isLoading,
    required this.controllersLoaded,
    required this.showTaskDetail,
  });

  /// Returns a copy of the state with the given fields replaced.
  HomeScreenState copyWith({
    int? tabIndex,
    String? userID,
    bool? dataAdded,
    bool? isLoading,
    bool? controllersLoaded,
    bool? showTaskDetail,
  }) {
    return HomeScreenState(
      tabIndex: tabIndex ?? this.tabIndex,
      userID: userID ?? this.userID,
      dataAdded: dataAdded ?? this.dataAdded,
      isLoading: isLoading ?? this.isLoading,
      controllersLoaded: controllersLoaded ?? this.controllersLoaded,
      showTaskDetail: showTaskDetail ?? this.showTaskDetail,
    );
  }

  /// Inital state for the [HomeScreenController].
  static HomeScreenState initial = const HomeScreenState(
    tabIndex: 0,
    userID: "",
    dataAdded: true,
    isLoading: true,
    controllersLoaded:false,
    showTaskDetail: false,
  );

  /// Get the list of properties for instance comparison.
  @override
  List<Object?> get props => [
        tabIndex,
        userID,
        dataAdded,
        isLoading,
        controllersLoaded,
        showTaskDetail,
      ];
}
