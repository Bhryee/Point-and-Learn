import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E183E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Image.asset('media/logo.png', width: 100, height: 100),
            SizedBox(height: 20),
            Text(
              'Point&Learn',
              style: TextStyle(fontSize: 26, color: Colors.white, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            Text(
              '''Point&Learn is an interactive mobile application that helps users learn English language vocabulary naturally by using the device’s camera. By simply pointing at everyday objects, users instantly see the names of those objects in a target language, along with pronunciation and example sentences.

Designed for learners of all ages, Point&Learn makes language learning easy, engaging, and connected to the real world.''',
              style: TextStyle(fontSize: 16, color: Colors.white70, height: 1.5),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
