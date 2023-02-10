import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ovision/firebase_options.dart';
import 'package:ovision/myapp.dart';
import 'package:ovision/controllers/login.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ovision/controllers/cadastro.dart';
import 'package:ovision/views/foto.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( MyApp());
}
