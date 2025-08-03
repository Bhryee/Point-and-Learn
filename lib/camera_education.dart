import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:point_and_learn/screen/sentence_education.dart';

class Camera extends StatefulWidget {
  final CameraDescription? camera;

  const Camera({this.camera, super.key});

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  CameraController? _controller;
  bool _isInitialized = false;
  String _detectedObject = "";
  String? _initializationError;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    // Simülasyon için 3 saniye sonra nesne tespit et
    _simulateObjectDetection();
  }

  Future<void> _initializeCamera() async {
    if (widget.camera != null) {
      try {
        _controller = CameraController(widget.camera!, ResolutionPreset.medium);
        await _controller!.initialize();

        if (mounted) {
          setState(() {
            _isInitialized = true;
          });
        }
      } catch (e) {
        print('Camera initialization error: $e');
        if (mounted) {
          setState(() {
            _initializationError = e.toString();
          });
        }
      }
    }
  }

  @override
  void dispose() {
    // Kamera controller'ını güvenli şekilde kapat
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Hata durumu
    if (_initializationError != null) {
      return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          backgroundColor: const Color(0xFF1E183E),
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            'Kamera Hatası',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red,
              ),
              SizedBox(height: 20),
              Text(
                'Kamera başlatılamadı',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'Lütfen kamera izinlerini kontrol edin',
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Geri Dön'),
              ),
            ],
          ),
        ),
      );
    }

    // Kamera yoksa veya henüz initialize edilmemişse yükleme ekranı göster
    if (widget.camera == null || !_isInitialized || _controller == null) {
      return Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: SafeArea(
          child: Column(
            children: [
              // Üst kısım - Point Object başlığı
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
                        'Nesneyi Göster',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.camera_alt, color: Colors.white),
                      onPressed: () {}, // Boş fonksiyon
                    ),
                  ],
                ),
              ),
              // Loading indicator
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: Color(0xFF1E183E),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Kamera başlatılıyor...',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
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

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Column(
          children: [
            // Üst kısım - Point Object başlığı
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              color: Color(0xFF1E183E),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () async {
                      // Kamerayı güvenli şekilde kapat
                      await _controller?.dispose();
                      if (mounted) {
                        Navigator.pop(context);
                      }
                    },
                  ),
                  Expanded(
                    child: Text(
                      'Nesneyi Göster',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.camera_alt, color: Colors.white),
                    onPressed: () {}, // Boş fonksiyon
                  ),
                ],
              ),
            ),

            // Ana kamera alanı
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: Stack(
                  children: [
                    // Kamera önizlemesi - tam ekran
                    if (_controller != null && _controller!.value.isInitialized)
                      Positioned.fill(
                        child: CameraPreview(_controller!),
                      ),
                  ],
                ),
              ),
            ),

            // Alt bilgi alanı
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  // Yönlendirme metni
                  Text(
                    "Adını öğrenmek istediğiniz nesneye\nkamerayı tutunuz.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade700,
                      height: 1.4,
                    ),
                  ),

                  SizedBox(height: 20),

                  // Tespit edilen nesne butonu
                  if (_detectedObject.isNotEmpty)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Nesne detaylarına git veya ses çal
                          print('Detected object: $_detectedObject');
                          // EducationPage'e git
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EducationPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1E183E),
                          padding: EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _detectedObject,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 10),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),

                  // Henüz tespit edilmemişse placeholder - TIKLANABİLİR
                  if (_detectedObject.isEmpty)
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EducationPage(),
                          ),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.grey.shade600,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Taranıyor...",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Nesne tespiti simülasyonu
  void _simulateObjectDetection() {
    Future.delayed(Duration(seconds: 3), () {
      if (mounted) {
        List<String> sampleObjects = [
          "Box", "Cup", "Phone", "Book", "Pen", "Table", "Chair", "Bottle"
        ];
        setState(() {
          _detectedObject = sampleObjects[DateTime.now().millisecond % sampleObjects.length];
        });
      }
    });
  }

  // Fotoğraf çekme fonksiyonu
  Future<void> _takePicture() async {
    try {
      if (_controller == null || !_controller!.value.isInitialized) {
        return;
      }

      final XFile image = await _controller!.takePicture();
      print('Fotoğraf çekildi: ${image.path}');

    } catch (e) {
      print('Fotoğraf çekilirken hata: $e');
    }
  }
}