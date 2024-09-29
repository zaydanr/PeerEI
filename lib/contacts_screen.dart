import 'package:flutter/material.dart';
import 'contact_model.dart';
import 'chat_screen.dart';
import 'gt_resources_screen.dart'; // Import the GT Resources screen

class ContactsScreen extends StatelessWidget {
  final List<ContactModel> contacts = [
    ContactModel(
      name: 'General Help',
      description: 'A friendly peer who provides general mental health support.',
    ),
    ContactModel(
      name: 'Sorority Girl / Frat Brother',
      description: 'Someone from Greek life who understands social pressures.',
    ),
    ContactModel(
      name: 'Studious Upperclassman',
      description: 'An experienced upperclassman who handles heavy workloads.',
    ),
    ContactModel(
      name: 'Athlete/Football Player',
      description: 'A peer who understands the life of a student athlete.',
    ),
    ContactModel(
      name: 'Laid Back Student',
      description: 'A relaxed student who knows how to de-stress.',
    ),
    ContactModel(
      name: 'GT Resources',
      description: 'Access campus mental health resources.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Your Chatbot'),
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(contacts[index].name),
            subtitle: Text(contacts[index].description),
            onTap: () {
              if (contacts[index].name == 'GT Resources') {
                // Navigate to the GT Resources screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GTResourcesScreen(),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(
                      chatbotType: contacts[index].name,
                    ),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
