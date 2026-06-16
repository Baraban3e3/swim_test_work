import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:swim_test/core/error/exceptions.dart';
import 'package:swim_test/core/network/api_constants.dart';
import 'package:swim_test/features/users/data/models/user_model.dart';

abstract class UsersRemoteDataSource {
  Future<List<UserModel>> getUsers();
}

class UsersRemoteDataSourceImpl implements UsersRemoteDataSource {
  final http.Client client;

  UsersRemoteDataSourceImpl({required this.client});

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final response = await client.get(Uri.parse(ApiConstants.users));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => UserModel.fromJson(json)).toList();
      } else {
        throw ServerException('Failed to load users');
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException('Network error');
    }
  }
}
