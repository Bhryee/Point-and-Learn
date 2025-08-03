import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:camera/camera.dart';
import 'package:point_and_learn/screen/camera_education.dart';
import 'package:point_and_learn/screen/signup.dart';

import '../Widget/navigation.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback show;
  LoginScreen(this.show, {super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  FocusNode email_F = FocusNode();
  final password = TextEditingController();
  FocusNode password_F = FocusNode();

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    password.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E183E), // Koyu mavi/mor background
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 260,
                  height: 300,
                  child: Column(
                    children: [
                      // Logo
                      Center(
                        child: SizedBox(
                            width: 200,
                            height: 200,
                            child: Image.asset('media/logo.png')),
                      ),


                      Text(
                        "Point&Learn",
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),

                      Text(
                        "Language Learning App",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade300,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 60),


                Textfield(email, Icons.person, 'Email', email_F),
                SizedBox(height: 20),


                Textfield(password, Icons.lock, 'Şifre', password_F,
                    obscureText: true),
                SizedBox(height: 40),

                Login(),
                SizedBox(height: 30),

                DontHaveAcount()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget DontHaveAcount() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Hesabın yok mu? ',
            style: TextStyle(color: Colors.grey.shade300),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SignupScreen(() {}),
                ),
              );
            },
            child: Text(
              'Kayıt ol',
              style: TextStyle(
                color: const Color(0xFF4A90E2),
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                decorationColor: const Color(0xFF4A90E2),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget Login() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: InkWell(
        onTap: () {
          print("Login button tapped");
          print("Email: ${email.text}");
          print("Password: ${password.text}");

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const NavigationsScreen(),
            ),
          );
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              'GİRİŞ YAP',
              style: TextStyle(
                color: const Color(0xFF1E183E),
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget Textfield(TextEditingController controller, IconData icon, String type,
      FocusNode focusNode,
      {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF16132E),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 13.0),
          child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: type,
              hintStyle: TextStyle(color: Colors.grey.shade300),
              suffixIcon: Icon(
                icon,
                color: focusNode.hasFocus ? Colors.white : Colors.grey.shade300,
              ),
              contentPadding:
              EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            ),
            controller: controller,
            focusNode: focusNode,
            obscureText: obscureText,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
