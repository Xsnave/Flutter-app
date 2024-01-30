// ignore_for_file: unused_local_variable
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:multi_store_web/views/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: kIsWeb || Platform.isAndroid
          ? FirebaseOptions(
              apiKey: "AIzaSyDPo1RJ6W57kBwJVXCC_XszBpKdFQYK8sg",
              projectId: "multi-store-app-5bb9b",
              storageBucket: "multi-store-app-5bb9b.appspot.com",
              messagingSenderId: "221643917679",
              appId: "1:221643917679:web:fe49e393cdf6c7a51f009a")
          : null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red.shade900),
        useMaterial3: false,
      ),
      home: const MainScreen(),
        builder: EasyLoading.init(),
    );
  }
}
