import 'package:aspectumai/core/network/dio_client.dart';
import 'package:aspectumai/features/chat/data/models/chat_response_model.dart';
import 'package:dio/dio.dart';

abstract class ChatSource {
  Future<ChatResponseModel> sendMessage(String message);
  // Future<String> sendMessageWithImage(String message, List<String> imagePaths);
}

class ChatSourceImpl implements ChatSource {
  final DioClient _dioClient;

  ChatSourceImpl(DioClient dioClient) : _dioClient = dioClient;

  @override
  Future<ChatResponseModel> sendMessage(String message) async {
    final response = await _dioClient.post(
      'https://api.openai.com/v1/chat/completions',
      data: {
        'model': 'gpt-4o-mini',
        'messages': [
          {'role': 'system', 'content': 'You are a helpful assistant.'},
          {'role': 'user', 'content': message},
        ],
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
