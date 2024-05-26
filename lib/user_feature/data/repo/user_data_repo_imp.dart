import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:userapp/core/errors/failures.dart';
import 'package:userapp/core/network/api_service.dart';
import 'package:userapp/core/network/connection.dart';
import 'package:userapp/user_feature/data/models/user_model.dart';
import 'package:userapp/user_feature/data/repo/user_data_repo.dart';

class UserRepoImp extends UserRepo {
  final ApiService apiService;

  UserRepoImp({required this.apiService});
  @override
  Future<Either<Failure, List<UserModel>>> getUsers() async {
    try {
      var box = await Hive.openBox<UserModel>('users');
      List<UserModel> users = [];
      if (await Connection.checkInternetConnection()) {
        if (box.isNotEmpty) {
          box.clear();
        }
        var response = await apiService.get('users');
        response.data.map((user) {
          users.add(UserModel.fromJson(user));
        }).toList();
        await box.addAll(users);
      } else {
        users = box.values.toList();
      }
      return Right(users);
    } on Exception catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }
}
