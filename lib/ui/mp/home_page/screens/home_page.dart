import 'package:flutter/material.dart';
import 'package:smart_retiree/ui/mp/home_page/screens/notification_tap.dart';
import 'package:smart_retiree/ui/mp/home_page/screens/text_to_speech.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0,
        title: const Text(
          'S M A R T  R E T I R E E',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'RobotoMono', // Updated to use RobotoMono font family
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
            color: Colors.black,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TextToSpeech(),
                ),
              );
            },
            icon: const Icon(Icons.mic)),
        actions: [
          IconButton(
              color: Colors.black,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotitcationTap(),
                  ),
                );
              },
              icon: const Icon(Icons.notifications))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildBox(
              icon: Icons.school,
              text: 'Share Knowledge',
              color: Colors.grey[350] ?? Colors.red,
            ),
            _buildBox(
              icon: Icons.coffee,
              text: 'Leisure & lifestyle',
              color: Colors.grey,
            ),
            _buildBox(
              icon: Icons.event,
              text: 'Events',
              color: Colors.grey[350] ?? Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBox(
      {required IconData icon, required String text, required Color color}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 8.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 40.0, color: Colors.black),
          const SizedBox(height: 12.0),
          Text(
            text,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
