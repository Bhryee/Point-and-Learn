import 'package:flutter/material.dart';
import 'package:point_and_learn/screen/signup.dart';

import 'login.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E183E), // Koyu mavi/mor background
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
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
                SizedBox(height: 30),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    "Etrafına Baktığında Yeni Kelimeler Öğren!",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                SizedBox(height: 30),
                // Sign In button
                Signup(),
                SizedBox(height: 30),

                // Don't have account
                DontHaveAcount()
              ],
            ),
          ),
        ),
      ),
    );
  }



  Widget Signup() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: InkWell(
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => SignupScreen(() {}),
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

  Widget DontHaveAcount() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Zaten hesabın var mı? ', style: TextStyle(color: Colors.grey.shade300),),

          GestureDetector(
            onTap: () {
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
}