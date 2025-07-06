import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:point_and_learn/screen/camera.dart';
import 'package:point_and_learn/screen/profile.dart';
import 'package:point_and_learn/screen/education_result.dart';

class NavigationsScreen extends StatefulWidget {
  const NavigationsScreen({super.key});

  @override
  State<NavigationsScreen> createState() => _NavigationsScreenState();
}

class _NavigationsScreenState extends State<NavigationsScreen> {
  late PageController pageController;
  int _currentIndex = 0;
  List<CameraDescription> cameras = [];
  bool camerasLoaded = false;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    _loadCameras();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
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

  onPageChanged(int page) {
    setState(() {
      _currentIndex = page;
    });
  }

  navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      bottomNavigationBar: Container(
        child: BottomNavigationBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xFF215969),
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          currentIndex: _currentIndex,
          onTap: navigationTapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.camera_alt),
              label: 'Camera',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'Education',
            ),
          ],
        ),
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: [
          ProfileScreen(),
          camerasLoaded
              ? (cameras.isNotEmpty
              ? Camera(camera: cameras.first)
              : _buildNoCameraScreen())
              : _buildLoadingScreen(),
          EducationResultScreen(),
        ],
      ),
    );
  }

  Widget _buildLoadingScreen() {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: const Color(0xFF215969),
            ),
            SizedBox(height: 20),
            Text(
              'Kamera yükleniyor...',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoCameraScreen() {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.camera_alt_outlined,
              size: 100,
              color: Colors.grey,
            ),
            SizedBox(height: 20),
            Text(
              'Kamera bulunamadı',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Lütfen kamera izinlerini kontrol edin',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}