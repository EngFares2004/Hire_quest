import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/home_repository.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository repository;

  HomeCubit(this.repository) : super(HomeLoading());

  Future<void> loadHome() async {
    emit(HomeLoading());
    final data = await repository.getHome();

    if (data.hasInterview) {
      emit(HomeAfterInterview(data));
    } else {
      emit(HomeBeforeInterview(data));
    }
  }
}
