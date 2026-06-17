import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:swim_test/features/users/data/models/user_model.dart';

void main() {
  const tUserModel = UserModel(
    id: 1,
    name: 'Leanne Graham',
    username: 'Bret',
    email: 'Sincere@april.biz',
    phone: '1-770-736-8031 x56442',
    website: 'hildegard.org',
    companyName: 'Romaguera-Crona',
  );

  group('UserModel', () {
    test('should be a subclass of UserEntity', () {
      expect(tUserModel, isA<UserModel>());
    });

    test('should return a valid model from JSON', () {
      const jsonString = '''
      {
        "id": 1,
        "name": "Leanne Graham",
        "username": "Bret",
        "email": "Sincere@april.biz",
        "address": {
          "street": "Kulas Light"
        },
        "phone": "1-770-736-8031 x56442",
        "website": "hildegard.org",
        "company": {
          "name": "Romaguera-Crona",
          "catchPhrase": "Multi-layered client-server neural-net",
          "bs": "harness real-time e-markets"
        }
      }
      ''';

      final Map<String, dynamic> jsonMap = json.decode(jsonString);

      final result = UserModel.fromJson(jsonMap);

      expect(result, equals(tUserModel));
    });
  });
}
