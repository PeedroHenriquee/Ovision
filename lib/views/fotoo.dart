import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';




class Fotos extends StatefulWidget {
  

  @override
  State<Fotos> createState() => _Fotostate();
}

class _Fotostate extends State<Fotos> {
  File imageSelect;

  final ImagePicker _imagePicker = ImagePicker();

  pickImageCamera() async {
    final XFile image =
        await _imagePicker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        imageSelect = File(image.path);
      });
    }
  }

  pickImageGaleria() async {
    final XFile image =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        imageSelect = File(image.path);
      });
    }
  }

  clearImage() {
    setState(() {
      imageSelect = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
        title: Text('Captura de Imagem'),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1.5,
              child: imageSelect == null
                  ? Container(
                      color: Colors.grey,
                      width: double.maxFinite,
                      height: double.maxFinite,
                      child: const Icon(Icons.camera_alt, ),
                    )
                  : Image.file(
                      File(imageSelect.path),
                      fit: BoxFit.cover,
                      
                    ),
            ),
            SizedBox(height: 40,),
            
            Row(
              mainAxisAlignment : MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                ElevatedButton(
                  style: ButtonStyle(
    backgroundColor: MaterialStatePropertyAll<Color>(Colors.green),
  ),
                  onPressed: pickImageCamera,
                  child: const Icon(Icons.camera_alt, color: Color.fromARGB(255, 19, 17, 17),),
                
                  
                ),
                ElevatedButton(
                  style: ButtonStyle(
    backgroundColor: MaterialStatePropertyAll<Color>(Colors.green),
  ),
                  onPressed: pickImageGaleria,
                  child: const Icon(Icons.photo_library, color: Color.fromARGB(255, 19, 17, 17),),
                ),
              ],
            ),
            if (imageSelect != null)
              ElevatedButton(
                onPressed: clearImage,
                child: const Text("Eliminar"),
              ),
          ],
        ),
      ),
    );
  }
}
