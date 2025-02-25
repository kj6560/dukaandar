import 'package:dio/dio.dart';
import 'package:dukaandaar/features/home/data/repositories/home_repository.dart';
import 'package:dukaandaar/features/product/data/repositories/product_repository.dart';
import 'package:dukaandaar/features/sales/data/repositories/sales_repository.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/data/repositories/auth_repository.dart';

final injector = GetIt.instance;

Future<void> init() async {
  injector.registerLazySingleton<Dio>(() => Dio());

  injector.registerFactory<AuthRepositoryImpl>(() {
    return AuthRepositoryImpl(dio: injector());
  });
  injector.registerFactory<HomeRepositoryImpl>(() {
    return HomeRepositoryImpl(dio: injector());
  });
  injector.registerFactory<ProductRepositoryImpl>(() {
    return ProductRepositoryImpl(dio: injector());
  });
  injector.registerFactory<SaleRepositoryImpl>(() {
    return SaleRepositoryImpl(dio: injector());
  });
}
