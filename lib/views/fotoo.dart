import 'dart:html';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
class fotoo extends StatefulWidget {
  const fotoo({Key key}) : super(key: key);

  @override
  State<fotoo> createState() => _fotooState();
}

class _fotooState extends State<fotoo> {

  File imageSelect;
  final _imagePicker = ImagePicker();


  @override

  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: Text('Seletor de Image'),),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

        imageSelect == null ? 
        AspectRatio(aspectRatio: 1.5,
        child: Container(
          color: Colors.green[200],
          child: Column(
            children: [
              Icon(Icons.image),
              Text('Não há Image Selecionada')
            ],
          ),
          
          ),
        ):
        AspectRatio(
          aspectRatio: 1.5,
          child: Image.file(
            File(imageSelect!.path),
            fit: BoxFit.cover,),
        ),
        Column(
          children: [
            ElevatedButton(onPressed: (){
              pickImageCamera();

            }, child: Text('Pick Image Camera'),
            ),
            ElevatedButton(onPressed: (){
              pickImageGallery();

            }, child: Text('Pick Image Gallery'),
            )
          ],

        )
        

        ],
        ),
    );
  }
  
  pickImageCamera() async {

    final XFile image = await _imagePicker.pickImage(source: ImageSource.camera);
    if(image != null){
      setState(() {
        imageSelect = File(image.path);
      });
    }
  }

  pickImageGallery() async {
    final XFile image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if(image != null){
      setState(() {
        imageSelect = File(image.path);
      });
    }

  }


}