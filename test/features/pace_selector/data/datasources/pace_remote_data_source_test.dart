import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:swim_test/core/error/exceptions.dart';
import 'package:swim_test/core/network/api_constants.dart';
import 'package:swim_test/features/pace_selector/data/datasources/pace_remote_data_source.dart';
import 'package:swim_test/features/pace_selector/data/models/pace_request_model.dart';

class MockHttpClient extends Mock implements http.Client {}

class FakeUri extends Fake implements Uri {}

void main() {
  late PaceRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUpAll(() {
    registerFallbackValue(FakeUri());
  });

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = PaceRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('submitPace', () {
    final tPaceRequestModel = PaceRequestModel(paceSeconds: 137);

    test('should perform a POST request with correct URL and body', () async {
      when(() => mockHttpClient.post(any(),
              headers: any(named: 'headers'), body: any(named: 'body')))
          .thenAnswer((_) async => http.Response('{}', 201));

      await dataSource.submitPace(tPaceRequestModel);

      verify(() => mockHttpClient.post(
            Uri.parse(ApiConstants.posts),
            headers: {'Content-Type': 'application/json'},
            body: json.encode(tPaceRequestModel.toJson()),
          ));
    });

    test('should throw a ServerException when the response code is not 200 or 201', () async {
      when(() => mockHttpClient.post(any(),
              headers: any(named: 'headers'), body: any(named: 'body')))
          .thenAnswer((_) async => http.Response('Something went wrong', 404));

      final call = dataSource.submitPace;

      expect(() => call(tPaceRequestModel), throwsA(isA<ServerException>()));
    });

    test('should throw a ServerException when http client throws an error', () async {
      when(() => mockHttpClient.post(any(),
              headers: any(named: 'headers'), body: any(named: 'body')))
          .thenThrow(Exception('Network error'));

      final call = dataSource.submitPace;

      expect(() => call(tPaceRequestModel), throwsA(isA<ServerException>()));
    });
  });
}
