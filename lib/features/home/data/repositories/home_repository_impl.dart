import '../../domain/entities/home_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_datasource.dart';
import '../models/home_model.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeDataSource datasource;

  HomeRepositoryImpl(this.datasource);

  @override
  Future<HomeEntity> getHome() async {
    final data = await datasource.fetchHome();
    return HomeModel.fromApi(data);
  }
}