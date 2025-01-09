import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_media/app.dart';
import 'package:social_media/features/auth/presentation/pages/auth_page.dart';
import 'package:social_media/features/auth/presentation/pages/login_page.dart';
import 'package:social_media/features/auth/presentation/pages/register_page.dart';
import 'package:social_media/config/firebase_options.dart';
import 'package:social_media/themes/light_mode.dart';

void main() async {
  // firebase initialize
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // run app
  runApp( MyApp());
}


