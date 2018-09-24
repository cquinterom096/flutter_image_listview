import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import 'models/image_model.dart';
import 'dart:convert';
import 'widgets/image_list.dart';

class App extends StatefulWidget {
  createState(){
    return AppState();
  }
}

// Si no mantendrá su estado, como un contador, entonces es stateless
// Si mantiene su propio estado es stateful
class AppState extends State<App> {
  int counter = 0;
  List<ImageModel> images = [];

  void fetchImage() async { //async goes with await
    counter++;
    final response = await get('https://jsonplaceholder.typicode.com/photos/$counter');
    final imageModel = ImageModel.fromJson(json.decode(response.body));
    setState((){
      images.add(imageModel);
    });
  }

  // Todos requieren de un return de un build del widget
  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        body: ImageList(images),  // Text('$counter'),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.adjust),
          onPressed: fetchImage, //lazy load, doesn't run method at start
          // onPressed: () {
          //   fetchImage()
            // setState(() {
            //   counter += 1;
            // });
          // },
          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
        ),
        appBar: AppBar(
          title: Text("Let's see some images"),
        ),
      ),
    );
  }
}