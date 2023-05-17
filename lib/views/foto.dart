import 'dart:io';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class Fotos extends StatefulWidget {
  const Fotos({Key? key}) : super(key: key);


  @override
  State<Fotos> createState() => _FotosState();
}

class _FotosState extends State<Fotos> with SingleTickerProviderStateMixin {
  String imageUrl = ' ';

  File? imageSelect;

  final ImagePicker _imagePicker = ImagePicker();

  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('gallery'); // firestore db

  pickImageCamera() async {
    final XFile? image =
        await _imagePicker.pickImage(source: ImageSource.camera);

    print('IMAGEM CAMERA: ${image?.path}');

    if (image != null) {
      setState(() {
        imageSelect = File(image.path);
      });
    }

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
      await referenceImageToUpload.putFile(File(image!.path));
      //Succes: get the download URL
      imageUrl = await referenceImageToUpload.getDownloadURL();
    } catch (error) {
      //Some error occurred
    }
  }

  pickImageGaleria() async {
    final XFile? image =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    print('IMAGE: ${image?.path}');

    if (image != null) {
      setState(() {
        imageSelect = File(image.path);
      });
    }
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
      await referenceImageToUpload.putFile(File(image!.path));
      //Succes: get the download URL
      imageUrl = await referenceImageToUpload.getDownloadURL();
    } catch (error) {
      //Some error occurred
    }
  }


  uploadImage() {
    setState(() async {
// Create the file metadata

// Create a reference to the Firebase Storage bucket
      final storageRef = FirebaseStorage.instance.ref();

// Upload file and metadata to the path 'images/mountains.jpg'
      final uploadTask = storageRef.child("images").putFile(imageSelect!);

// Listen for state changes, errors, and completion of the upload.
      uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
        switch (taskSnapshot.state) {
          case TaskState.running:
            final progress = 100.0 *
                (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
            print("Upload is $progress% complete.");
            break;
          case TaskState.paused:
            print("Upload is paused.");
            break;
          case TaskState.canceled:
            print("Upload was canceled");
            break;
          case TaskState.error:
            print("An error ocurred!");
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('An error ocurred!'),
                backgroundColor: Colors.redAccent,)
            );
            break;
          case TaskState.success:
            print("Upload was successful!");
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Upload was successful'),
                backgroundColor: Colors.lightGreen,
              ),
            );
            break;
        }
      });

      if (imageUrl.isEmpty) {
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
      _reference.add(dataToSend); // to firestore

      print('URL DA IMAGEM: ${imageUrl}');

      
    });
  }

  clearImage() {
    setState(() {
      imageSelect = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AspectRatio(
                //9/16
                aspectRatio: 9 / 16,
                child: imageSelect == null
                    ? Container(
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
                        File(imageSelect!.path),
                        fit: BoxFit.contain,
                      ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (imageSelect == null)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    onPressed: pickImageCamera,
                    child: const Icon(
                      Icons.camera_alt,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  if (imageSelect == null)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    onPressed: pickImageGaleria,
                    child: const Icon(
                      Icons.photo_library,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (imageSelect != null)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 35, vertical: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                      onPressed: uploadImage,
                      child: const Text(
                        "Salvar",
                        // style: TextStyle(
                        //   fontWeight: FontWeight.w700,
                        // ),
                      ),
                    ),
                  if (imageSelect != null)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                      onPressed: (){
                        clearImage();
                      }, //clearImage,
                      child: const Text(
                        "Eliminar",
                        // style: TextStyle(
                        //   fontWeight: FontWeight.w700,
                        // ),
                      ),
                    ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
