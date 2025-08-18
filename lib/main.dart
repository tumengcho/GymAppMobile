import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:gymapp/NavigationWrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gymapp/service/service_database.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

late final FirebaseFirestore db;
late final CloudinaryPublic cloudinaryPublic;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  db = FirebaseFirestore.instance;
  cloudinaryPublic = CloudinaryPublic("dc102wzxc", "gym_app_upload");
  // Database.seedDatabase();
  runApp(const GymApp());
}

class GymApp extends StatelessWidget {
  const GymApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gym App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        primaryColor: Color(0xFFD3FF55),
        scaffoldBackgroundColor: Color(0xFF323230),
        textTheme: const TextTheme(
          bodySmall: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          bodyLarge: TextStyle(color: Colors.white),
        ),
        useMaterial3: true,
      ),
      home: NavigationWrapper(),
    );
  }
}
