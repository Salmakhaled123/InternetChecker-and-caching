import 'package:dio/dio.dart';

class ApiService {
  String baseUrl = 'https://jsonplaceholder.typicode.com/';
  final Dio dio;
  ApiService({required this.dio});
  Future<Response> get(String endPoints) async {
    return await dio.get('$baseUrl$endPoints');
  }
}
