import 'package:aspectumai/features/chat/domain/entities/chat_response_entity.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:aspectumai/core/resources/data_state.dart';
import 'package:aspectumai/features/chat/domain/usecases/send_chat.dart';

part 'chat_event.dart';

class ChatBloc extends Bloc<ChatBlocEvent, List<ChatMessageEntity>> {
  ChatBloc(this._sendChatUsecase) : super([]) {
    on<StartChatEvent>(_startChat);
  }

  final SendChatUsecase _sendChatUsecase;

  Future<void> _startChat(
    StartChatEvent event,
    Emitter<List<ChatMessageEntity>> emit,
  ) async {
    final newMessage = event.message;
    final tempMessages = <ChatMessageEntity>[];

    if (state.isNotEmpty) {
      /// add all previous messages
      tempMessages.addAll(state);
    }

    /// add the new message from user
    tempMessages.add(
      ChatMessageEntity(content: newMessage, role: 'user'),
    );
    emit([...tempMessages]);

    try {
      /// add loading indicator while waiting for response
      tempMessages.add(
        const ChatMessageEntity(content: 'loading', role: ''),
      );
      emit([...tempMessages]);

      final response = await _sendChatUsecase.call(newMessage);

      if (response is DataStateSuccess && response.data != null) {
        /// replace the loading indicator with the response
        tempMessages[tempMessages.length - 1] = ChatMessageEntity(
          content: response.data?.message?.content ?? '',
          role: response.data?.message?.role ?? 'assistant',
        );
        emit(tempMessages);
      } else {
        /// replace the loading indicator with a message indicating no response
        tempMessages[tempMessages.length - 1] = const ChatMessageEntity(
          content: 'No Response from API',
          role: '',
        );

        emit(tempMessages);
      }
    } catch (e) {
      /// replace the loading indicator with an error message
      tempMessages[tempMessages.length - 1] = ChatMessageEntity(
        content: 'Error: $e',
        role: '',
      );

      emit(tempMessages);
    }
  }

  // void _startImageChat(
  //   StartImageChatEvent event,
  //   Emitter<List<ChatModel>> emit,
  // ) async {
  //   final newMessage = event.message;
  //   final tempMessages = <ChatModel>[];

  //   if (state.isNotEmpty) tempMessages.addAll(state);

  //   tempMessages.add(
  //     ChatModel(text: newMessage, isUser: true, imagePaths: event.imagePaths),
  //   );
  //   emit([...tempMessages]);

  //   try {
  //     tempMessages.add(
  //       const ChatModel(text: '...', isUser: false, isLoading: true),
  //     );
  //     emit([...tempMessages]);

  //     final result = await _sendChatWithImageUsecase.call(ChatWithImageParams(
  //       message: newMessage,
  //       imagePaths: event.imagePaths,
  //     ));

  //     if (result is DataStateSuccess && result.data != null) {
  //       tempMessages[tempMessages.length - 1] = ChatModel(
  //         text: result.data!,
  //         isUser: false,
  //         isLoading: false,
  //       );
  //       emit(tempMessages);
  //     } else {
  //       tempMessages[tempMessages.length - 1] = const ChatModel(
  //         text: 'No Response from API',
  //         isUser: false,
  //         isLoading: false,
  //       );
  //       emit(tempMessages);
  //     }
  //   } catch (e) {
  //     print(e);
  //     tempMessages[tempMessages.length - 1] = ChatModel(
  //       text: 'Error: $e',
  //       isUser: false,
  //       isLoading: false,
  //     );
  //     emit(tempMessages);
  //   }
  // }
}
