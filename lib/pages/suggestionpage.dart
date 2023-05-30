import 'package:contactus/contactus.dart';
import 'package:flutter/material.dart';

class SuggestionPage extends StatelessWidget {
  const SuggestionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contacto')),
      backgroundColor: const Color.fromARGB(255, 57, 120, 192),
      body: ContactUs(
        cardColor: Colors.white,
        textColor: Colors.teal.shade900,
        logo: const AssetImage('assets/light.PNG'),
        email: 'omareogm09@gmail.com',
        companyName: 'Edo09',
        companyColor: Colors.teal.shade100,
        dividerThickness: 2,
        tagLine: 'Desarrollador de la App',
        taglineColor: Colors.teal.shade100,
        twitterHandle: 'tictocpunk',
        avatarRadius: 80,
        discordHandle: 'discord.app/users/294806532825022474',
      ),
    );
  }
}
