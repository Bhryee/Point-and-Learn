import 'package:flutter/material.dart';
import 'package:point_and_learn/screen/success.dart';
import 'package:point_and_learn/screen/login.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupScreen extends StatefulWidget {
  final VoidCallback show;

  const SignupScreen(this.show, {super.key});

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
      backgroundColor: Color(0xFF1E183E),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top, // SafeArea yüksekliğini çıkar
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                SizedBox(
                  width: 150,
                  height: 100,
                  child: Image.asset(
                    'media/logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 20),


                Text(
                  "Profil fotoğrafı seçiniz",
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
                SizedBox(height: 20),


                InkWell(
                  onTap: () {
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
                SizedBox(height: 30),

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
          Text('Zaten hesabın var mı? ', style: TextStyle(color: Colors.grey.shade300),),

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
                  color: const Color(0xFF4A90E2),
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  decorationColor: const Color(0xFF4A90E2)),
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
          print("Signup button tapped");
          print("Username: ${username.text}");
          print("Email: ${email.text}");
          print("Password: ${password.text}");
          print("Password Confirm: ${passwordConfirme.text}");
          print("Bio: ${bio.text}");
              String mail = email.text.trim();
    String pass = password.text.trim();

    
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const SuccessPage(),
            ),
          );
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(
              'HESAP OLUŞTUR',
              style: TextStyle(
                  color: const Color(0xFF1E183E),
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
          color: Color(0xFF16132E),

          borderRadius: BorderRadius.circular(15),
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
              style: TextStyle(color: Colors.white)
          ),
        ),
      ),
    );
  }
}