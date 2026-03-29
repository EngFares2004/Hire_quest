
import '../../domain/entities/home_entity.dart';

abstract class HomeState {}

class HomeLoading extends HomeState {}

class HomeBeforeInterview extends HomeState {
  final HomeEntity data;
  HomeBeforeInterview(this.data);
}

class HomeAfterInterview extends HomeState {
  final HomeEntity data;
  HomeAfterInterview(this.data);
}
