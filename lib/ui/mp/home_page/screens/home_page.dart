import 'package:flutter/material.dart';
import 'package:smart_retiree/utils/constants.dart';

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
        title: Text(
          'Smart Retiree',
          style: TextStyle(
            fontFamily: 'Lobster',
            fontSize: 30.0,
            color: Constants.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 4.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildBox(
              icon: Icons.school,
              text: 'Share Knowledge',
              color: Colors.blueAccent,
            ),
            _buildBox(
              icon: Icons.coffee,
              text: 'Leisure & lifestyle',
              color: Colors.orangeAccent,
            ),
            _buildBox(
              icon: Icons.event,
              text: 'Events',
              color: Colors.greenAccent,
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
          Icon(icon, size: 40.0, color: Colors.white),
          const SizedBox(height: 12.0),
          Text(
            text,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
