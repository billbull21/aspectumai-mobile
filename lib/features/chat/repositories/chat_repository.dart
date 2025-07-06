import 'package:aspectumai/core/network/dio_client.dart';
import 'package:aspectumai/features/chat/models/chat_response_model.dart';
import 'package:dio/dio.dart';

abstract class IChatRepository {
  Future<ChatResponseModel> sendMessage(List<ChatMessageModel> messages);
  // Future<String> sendMessageWithImage(String message, List<String> imagePaths);
}

class ChatRepository implements IChatRepository {
  final DioClient _dioClient;

  ChatRepository(DioClient dioClient) : _dioClient = dioClient;

  @override
  Future<ChatResponseModel> sendMessage(List<ChatMessageModel> messags) async {
    final response = await _dioClient.post(
      'https://api.openai.com/v1/chat/completions',
      data: {
        'model': 'gpt-4o-mini',
        'messages': messags.map((e) => e.toMap()).toList(),
      },
    );

    if (response.statusCode == 200 && response.data['choices'] != null) {
      return ChatResponseModel.fromMap(response.data['choices'][0]);
    } else {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        message: response.data.toString(),
      );
    }
  }
}
