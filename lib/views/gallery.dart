import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class Galeria extends StatelessWidget {
  Galeria({Key key}) : super(key: key) {
    _stream = _reference.snapshots();
  }

  CollectionReference _reference = FirebaseFirestore.instance.collection('gallery');

  Stream<QuerySnapshot> _stream;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Galeria'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //Check error
          if (snapshot.hasError) {
            return Center(child: Text('Some error occurred ${snapshot.error}'));
          }

          //Check if data arrived
          if (snapshot.hasData) {
            //get the data
            QuerySnapshot querySnapshot = snapshot.data;
            List<QueryDocumentSnapshot> documents = querySnapshot.docs;

            //Convert the documents to Maps
            List<Map> items = documents.map((e) => e.data() as Map).toList();

            //Display the list
            return GridView.builder(
                gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 10,
                  ),
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  //Get the item at this index
                  Map thisItem = items[index];
                  //Return the widget for the list items
                  return Container(
                    child: thisItem.containsKey('image') ? Image.network(
                          '${thisItem['image']}') : Container(),
                  );
                },
              );
          }

          //Show loader
          return Center(child: CircularProgressIndicator());
        },
      ), //Display a list // Add a FutureBuilder
    );
  }
}