abstract class AppEvent{}
class ForgetEvent extends AppEvent{
  final String emailaddress;



  ForgetEvent({
    required this.emailaddress,
  });
}
class ClickEvent extends AppEvent{}
class SaveEvent extends AppEvent{}