import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:camera/camera.dart';
import 'package:point_and_learn/screen/camera.dart';
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top, // SafeArea yüksekliğini çıkar
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo veya resim için alan
                SizedBox(
                  width: 260,
                  height: 260,
                  child: Image.asset(
                    'images/log-in.png',
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 30),

                // Başlık
                Text(
                  "Hesabınıza giriş yapın",
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
                SizedBox(height: 30),

                // Email field
                Textfield(email, Icons.email, 'Email', email_F),
                SizedBox(height: 15),

                // Password field
                Textfield(password, Icons.lock, 'Şifre', password_F,
                    obscureText: true),
                SizedBox(height: 20),

                // Forgot password
                ForgotPassword(),
                SizedBox(height: 30),

                // Login button
                Login(),
                SizedBox(height: 20),

                // Don't have account
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
          Text('Hesabın yok mu? '),
          GestureDetector(
            onTap: () {
              // Signup ekranına git
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SignupScreen(() {}), // Boş callback
                ),
              );
            },
            child: Text(
              'Kayıt ol',
              style: TextStyle(
                  color: const Color(0xFF215969),
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  decorationColor: const Color(0xFF215969)),
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
          // Giriş bilgilerini yazdır
          print("Login button tapped");
          print("Email: ${email.text}");
          print("Password: ${password.text}");

          // NavigationsScreen'e git (Profile sayfası açılacak)
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
            color: const Color(0xFF215969),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(
              'Giriş Yap',
              style: TextStyle(
                  color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  Widget ForgotPassword() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Row(
        children: [
          Spacer(),
          Text(
            'Şifremi unuttum',
            style: TextStyle(fontSize: 15, color: const Color(0xFF215969)),
          ),
        ],
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
          color: Colors.grey.shade200,
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 13.0),
          child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: type,
              prefixIcon: Icon(
                icon,
                color: focusNode.hasFocus ? Colors.black : Colors.grey,
              ),
              contentPadding:
              EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            ),
            controller: controller,
            focusNode: focusNode,
            obscureText: obscureText,
          ),
        ),
      ),
    );
  }
}