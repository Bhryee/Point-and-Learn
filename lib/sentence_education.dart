import 'package:flutter/material.dart';

class EducationPage extends StatefulWidget {
  const EducationPage({super.key});

  @override
  State<EducationPage> createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              color: Color(0xFF1E183E),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: Text(
                      'Örnek Cümleler',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.document_scanner_rounded, color: Colors.white),
                    onPressed: () {}, // Boş fonksiyon
                  ),
                ],
              ),
            ),


            Expanded(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        color: Color(0xFF1E183E),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Box',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    SizedBox(height: 30),

                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [

                            _buildSentenceCard(
                              englishText: "This is a box.",
                              turkishText: "(Bu bir kutu.)",
                            ),

                            SizedBox(height: 20),

                            _buildSentenceCard(
                              englishText: "I put all my books in the box.",
                              turkishText: "(Tüm kitaplarımı kutuya koydum.)",
                            ),

                            SizedBox(height: 20),

                            _buildSentenceCard(
                              englishText: "The box is very heavy.",
                              turkishText: "(Kutu çok ağır.)",
                            ),

                            SizedBox(height: 20),

                            _buildSentenceCard(
                              englishText: "Can you help me carry this box?",
                              turkishText: "(Bu kutuyu taşımama yardım edebilir misin?)",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSentenceCard({
    required String englishText,
    required String turkishText,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            englishText,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
              height: 1.4,
            ),
          ),

          SizedBox(height: 8),

          Text(
            turkishText,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
              fontStyle: FontStyle.italic,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}