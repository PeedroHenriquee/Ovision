import 'dart:io';
import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ovision/main.dart';
import 'package:ovision/views/myapp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  addImage() {
        setState(() async {
      
      
      String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

      final referenceRoot = FirebaseStorage.instance.ref();

      final referenceDirImages = referenceRoot.child('images');

      final referenceImageToUpload = referenceDirImages.child(uniqueFileName);

      try{
         await referenceImageToUpload.putFile(File(imageSelect.path));

          await referenceImageToUpload.getDownloadURL();

      }catch(error){

        //erro ocorrido
      }

   
    });
  }
  

  

  clearImage() {
    setState(() {
      imageSelect = null;

    });


  
  }

  String imageUrl = ' ';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        
        child: Column(

          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 4/5,
              child: imageSelect == null?
              Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(32.0),
                      color: Colors.grey,
                      width: double.maxFinite,
                      height: 500,
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      ),
                    )
                  : Image.file(
                      File(imageSelect.path),
                      fit: BoxFit.cover,
                    ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))
                    ),
                      
                  onPressed: pickImageCamera,
                  child: const Icon(
                    Icons.camera_alt,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))
                    ),

                  onPressed: pickImageGaleria,
                  child: const Icon(
                    Icons.photo_library,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ],
            ),
            if(imageSelect != null)
              ElevatedButton(
                onPressed: addImage,
                child: const Text("Salvar"),
                  
              
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

