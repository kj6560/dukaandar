import 'package:dukaandaar/core/local/hive_Services.dart';
import 'package:dukaandaar/core/local/hive_constants.dart';
import 'package:dukaandaar/features/home/data/repositories/home_repository.dart';
import 'package:dukaandaar/features/product/data/repositories/product_repository.dart';
import 'package:dukaandaar/features/product/presentation/bloc/product_bloc.dart';
import 'package:dukaandaar/features/sales/data/repositories/sales_repository.dart';
import 'package:dukaandaar/features/sales/presentation/bloc/sales_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

import 'core/config/theme.dart';
import 'core/di/injector.dart';
import 'core/routes.dart';
import 'features/auth/presentation/forgot_pass/bloc/forgot_pass_bloc.dart';
import 'features/auth/presentation/login/bloc/login_bloc.dart';
import 'features/auth/presentation/register/bloc/register_bloc.dart';
import 'features/home/presentation/bloc/home_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await getApplicationDocumentsDirectory();
  await init();
  //await firebaseInit();
  await Hive.initFlutter(directory.path);
  await HiveService.openBoxes();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  bool is_loggedin() {
    if (authBox.get(HiveKeys.accessToken) != null) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) {
          return LoginBloc(injector());
        }),
        BlocProvider(create: (context) {
          return RegisterBloc(authRepository: injector());
        }),
        BlocProvider(create: (context) {
          return ForgotPasswordBloc(authRepository: injector());
        }),
        BlocProvider(create: (context) {
          return HomeBloc(HomeRepositoryImpl(dio: injector()));
        }),
        BlocProvider(create: (context) {
          return ProductBloc(ProductRepositoryImpl(dio: injector()));
        }),
        BlocProvider(create: (context) {
          return SalesBloc(SaleRepositoryImpl(dio: injector()));
        }),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'UNIV',
        theme: appTheme,
        initialRoute: is_loggedin() ? AppRoutes.home : AppRoutes.login,
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}
