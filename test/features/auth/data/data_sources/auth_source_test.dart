import 'package:aspectumai/core/network/dio_client.dart';
import 'package:aspectumai/features/auth/data/data_sources/auth_source.dart';
import 'package:aspectumai/features/auth/data/models/login_response_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../core/network/dio_client_test.dart';

void main() {
  late MockDio mockDio;
  late DioClient dioClient;
  late AuthSource loginSource;

  setUp(() {
    mockDio = MockDio();
    dioClient = DioClient(dio: mockDio, isUnittest: true);
    loginSource = AuthSource(dioClient);
  });

  group('login source test', () {
    test('success', () async {
      when(
        () => mockDio.post('auth/sign-in', data: {
          'email': 'email',
          'password': 'password',
        }),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(
            path: 'auth/sign-in',
          ),
          statusCode: 200,
          data: {
            "meta": {
              "success": true,
              "code": 200,
              "status": "Success",
              "message": "Sign In Successfully!"
            },
            "data": {
              "token":
                  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImZlYnJ5YXJkaWFuc3lhaDI3QGdtYWlsLmNvbSIsImlhdCI6MTc0Mzc0NzgwM30._dQ9Qu2G7_Nd5pTzgFiWHvhuk1a48b5b5JE6w9xXGto",
              "id": "1",
              "created_at": "2025-04-04T06:22:17.000Z",
              "updated_at": "2025-04-04T06:23:20.427Z",
              "name": "febry",
              "username": "febryards",
              "email": "febryardiansyah27@gmail.com",
              "isEmailVerified": true
            }
          },
        ),
      );

      final result = await loginSource.login('email', 'password');

      expect(result, isA<LoginResponseModel>());
      verify(
        () => mockDio.post(
          'auth/sign-in',
          data: {
            'email': 'email',
            'password': 'password',
          },
        ),
      ).called(1);
    });

    test('failure', () {
      when(
        () => mockDio.post('auth/sign-in', data: {
          'email': 'email',
          'password': 'password',
        }),
      ).thenThrow(DioException(requestOptions: RequestOptions()));

      expect(
        () async => await loginSource.login('email', 'password'),
        throwsA(isA<DioException>()),
      );
      verify(
        () => mockDio.post(
          'auth/sign-in',
          data: {
            'email': 'email',
            'password': 'password',
          },
        ),
      ).called(1);
    });
  });
}
