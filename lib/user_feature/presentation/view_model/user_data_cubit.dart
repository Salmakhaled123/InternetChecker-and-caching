import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:userapp/core/network/connection.dart';
import 'package:userapp/user_feature/data/models/user_model.dart';
import '../../data/repo/user_data_repo.dart';
part 'user_data_state.dart';

class UserDataCubit extends Cubit<UserDataState> {
  UserDataCubit(this.userRepo) : super(UserDataInitial());
  final UserRepo userRepo;
  List<UserModel> users = [];
  Future getUsers() async {
    emit(UserDataLoading());
    var result = await userRepo.getUsers();
    result.fold(
      (failure) => emit(UserDataFailure()),
      (newUsers) {
        users = newUsers;
        emit(UserDataSuccess(users: users));
      },
    );
  }
}
