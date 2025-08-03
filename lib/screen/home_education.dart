import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:point_and_learn/screen/camera_education.dart';
import 'package:point_and_learn/screen/welcome.dart';

class HomeEducationPage extends StatefulWidget {
  const HomeEducationPage({super.key});

  @override
  State<HomeEducationPage> createState() => _HomeEducationPageState();
}

class _HomeEducationPageState extends State<HomeEducationPage> {
  List<CameraDescription> cameras = [];
  bool camerasLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadCameras();
  }

  Future<void> _loadCameras() async {
    try {
      cameras = await availableCameras();
      setState(() {
        camerasLoaded = true;
      });
    } catch (e) {
      print('Kamera yükleme hatası: $e');
      setState(() {
        camerasLoaded = true;
      });
    }
  }

  void _navigateToCamera(String category) {
    if (cameras.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Camera(camera: cameras.first),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kamera bulunamadı!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    if (context.mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const WelcomePage()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Point&Learn',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.black),
            tooltip: 'Çıkış Yap',
            onPressed: _signOut,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Başlık
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              child: Row(
                children: [
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: Image.asset(
                      'media/logo.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 15),
                  const Text(
                    "Point Object",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              color: Colors.green.shade400,
              child: const Text(
                "Point&Learn History",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _buildLearningCard(
                    title: "Kitchen Tools",
                    imagePath: "assets/kitchen_tools.jpg",
                    onTap: () {
                      _navigateToCamera("Kitchen Tools");
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildLearningCard(
                    title: "Home Appliances",
                    imagePath: "assets/home_appliances.jpg",
                    onTap: () {
                      _navigateToCamera("Home Appliances");
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildLearningCard(
                    title: "Living Room",
                    imagePath: "assets/living_room.jpg",
                    onTap: () {
                      _navigateToCamera("Living Room");
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildLearningCard(
                    title: "Bedroom Items",
                    imagePath: "assets/bedroom.jpg",
                    onTap: () {
                      _navigateToCamera("Bedroom Items");
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLearningCard({
    required String title,
    required String imagePath,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 200,
              margin: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey.shade200,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey.shade200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _getCategoryIcon(title),
                            size: 60,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            title,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'kitchen tools':
        return Icons.kitchen;
      case 'home appliances':
        return Icons.home;
      case 'living room':
        return Icons.weekend;
      case 'bedroom items':
        return Icons.bed;
      default:
        return Icons.category;
    }
  }
}
