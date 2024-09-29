import 'package:flutter/material.dart';
import 'chat_api.dart';

class ChatScreen extends StatefulWidget {
  final String chatbotType;

  ChatScreen({required this.chatbotType});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, String>> _messages = []; // To store the conversation history

  // Function to get the initial system message
  String _getInitialMessage() {
    return "Hey, how are you? You are so brave for taking this first step towards improving your mental health! What's your name?";
  }

  // Get the system message ID based on chatbot type
  int _getSystemMessageId(String chatbotType) {
    switch (chatbotType) {
      case 'General Help':
        return 1;
      case 'Sorority Girl/Frat Brother':
        return 2;
      case 'Studious Upperclassman':
        return 3;
      case 'Athlete/Football Player':
        return 4;
      case 'Laid Back Student':
        return 5; // Add corresponding ID for other chatbot types if needed
      default:
        return 0; // Default case
    }
  }

  @override
  void initState() {
    super.initState();

    // Add the initial message at the start of the conversation
    _messages.add({
      'sender': 'bot',
      'message': _getInitialMessage(),
    });
  }

  void _sendMessage() async {
    if (_controller.text.isNotEmpty) {
      String userMessage = _controller.text;
      int systemMessageId = _getSystemMessageId(widget.chatbotType);

      // Add user message to the list
      setState(() {
        _messages.add({'sender': 'user', 'message': userMessage});
        _controller.clear(); // Clear input field after sending
      });

      try {
        // Prepare conversation history
        List<Map<String, String>> conversationHistory = [];
        for (var message in _messages) {
          conversationHistory.add({
            'role': message['sender'] == 'user' ? 'user' : 'assistant',
            'content': message['message'] ?? '', // Provide a default value
          });
        }

        // Send message and conversation history
        String response = await ChatApi.sendMessage(userMessage, systemMessageId, conversationHistory);

        // Add bot response to the list
        setState(() {
          _messages.add({'sender': 'bot', 'message': response});
        });
      } catch (error) {
        setState(() {
          _messages.add({'sender': 'bot', 'message': 'Error: $error'});
        });
      }
    }
  }

  // Widget to build the iMessage-style chat bubbles
  Widget _buildMessage(String sender, String message) {
    bool isUser = sender == 'user';
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: isUser ? 60.0 : 10.0),
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
          color: isUser ? Color(0xFF007AFF) : Color(0xFFE5E5EA), 
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: isUser ? Radius.circular(20) : Radius.zero,
            bottomRight: isUser ? Radius.zero : Radius.circular(20),
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Text(
          message,
          style: TextStyle(
            color: isUser ? Colors.white : Colors.black,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chatbotType),
        backgroundColor: Color(0xFF007AFF),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              reverse: true, 
              itemBuilder: (context, index) {
                final message = _messages[_messages.length - 1 - index];
                return _buildMessage(message['sender']!, message['message']!);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'How are you feeling?',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Color(0xFF007AFF),
                  child: IconButton(
                    icon: Icon(Icons.send, color: Colors.white),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Color(0xFFF5F5F5), // Light grey background to resemble iMessage
    );
  }
}
