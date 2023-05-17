import 'package:flutter/material.dart';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';


class Library extends StatefulWidget {
  const Library({Key? key}) : super(key: key);

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {

  GlobalKey<FormState> key = GlobalKey();

  final CollectionReference _reference = FirebaseFirestore.instance.collection('gallery');

  String imageUrl = '';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Library'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            const SizedBox(height: 15),

            ElevatedButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(0, 50)),
                textStyle: MaterialStateProperty.all(const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                )),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
              ),
              onPressed: () async{
                // Pick image
                ImagePicker imagePicker = ImagePicker();
                XFile? file = await imagePicker.pickImage(source: ImageSource.camera);
                print('${file?.name}');

                if (file==null) return;

                //Import dart:cores
                String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

                //Upload to Firebase Storage

                //Get a reference to storage root
                Reference referenceRoot = FirebaseStorage.instance.ref();
                Reference referenceDirImages = referenceRoot.child('images');
                //Create a referernce for the image to be stored
                Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);
                //Handle errors/success
                try {
                  //Store the file
                  await referenceImageToUpload.putFile(File(file.path));
                  //Succes: get the download URL
                  imageUrl = await referenceImageToUpload.getDownloadURL();
                } catch(error){
                  //Some error occurred
                }
                
              }, 
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.camera_alt),
                  SizedBox(height: 10),
                  Text('  Get image from camera')
                ],
              )),

            const SizedBox(height: 15),

            ElevatedButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(500, 50)),
                textStyle: MaterialStateProperty.all(const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                )),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
              ),
              onPressed: (){
                if(imageUrl.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Please upload an image'),
                    backgroundColor: Colors.redAccent,
                    ));
                  
                }

                  //Create a Map of data
                  Map<String, String> dataToSend = {
                    'image': imageUrl,
                  };

                  //Add a new item
                  _reference.add(dataToSend);

                print('URL DA IMAGEM: ${imageUrl}');
              }, 
              child: const Text('Submit')
              ),
          ],
        ),
      ),
    );
  }
}
