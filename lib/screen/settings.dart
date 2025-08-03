import 'package:flutter/material.dart';
import 'profile_settings.dart';
import 'app_settings.dart';
import 'about_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo
            SizedBox(height: 10),
            Image.asset('media/logo.png', width: 100, height: 100),

            SizedBox(height: 30),

            Text(
              'Settings',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            SizedBox(height: 40),

            _buildSettingsItem(
              icon: Icons.person,
              title: 'Profile Settings',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileSettingsPage()),
              ),
            ),
            SizedBox(height: 20),
            _buildSettingsItem(
              icon: Icons.settings,
              title: 'App Settings',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AppSettingsPage()),
              ),
            ),
            SizedBox(height: 20),
            _buildSettingsItem(
              icon: Icons.info_outline,
              title: 'About',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutPage()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white12),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
          ],
        ),
      ),
    );
  }
}
