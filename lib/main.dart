import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ovision/firebase_options.dart';
import 'package:ovision/views/myapp.dart';
import 'package:ovision/views/myhomepage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ovision/views/foto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
