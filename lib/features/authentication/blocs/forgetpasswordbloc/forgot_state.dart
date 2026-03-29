abstract class AppState {}
class InitialState extends AppState {}
class LoadingState extends AppState {}
class SuccessState extends AppState {
  final dynamic data ;
  SuccessState({required this.data});
}
class EmptyState extends AppState {}
class ErrorState extends AppState {
  final String message;

  ErrorState({required this.message});
}