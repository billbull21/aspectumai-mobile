import 'package:aspectumai/features/chat/domain/entities/chat_response_entity.dart';

class ChatResponseModel extends ChatResponseEntity {
  const ChatResponseModel({
    super.index,
    super.message,
    super.finishReason,
    super.logprobs,
  });

  factory ChatResponseModel.fromMap(Map<String, dynamic> map) {
    return ChatResponseModel(
      index: map['index'],
      message: ChatMessageModel.fromMap(map['message']),
      finishReason: map['finish_reason'],
      logprobs: map['logprobs'],
    );
  }

  ChatResponseEntity toEntity() {
    return ChatResponseEntity(
      index: index,
      message: message,
      finishReason: finishReason,
      logprobs: logprobs,
    );
  }
}

class ChatMessageModel extends ChatMessageEntity {
  const ChatMessageModel({
    super.role,
    super.content,
    super.refusal,
  });

  factory ChatMessageModel.fromMap(Map<String, dynamic> map) {
    return ChatMessageModel(
      role: map['role'],
      content: map['content'],
      refusal: map['refusal'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'role': role,
      'content': content,
      'refusal': refusal,
    };
  }

  ChatMessageEntity toEntity() {
    return ChatMessageEntity(
      role: role,
      content: content,
      refusal: refusal,
    );
  }
}
