import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:point_and_learn/Widget/navigation.dart';
import 'package:point_and_learn/screen/camera.dart';
import 'package:point_and_learn/screen/login.dart';

class SignupScreen extends StatefulWidget {
  final VoidCallback show;

  SignupScreen(this.show, {super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final email = TextEditingController();
  FocusNode email_F = FocusNode();
  final password = TextEditingController();
  FocusNode password_F = FocusNode();
  final username = TextEditingController();
  FocusNode username_F = FocusNode();
  final passwordConfirme = TextEditingController();
  FocusNode passwordConfirme_F = FocusNode();
  final bio = TextEditingController();
  FocusNode bio_F = FocusNode();

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    password.dispose();
    passwordConfirme.dispose();
    username.dispose();
    bio.dispose();
  }

  @override
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
                  width: 200,
                  height: 150,
                  child: Image.asset(
                    'images/sign-up.png',
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 20),

                // Başlık
                Text(
                  "Yeni hesap oluşturun",
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
                SizedBox(height: 20),

                // Profile Picture
                InkWell(
                  onTap: () {
                    // Resim seçme özelliği kaldırıldı
                    print("Profile picture tapped");
                  },
                  child: CircleAvatar(
                    radius: 36,
                    backgroundColor: Colors.grey,
                    child: CircleAvatar(
                      radius: 34,
                      backgroundImage: AssetImage('images/person.png'),
                      backgroundColor: Colors.grey.shade200,
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Username field
                Textfield(username, Icons.person, 'Kullanıcı adı', username_F),
                SizedBox(height: 10),

                // Email field
                Textfield(email, Icons.email, 'Email', email_F),
                SizedBox(height: 10),

                // Password field
                Textfield(password, Icons.lock, 'Şifre', password_F,
                    obscureText: true),
                SizedBox(height: 10),

                // Password confirm field
                Textfield(passwordConfirme, Icons.lock, 'Şifre Tekrar',
                    passwordConfirme_F,
                    obscureText: true),
                SizedBox(height: 10),

                // Bio field
                Textfield(bio, Icons.abc, 'Bio', bio_F),
                SizedBox(height: 20),

                // Signup button
                Signup(),
                SizedBox(height: 20),

                // Already have account
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
          Text('Zaten hesabın var mı? '),
          GestureDetector(
            onTap: () {
              // Login ekranına git
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(() {}), // Boş callback
                ),
              );
            },
            child: Text(
              'Giriş yap',
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

  Widget Signup() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: InkWell(
        onTap: () {
          // Kayıt bilgilerini yazdır
          print("Signup button tapped");
          print("Username: ${username.text}");
          print("Email: ${email.text}");
          print("Password: ${password.text}");
          print("Password Confirm: ${passwordConfirme.text}");
          print("Bio: ${bio.text}");

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
              'Kayıt Ol',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
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