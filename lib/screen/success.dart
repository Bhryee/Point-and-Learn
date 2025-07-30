import 'package:flutter/material.dart';

import 'login.dart';

class SuccessPage extends StatefulWidget {
  const SuccessPage({super.key});

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
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
                    "POINT & LEARN'E HOŞGELDİN!",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                SizedBox(height: 30),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    "Hesabın başarıyla oluşturuldu. Başlamak için giriş yapman gerekiyor.",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                SizedBox(height: 30),
                // Sign In button
                Login(),
                SizedBox(height: 30),

              ],
            ),
          ),
        ),
      ),
    );
  }



  Widget Login() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: InkWell(
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(() {}),
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
              'GİRİŞ YAP',
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
}
