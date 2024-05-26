import 'package:dartz/dartz.dart';
import 'package:userapp/core/errors/failures.dart';
import 'package:userapp/user_feature/data/models/user_model.dart';

abstract class UserRepo {
  Future<Either<Failure, List<UserModel>>> getUsers();
}
