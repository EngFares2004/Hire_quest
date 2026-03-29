

import '../../domain/model_data/user_data.dart';

abstract class AppEvent {}

class SignupEvent extends AppEvent {
  final UserData userData;

  SignupEvent({required this.userData});
}
class ToggleTermsEvent extends AppEvent {}

class ClickEvent extends AppEvent {}

class SaveEvent extends AppEvent {}

class CancelSignupEvent extends AppEvent {}

class ResetSignupEvent extends AppEvent {}