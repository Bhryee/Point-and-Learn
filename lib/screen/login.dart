import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:point_and_learn/screen/signup.dart';
import '../Widget/navigation.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback show;
  const LoginScreen(this.show, {super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final password = TextEditingController();
  final email_F = FocusNode();
  final password_F = FocusNode();

  bool isLoading = false;

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    email_F.dispose();
    password_F.dispose();
    super.dispose();
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> handleLogin() async {
    setState(() => isLoading = true);

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      // Başarılı giriş
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const NavigationsScreen()),
      );
    } on FirebaseAuthException catch (e) {
      // Hatalı giriş
      String error = 'Giriş başarısız';
      if (e.code == 'user-not-found') {
        error = 'Kullanıcı bulunamadı';
      } else if (e.code == 'wrong-password') {
        error = 'Yanlış şifre';
      }
      showSnackBar(error);
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E183E),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 260,
                  height: 300,
                  child: Column(
                    children: [
                      Center(
                        child: SizedBox(
                          width: 200,
                          height: 200,
                          child: Image.asset('media/logo.png'),
                        ),
                      ),
                      const Text(
                        "Point&Learn",
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
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
                const SizedBox(height: 60),
                buildTextField(email, Icons.email, 'Email', email_F),
                const SizedBox(height: 20),
                buildTextField(password, Icons.lock, 'Şifre', password_F, obscureText: true),
                const SizedBox(height: 40),
                buildLoginButton(),
                const SizedBox(height: 30),
                buildSignupRedirect(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSignupRedirect() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text('Hesabın yok mu? ', style: TextStyle(color: Colors.grey.shade300)),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignupScreen(() {})),
            );
          },
          child: const Text(
            'Kayıt ol',
            style: TextStyle(
              color: Color(0xFF4A90E2),
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ]),
    );
  }

  Widget buildLoginButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: InkWell(
        onTap: isLoading ? null : handleLogin,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: isLoading ? Colors.grey : Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: isLoading
                ? const CircularProgressIndicator(color: Color(0xFF1E183E))
                : const Text(
                    'GİRİŞ YAP',
                    style: TextStyle(
                      color: Color(0xFF1E183E),
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

  Widget buildTextField(TextEditingController controller, IconData icon, String type,
      FocusNode focusNode,
      {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF16132E),
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
              contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            ),
            controller: controller,
            focusNode: focusNode,
            obscureText: obscureText,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
