import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Image Gallery',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const ImageGallery(),
    );
  }
}

class ImageGallery extends StatefulWidget {
  const ImageGallery({super.key});

  @override
  State<ImageGallery> createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<ImageGallery> {
  // Current image index
  int _currentImageIndex = 0;

  final List<String> _imagePaths = [
    'assets/bird.jpg',
    'assets/bird2.jpg',
    'assets/girl.jpg',
    'assets/man.jpg',
  ];

  // Go to previous image (circular)
  void _goToPreviousImage() {
    setState(() {
      _currentImageIndex = (_currentImageIndex - 1) % _imagePaths.length;
      if (_currentImageIndex < 0) {
        _currentImageIndex = _imagePaths.length - 1;
      }
    });
  }

  // Go to next image (circular)
  void _goToNextImage() {
    setState(() {
      _currentImageIndex = (_currentImageIndex + 1) % _imagePaths.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: const Text(
          'Image viewer',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: _goToPreviousImage,
            icon: const Icon(Icons.navigate_before, color: Colors.white),
            tooltip: 'Go to the previous image',
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: _goToNextImage,
              icon: const Icon(Icons.navigate_next, color: Colors.white),
              tooltip: 'Go to the next image',
            ),
          ),
        ],
      ),
      body: Center(
        child: Image.asset(
          _imagePaths[_currentImageIndex],
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: 600,
              height: 400,
              color: Colors.grey[300],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.image_not_supported,
                      size: 100, color: Colors.grey[600]),
                  const SizedBox(height: 20),
                  Text(
                    'Image ${_currentImageIndex + 1} not found',
                    style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Please add images to assets/w4-s2/',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
