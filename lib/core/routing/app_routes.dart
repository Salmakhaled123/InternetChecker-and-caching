import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userapp/core/network/api_service.dart';
import 'package:userapp/core/routing/routes.dart';
import 'package:userapp/user_feature/data/repo/user_data_repo_imp.dart';
import 'package:userapp/user_feature/presentation/view_model/user_data_cubit.dart';
import 'package:userapp/user_feature/presentation/views/users_view.dart';

class AppRoutes {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.usersView:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => UserDataCubit(UserRepoImp(
                    apiService: ApiService(
                      dio: Dio(),
                    ),
                  ))
                    ..getUsers(),
                  child: const UserView(),
                ));

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
