import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listzilla/DI/app_dependencies.dart';
import 'package:listzilla/domain/controllers/home/home_screen_state.dart';
import 'package:listzilla/domain/controllers/intro/intro_screen_controller.dart';
import 'package:listzilla/domain/repositories/user_repository.dart';

/// The controller of the Home Screen builted with BLoC.
class HomeScreenController extends Cubit<HomeScreenState> {
  final UserRepositoryInterface userRepository;

  // TODO: Initial Data lazy loading;
  final InitialData initialDataAdder = InitialData(
    groupListDBConnection: AppDependencies.dependencyInjector.resolve(),
    taskListDBConnection: AppDependencies.dependencyInjector.resolve(),
    taskDBConnection: AppDependencies.dependencyInjector.resolve(),
  );

  HomeScreenController({required this.userRepository})
      : super(HomeScreenState.initial);

  void setTabIndex(int tabIndex) {
    emit(state.copyWith(tabIndex: tabIndex));
  }

  bool checkUserExists() {
    return userRepository.userExists();
  }

  Future<void> createNewUser() async {
    String newUserID = await userRepository.createNewUser();
    emit(state.copyWith(userID: newUserID,dataAdded:false));
  }


  bool checkDataAdded() {
    setLoadingFalse();
    return userRepository.isDataAdded(state.userID);
  }

  void setLoadingFalse() {
    emit(state.copyWith(isLoading: false));
  }

  void setControllersLoadedTrue() {
    emit(state.copyWith(controllersLoaded: true));
  }

  void addData() {
    initialDataAdder.addInitialData();
    setDataAdded();
    emit(state.copyWith(dataAdded: true));
  }

  void setDataAdded() {
    userRepository.setDataAdded();
  }

  void openTaskDetailScreen(bool showTaskDetailScreen){
    emit(state.copyWith(showTaskDetail: showTaskDetailScreen ));
  }

}
