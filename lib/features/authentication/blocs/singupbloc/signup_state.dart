abstract class AppState {}

class InitialState extends AppState {
  final bool isAccepted;
  InitialState({this.isAccepted = false});
}

class RefreshUIState extends AppState {
  final bool isAccepted;
  RefreshUIState({required this.isAccepted});

}
class LoadingState extends AppState {
  final bool isAccepted;
  LoadingState({required this.isAccepted});
}

class SuccessState extends AppState {
  final String data;
  SuccessState({required this.data});
}

class FailureState extends AppState {

  final String error;
  FailureState({required this.error});
}

class EmptyState extends AppState {}
