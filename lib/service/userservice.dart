import 'package:dio/dio.dart';
import 'package:flutter_application_1/models/usermodel.dart';


class UserService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://dummyjson.com',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  Future<List<User>> fetchUsers() async {
    try {
      final response = await _dio.get('/users');
      final List<dynamic> usersJson = response.data['users'] ?? [];
      return usersJson.map((e) => User.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Failed to load users');
    } catch (e) {
      throw Exception('Failed to load users');
    }
  }

  Future<User> fetchUserById(int id) async {
    try {
      final response = await _dio.get('/users/$id');
      return User.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Failed to load user');
    } catch (e) {
      throw Exception('Failed to load user');
    }
  }
}
