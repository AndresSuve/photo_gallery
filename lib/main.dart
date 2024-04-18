import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Импортируем Firebase Core

import 'screens/photo_gallery_screen.dart'; // Импортируем ваш экран галереи фотографий

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Обеспечиваем инициализацию виджетов Flutter
  await Firebase.initializeApp(); // Инициализируем Firebase

  runApp(MyApp()); // Запускаем ваше приложение
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photo Gallery App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PhotoGalleryScreen(), // Устанавливаем ваш экран галереи фотографий как главный
    );
  }
}
