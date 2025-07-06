// Flutter'ın temel widget'larını kullanmak için gerekli
import 'package:flutter/material.dart';

// State management (durum yönetimi) için Provider paketini import eder
// import 'package:provider/provider.dart'; // Şimdilik kullanılmıyor

// Ekran boyutlarına göre responsive tasarım için
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Login sayfasını import eder
import 'package:point_and_learn/screen/login.dart';

// Signup sayfasını import eder
import 'package:point_and_learn/screen/signup.dart';

// Kendi provider'larınızı buraya import edin
// import 'package:sketch_app/providers/language.dart';
// import 'package:sketch_app/providers/theme.dart';

// Uygulamanın başlangıç fonksiyonu
void main() {
  // Uygulamayı çalıştırır
  runApp(MyApp());
}

// Ana uygulama widget'ı
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Responsive tasarım için ekran boyutlarını ayarlar
    return ScreenUtilInit(
      designSize: const Size(375, 812), // Tasarım için referans ekran boyutu (iPhone X)
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false, // Debug banner'ını gizler
          home: LoginScreen(() {}), // Direkt LoginScreen'i başlat (show parametresi boş)
        );
      },
    );
  }
}