import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:swim_test/core/error/exceptions.dart';
import 'package:swim_test/core/network/api_constants.dart';
import 'package:swim_test/features/pace_selector/data/models/pace_request_model.dart';

abstract class PaceRemoteDataSource {
  Future<void> submitPace(PaceRequestModel model);
}

class PaceRemoteDataSourceImpl implements PaceRemoteDataSource {
  final http.Client client;

  PaceRemoteDataSourceImpl({required this.client});

  @override
  Future<void> submitPace(PaceRequestModel model) async {
    try {
      final response = await client.post(
        Uri.parse(ApiConstants.posts),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(model.toJson()),
      );

      if (response.statusCode != 201 && response.statusCode != 200) {
        throw ServerException('Failed to submit pace');
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException('Network error');
    }
  }
}
