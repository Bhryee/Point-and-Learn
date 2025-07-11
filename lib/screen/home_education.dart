import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:point_and_learn/screen/camera_education.dart';

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

  void _navigateToCamera(String category) async {
    if (cameras.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Camera(camera: cameras.first),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Kamera bulunamadı!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Point Object Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              color: Colors.white,
              child: Row(
                children: [
                  // Logo
                  Container(
                    width: 60,
                    height: 60,
                    child: Image.asset(
                      'media/logo.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(width: 15),
                  // Point Object Text
                  Text(
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
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              color: Colors.green.shade400,
              child: Text(
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
                  // Kitchen Tools Section
                  _buildLearningCard(
                    title: "Kitchen Tools",
                    imagePath: "assets/kitchen_tools.jpg", // Mutfak resmi
                    onTap: () {
                      _navigateToCamera("Kitchen Tools");
                    },
                  ),

                  SizedBox(height: 20),


                  _buildLearningCard(
                    title: "Home Appliances",
                    imagePath: "assets/home_appliances.jpg", // Ev aletleri resmi
                    onTap: () {
                      _navigateToCamera("Home Appliances");
                    },
                  ),

                  SizedBox(height: 20),


                  _buildLearningCard(
                    title: "Living Room",
                    imagePath: "assets/living_room.jpg",
                    onTap: () {
                      _navigateToCamera("Living Room");
                    },
                  ),

                  SizedBox(height: 20),

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
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),

            // Image
            Container(
              width: double.infinity,
              height: 200,
              margin: EdgeInsets.symmetric(horizontal: 15),
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
                    // Resim bulunamadığında placeholder göster
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
                          SizedBox(height: 10),
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

            SizedBox(height: 15),
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