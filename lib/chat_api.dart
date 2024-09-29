import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatApi {
  static const String baseUrl = 'http://10.0.2.2:5001/chat'; // Flask server URL

  // Modified sendMessage to accept userMessage, systemMessageId, and conversationHistory
  static Future<String> sendMessage(String userMessage, int systemMessageId, List<Map<String, String>> conversationHistory) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'message': userMessage,
        'system_message_id': systemMessageId,
        'conversation_history': conversationHistory,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['response'];  // Extract ChatGPT response
    } else {
      final errorData = jsonDecode(response.body);
      throw Exception('Failed to get response from ChatGPT: ${errorData['error']}');
    }
  }
}
