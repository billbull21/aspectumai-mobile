import 'package:aspectumai/core/resources/data_state.dart';
import 'package:aspectumai/features/chat/domain/entities/chat_response_entity.dart';

abstract class ChatRepository {
  Future<DataState<ChatResponseEntity>> sendMessage(
    List<ChatMessageEntity> messages,
  );
  // Future<DataState<String>> sendMessageWithImage(
  //   String message,
  //   List<String> imagePaths,
  // );
}
