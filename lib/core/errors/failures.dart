abstract class Failure {}

class ServerFailure extends Failure {
  final String errorMessage;
  ServerFailure({required this.errorMessage});
}
