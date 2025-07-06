import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class Camera extends StatefulWidget {
  final CameraDescription? camera;

  const Camera({this.camera, super.key});

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  late CameraController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    if (widget.camera != null) {
      _controller = CameraController(widget.camera!, ResolutionPreset.medium);
      _controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {
          _isInitialized = true;
        });
      });
    }
  }

  @override
  void dispose() {
    if (_isInitialized) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Kamera yoksa veya henüz initialize edilmemişse yükleme ekranı göster
    if (widget.camera == null || !_isInitialized) {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(Icons.close_outlined),
            iconSize: 50,
            color: Colors.pink,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: const Center(
          child: CircularProgressIndicator(
            color: Colors.pink,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.close_outlined),
          iconSize: 50,
          color: Colors.pink,
          onPressed: () {
            Navigator.pop(context);
            // Eğer özel sayfa varsa:
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => const MyAppHomePage()));
          },
        ),
      ),
      body: Column(
        children: [
          // Kamera önizlemesi
          Expanded(
            child: CameraPreview(_controller),
          ),

          // Alt buton kısmı
          Container(
            height: 100,
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Fotoğraf çekme butonu
                IconButton(
                  icon: const Icon(Icons.camera),
                  iconSize: 70,
                  color: Colors.pink,
                  onPressed: () {
                    _takePicture();
                  },
                ),

                // Ek butonlar ekleyebilirsiniz
                IconButton(
                  icon: const Icon(Icons.flip_camera_ios),
                  iconSize: 40,
                  color: Colors.white,
                  onPressed: () {
                    _switchCamera();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Fotoğraf çekme fonksiyonu
  Future<void> _takePicture() async {
    try {
      if (!_controller.value.isInitialized) {
        return;
      }

      final XFile image = await _controller.takePicture();

      print('Fotoğraf çekildi: ${image.path}');

      // Başarılı mesajı göster
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Fotoğraf başarıyla çekildi!'),
          backgroundColor: Colors.green,
        ),
      );

      // Eğer başka sayfaya yönlendirmek istiyorsanız:
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => const EducationPage()));

    } catch (e) {
      print('Fotoğraf çekilirken hata: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Fotoğraf çekilirken hata oluştu!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Kamera değiştirme fonksiyonu
  Future<void> _switchCamera() async {
    try {
      // Mevcut kameraları al
      final cameras = await availableCameras();

      if (cameras.length > 1) {
        // Şu anki kameranın indeksini bul
        final currentIndex = cameras.indexOf(widget.camera!);
        final nextIndex = (currentIndex + 1) % cameras.length;

        // Yeni kamera ile controller'ı yeniden initialize et
        await _controller.dispose();
        _controller = CameraController(cameras[nextIndex], ResolutionPreset.medium);

        await _controller.initialize();

        if (mounted) {
          setState(() {});
        }
      }
    } catch (e) {
      print('Kamera değiştirirken hata: $e');
    }
  }
}
