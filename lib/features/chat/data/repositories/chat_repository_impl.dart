import 'package:aspectumai/core/resources/data_state.dart';
import 'package:aspectumai/features/chat/data/data_sources/chat_source.dart';
import 'package:aspectumai/features/chat/data/models/chat_response_model.dart';
import 'package:aspectumai/features/chat/domain/entities/chat_response_entity.dart';
import 'package:aspectumai/features/chat/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl extends ChatRepository {
  final ChatSource _chatSource;

  ChatRepositoryImpl(this._chatSource);

  @override
  Future<DataState<ChatResponseEntity>> sendMessage(
    List<ChatMessageEntity> messages,
  ) async {
    final messagesToModel = messages.map((message) => ChatMessageModel(
      content: message.content,
      role: message.role,
    )).toList();

    try {
      final response = await _chatSource.sendMessage(messagesToModel);

      return DataStateSuccess(response.toEntity());
    } catch (e) {
      return DataStateError(e.toString());
    }
  }
}
