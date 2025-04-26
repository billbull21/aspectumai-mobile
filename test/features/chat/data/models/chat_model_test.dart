import 'package:aspectumai/features/chat/data/models/chat_response_model.dart';
import 'package:aspectumai/features/chat/domain/entities/chat_response_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('chat model', () {
    test('subclass of ChatEntity', () {
      expect(
        const ChatResponseModel(
          message: ChatMessageModel(content: 'Hi!', role: 'user'),
        ),
        isA<ChatResponseEntity>(),
      );
    });

    test('is same model', () {
      const chat1 = ChatResponseModel(
        message: ChatMessageModel(content: 'Hi!', role: 'user'),
      );
      const chat2 = ChatResponseModel(
        message: ChatMessageModel(content: 'Hi!', role: 'user'),
      );

      expect(chat1, chat2);
    });

    test('to entity', () {
      const chat1 = ChatResponseModel(
        message: ChatMessageModel(content: 'Hi!', role: 'user'),
      );
      final toEntity = chat1.toEntity();

      expect(toEntity, isA<ChatResponseEntity>());
    });

    test('parse json', () {
      final chat = ChatResponseModel.fromMap(
        const {
          'message': {
            'content': 'Hi!',
            'role': 'user',
          },
        },
      );

      expect(chat.message?.content, 'Hi!');
      expect(chat.message?.role, 'user');
    });
  });
}
