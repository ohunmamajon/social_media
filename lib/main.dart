import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_media/features/auth/presentation/pages/auth_page.dart';
import 'package:social_media/features/auth/presentation/pages/login_page.dart';
import 'package:social_media/features/auth/presentation/pages/register_page.dart';
import 'package:social_media/firebase_options.dart';
import 'package:social_media/themes/light_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
     debugShowCheckedModeBanner: false,
     theme: lightMode,
     home: const AuthPage(),
    );
  }
}

