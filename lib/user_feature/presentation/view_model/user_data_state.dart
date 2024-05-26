part of 'user_data_cubit.dart';

@immutable
abstract class UserDataState {}

class UserDataInitial extends UserDataState {}

class UserDataLoading extends UserDataState {}

class UserDataSuccess extends UserDataState {
  final List<UserModel> users;

  UserDataSuccess({required this.users});
}

class UserDataFailure extends UserDataState {}

class UserConnectivityOnline extends UserDataState {}

class UserConnectivityOffline extends UserDataState {}
