part of 'create_chat_session_cubit.dart';

final class CreateChatSessionState extends BaseState {
  const CreateChatSessionState({
    super.isLoading,
    super.data,
    super.errorMessage,
  });

  @override
  CreateChatSessionState copyWith({
    bool? isLoading,
    data,
    String? errorMessage,
  }) {
    return CreateChatSessionState(
      isLoading: isLoading ?? this.isLoading,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
