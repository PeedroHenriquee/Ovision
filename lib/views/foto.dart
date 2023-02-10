import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

import 'package:ovision/main.dart';
import 'package:ovision/myapp.dart';

class Fotos extends StatefulWidget {
  @override
  State<Fotos> createState() => _Fotostate();
}

class _Fotostate extends State<Fotos> with SingleTickerProviderStateMixin {
  String imageUrl = ' ';

  File imageSelect;

  final ImagePicker _imagePicker = ImagePicker();

  CollectionReference _reference =
      FirebaseFirestore.instance.collection('gallery');

  pickImageCamera() async {
    final XFile image =
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
      await referenceImageToUpload.putFile(File(image.path));
      //Succes: get the download URL
      imageUrl = await referenceImageToUpload.getDownloadURL();
    } catch (error) {
      //Some error occurred
    }
  }

  pickImageGaleria() async {
    final XFile image =
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
      await referenceImageToUpload.putFile(File(image.path));
      //Succes: get the download URL
      imageUrl = await referenceImageToUpload.getDownloadURL();
    } catch (error) {
      //Some error occurred
    }
  }

  clearImage() {
    setState(() {
      imageSelect = null;
    });
  }

  uploadImage() {
    setState(() async {
// Create the file metadata
      final metadata = SettableMetadata(contentType: "imageee/jpeg");

// Create a reference to the Firebase Storage bucket
      final storageRef = FirebaseStorage.instance.ref();

// Upload file and metadata to the path 'images/mountains.jpg'
      final uploadTask = storageRef.child("imagens").putFile(imageSelect);

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
            // Handle unsuccessful uploads
            break;
          case TaskState.success:
            // Handle successful uploads on complete
            // ...
            break;
        }
      });

      if (imageUrl.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
    });
  }
/*
  String title = 'BottomNavigationBar';

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }
  */

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
                        File(imageSelect.path),
                        fit: BoxFit.cover,
                      ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 10),
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
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (imageSelect != null)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 35, vertical: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                      onPressed: uploadImage,
                      child: const Text(
                        "Salvar",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  if (imageSelect != null)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                      onPressed: clearImage,
                      child: const Text(
                        "Eliminar",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                ],
              )
            ],
          ),
        ),
      ),
      /*
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.0),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(50.0)),
          child: Container(
            color: Color.fromARGB(194, 76, 175, 79),
            child: TabBar(
              labelColor: Colors.white,
              labelStyle: TextStyle(fontSize: 15),
              indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(color: Color.fromARGB(156, 76, 175, 79), width:
                  0.0),
                  insets: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 40.0)),
              // for indicator show and customization
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                  text: 'Camera',
                  icon: Icon(Icons.camera_alt),
                ),
                Tab(text: 'Gallery', icon: Icon(Icons.photo_library)),
                Tab(text: 'Exit', icon: Icon(Icons.exit_to_app)),
              ],
              controller: _tabController,
            ),
          ),
        ),
      )*/
    );
  }
}
