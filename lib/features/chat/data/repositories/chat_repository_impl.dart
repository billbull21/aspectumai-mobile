import 'package:aspectumai/core/resources/data_state.dart';
import 'package:aspectumai/features/chat/data/data_sources/chat_source.dart';
import 'package:aspectumai/features/chat/domain/entities/chat_response_entity.dart';
import 'package:aspectumai/features/chat/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl extends ChatRepository {
  final ChatSource _chatSource;

  ChatRepositoryImpl(this._chatSource);

  @override
  Future<DataState<ChatResponseEntity>> sendMessage(String message) async {
    try {
      final response = await _chatSource.sendMessage(message);

      return DataStateSuccess(response.toEntity());
    } catch (e) {
      return DataStateError(e.toString());
    }
  }
}
