import 'package:equatable/equatable.dart';

class ChatResponseEntity extends Equatable {
  final int? index;
  final ChatMessageEntity? message;
  final dynamic logprobs;
  final String? finishReason;

  const ChatResponseEntity({
    this.index,
    this.message,
    this.logprobs,
    this.finishReason,
  });

  @override
  List<Object?> get props => [index, message, logprobs, finishReason];
}

class ChatMessageEntity extends Equatable {
  final String? role;
  final String? content;
  final String? refusal;

  const ChatMessageEntity({
    this.role,
    this.content,
    this.refusal,
  });

  @override
  List<Object?> get props => [role, content, refusal];
}
