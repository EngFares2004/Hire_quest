abstract class AppEvent{}
class LoginEvent extends AppEvent{
  final String email;
  final String password;


  LoginEvent({required this.email, required this.password,});
}
class ClickEvent extends AppEvent{}
class SaveEvent extends AppEvent{}
class LoadSavedUserEvent extends AppEvent {}

class LoadTokenEvent extends AppEvent {}
