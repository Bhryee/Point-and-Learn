import 'package:flutter/material.dart';

class AppSettingsPage extends StatefulWidget {
  const AppSettingsPage({super.key});

  @override
  State<AppSettingsPage> createState() => _AppSettingsPageState();
}

class _AppSettingsPageState extends State<AppSettingsPage> {
  String _selectedLanguage = 'English';
  String _effectSound = 'On';

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
            Image.asset('media/logo.png', width: 100, height: 100),
            SizedBox(height: 20),
            Text(
              'App Settings',
              style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),

            _buildSectionTitle('Language'),
            _buildRadioOption('Türkçe', _selectedLanguage, (val) {
              setState(() {
                _selectedLanguage = val!;
              });
            }),
            _buildRadioOption('English', _selectedLanguage, (val) {
              setState(() {
                _selectedLanguage = val!;
              });
            }),

            SizedBox(height: 30),

            _buildSectionTitle('Effect Sounds'),
            _buildRadioOption('On', _effectSound, (val) {
              setState(() {
                _effectSound = val!;
              });
            }),
            _buildRadioOption('Off', _effectSound, (val) {
              setState(() {
                _effectSound = val!;
              });
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildRadioOption(String title, String groupValue, ValueChanged<String?> onChanged) {
    return RadioListTile<String>(
      value: title,
      groupValue: groupValue,
      onChanged: onChanged,
      title: Text(title, style: TextStyle(color: Colors.white)),
      activeColor: Colors.white,
      contentPadding: EdgeInsets.zero,
    );
  }
}
