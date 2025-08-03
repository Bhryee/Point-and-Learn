import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:point_and_learn/screen/success.dart';
import 'package:point_and_learn/screen/login.dart';

class SignupScreen extends StatefulWidget {
  final VoidCallback show;
  const SignupScreen(this.show, {super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final email = TextEditingController();
  final password = TextEditingController();
  final passwordConfirme = TextEditingController();
  final username = TextEditingController();
  final bio = TextEditingController();

  final FocusNode email_F = FocusNode();
  final FocusNode password_F = FocusNode();
  final FocusNode passwordConfirme_F = FocusNode();
  final FocusNode username_F = FocusNode();
  final FocusNode bio_F = FocusNode();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    passwordConfirme.dispose();
    username.dispose();
    bio.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E183E),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                SizedBox(
                  width: 150,
                  height: 100,
                  child: Image.asset('media/logo.png'),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Profil fotoğrafı seçiniz",
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
                const SizedBox(height: 20),
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
                const SizedBox(height: 20),
                Textfield(username, Icons.person, 'Kullanıcı adı', username_F),
                const SizedBox(height: 10),
                Textfield(email, Icons.email, 'Email', email_F),
                const SizedBox(height: 10),
                Textfield(password, Icons.lock, 'Şifre', password_F,
                    obscureText: true),
                const SizedBox(height: 10),
                Textfield(passwordConfirme, Icons.lock, 'Şifre Tekrar',
                    passwordConfirme_F,
                    obscureText: true),
                const SizedBox(height: 30),
                SignupButton(),
                const SizedBox(height: 20),
                AlreadyHaveAccount(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget AlreadyHaveAccount() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text('Zaten hesabın var mı? ',
            style: TextStyle(color: Colors.grey.shade300)),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen(() {})),
            );
          },
          child: Text(
            'Giriş yap',
            style: TextStyle(
              color: Color(0xFF4A90E2),
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              decorationColor: Color(0xFF4A90E2),
            ),
          ),
        )
      ]),
    );
  }

  Widget SignupButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: InkWell(
        onTap: () async {
          final userEmail = email.text.trim();
          final userPassword = password.text.trim();
          final userPasswordConfirm = passwordConfirme.text.trim();

          if (userEmail.isEmpty ||
              userPassword.isEmpty ||
              userPasswordConfirm.isEmpty) {
            showSnackbar("Lütfen tüm alanları doldurun.");
            return;
          }

          if (userPassword != userPasswordConfirm) {
            showSnackbar("Şifreler eşleşmiyor.");
            return;
          }

          try {
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: userEmail,
              password: userPassword,
            );

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const SuccessPage()),
            );
          } on FirebaseAuthException catch (e) {
            String errorMessage = 'Bir hata oluştu';
            if (e.code == 'email-already-in-use') {
              errorMessage = 'Bu e-posta adresi zaten kullanılıyor.';
            } else if (e.code == 'weak-password') {
              errorMessage = 'Şifre çok zayıf.';
            } else if (e.code == 'invalid-email') {
              errorMessage = 'Geçersiz e-posta adresi.';
            }
            showSnackbar(errorMessage);
          }
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Center(
            child: Text(
              'HESAP OLUŞTUR',
              style: TextStyle(
                  color: Color(0xFF1E183E),
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  Widget Textfield(TextEditingController controller, IconData icon, String hint,
      FocusNode focusNode,
      {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF16132E),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 13.0),
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            obscureText: obscureText,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey.shade300),
              suffixIcon: Icon(icon,
                  color:
                      focusNode.hasFocus ? Colors.white : Colors.grey.shade300),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            ),
          ),
        ),
      ),
    );
  }

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.redAccent,
    ));
  }
}
