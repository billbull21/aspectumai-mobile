import 'package:aspectumai/core/network/dio_client.dart';
import 'package:aspectumai/features/chat/data/data_sources/chat_source.dart';
import 'package:aspectumai/features/chat/data/models/chat_response_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

class MockDioClient extends Mock implements DioClient {}

final _postData = {
  'model': 'gpt-4o-mini',
  'messages': [
    {
      'content': 'Hi!',
      'role': 'user',
    },
  ],
};

void main() {
  late DioClient dioClient;
  late ChatSource chatSource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    dioClient = DioClient(dio: mockDio, isUnittest: true);
    chatSource = ChatSourceImpl(dioClient);
  });

  group('chat source test', () {
    test('get data success', () async {
      when(
        () => dioClient.post(
          'https://api.openai.com/v1/chat/completions',
          data: _postData,
        ),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(),
          data: {
            'choices': [
              {
                'message': {
                  'content': 'Hi!',
                  'role': 'assistance',
                },
              }
            ]
          },
        ),
      );

      await chatSource.sendMessage([
        const ChatMessageModel(content: 'Hi!', role: 'user'),
      ]);

      verify(
        () => dioClient.post(
          'https://api.openai.com/v1/chat/completions',
          data: _postData,
        ),
      ).called(1);
    });
  });
}
