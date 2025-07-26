import 'package:aspectumai/core/bloc/base_state.dart';
import 'package:aspectumai/features/chat/repositories/chat_repository.dart';
import 'package:bloc/bloc.dart';

part 'create_chat_session_state.dart';

class CreateChatSessionCubit extends Cubit<CreateChatSessionState> {
  CreateChatSessionCubit(this._chatRepository)
      : super(const CreateChatSessionState());
  final IChatRepository _chatRepository;

  Future<void> createChatSession() async {
    emit(state.copyWith(isLoading: true));
    try {
      await _chatRepository.createChatSession();
      emit(state.copyWith(isLoading: false, data: 'Chat session created'));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }
}
