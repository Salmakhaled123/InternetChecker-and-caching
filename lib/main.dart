import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:userapp/core/bloc_observer.dart';
import 'package:userapp/core/routing/app_routes.dart';
import 'package:userapp/user_feature/data/models/user_model.dart';
import 'core/routing/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyObserver();
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());

  runApp(MyApp(
    appRoutes: AppRoutes(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRoutes});
  final AppRoutes appRoutes;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Routes.usersView,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRoutes.onGenerateRoute,
    );
  }
}
