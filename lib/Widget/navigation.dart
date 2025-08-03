import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:point_and_learn/screen/camera_education.dart';
import 'package:point_and_learn/screen/home_education.dart';
import 'package:point_and_learn/screen/sentence_education.dart';
import 'package:point_and_learn/screen/settings.dart';
import 'package:point_and_learn/screen/login.dart';

class NavigationsScreen extends StatefulWidget {
  const NavigationsScreen({super.key});

  @override
  State<NavigationsScreen> createState() => _NavigationsScreenState();
}

class _NavigationsScreenState extends State<NavigationsScreen> {
  int _selectedIndex = 0;
  List<CameraDescription> cameras = [];
  bool camerasLoaded = false;


  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _loadCameras();
    _initializePages();
  }

  void _initializePages() {
    _pages = [
      HomeEducationPage(),
      HomeEducationPage(),
      SettingsPage(),
      SizedBox(),
    ];
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

  void _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context);

    if (index == 3) {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
      (route) => false,
    );
  } else {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context);
  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E183E),
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          _getPageTitle(),
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
            },
          ),
        ],
      ),
      drawer: _buildDrawer(),
      body: _pages[_selectedIndex],
    );
  }

  String _getPageTitle() {
    switch (_selectedIndex) {
      case 0:
        return 'Home';
      case 1:
        return 'Recent';
      case 2:
        return 'Settings';
      case 3:
        return 'Sign Out';
      default:
        return 'Point&Learn';
    }
  }

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: const Color(0xFF1E183E),
      child: Column(
        children: [

          Container(
            height: 240,
            width: double.infinity,
            color: const Color(0xFF1E183E),
            child: Column(
              children: [

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      CircleAvatar(
                        radius: 24,
                        backgroundImage: AssetImage('media/profile.png'), // Profil fotoğrafı dosyan
                        backgroundColor: Colors.grey.shade300,
                      ),

                      Text(
                        "Help",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  width: 80,
                  height: 80,
                  child: Image.asset('media/logo.png'),
                ),
                SizedBox(height: 10),
                Text(
                  "Menu",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),


          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem(
                  icon: Icons.home,
                  title: 'Home',
                  index: 0,
                ),
                _buildDrawerItem(
                  icon: Icons.recent_actors,
                  title: 'Recent',
                  index: 1,
                ),
                _buildDrawerItem(
                  icon: Icons.settings,
                  title: 'Settings',
                  index: 2,
                ),
                _buildDrawerItem(
                  icon: Icons.logout,
                  title: 'Sign Out',
                  index: 3,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required int index,
  }) {
    bool isSelected = _selectedIndex == index;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected ? Colors.white : Colors.grey.shade300,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey.shade300,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: isSelected ? Colors.white : Colors.grey.shade300,
          size: 16,
        ),
        onTap: () => _onItemTapped(index),
      ),
    );
  }
}
