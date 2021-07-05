import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool _loading = true;
  File _image;
  List _output;
  final picker = ImagePicker();

  @override
  void initState(){
    super.initState();
    loadModel().then((value){
      setState(() {

      });
    });
  }

  dectectImage(File image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 2,
        threshold: 0.6,
        imageMean: 127.5,
        imageStd: 127.5
    );
    setState(() {
      _output = output;
      _loading = false;
    });
  }

  loadModel() async{
    await Tflite.loadModel(model: 'assets/model_unquant.tflite', labels: 'assets/labels.txt');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  pickImage()async{
    var image = await picker.getImage(source: ImageSource.camera);
    if(image == null) return null;

    setState(() {
      _image = File(image.path);
    });

    dectectImage(_image);
  }

  pickGalleryImage()async{
    var image = await picker.getImage(source: ImageSource.gallery);
    if(image == null) return null;

    setState(() {
      _image = File(image.path);
    });

    dectectImage(_image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50,),
            Text("Henrique Rodrigues", style: TextStyle(color: Colors.white,
                fontSize: 20),),
            SizedBox(height: 5,),
            Text("Analize Facial Simples", style: TextStyle(color:Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w500),),
            SizedBox(height: 50,),
            Center(child: _loading ? Container(
              width: 350,
              child: Column(
                children: [
                  Image.asset("assets/kjh.jpg"),
                  SizedBox(height: 50,)
                ],
              ),
            ) : Container(
              child: Column(children: <Widget>[
                Container(
                  height: 250,
                  child: Image.file(_image),
                ),
                SizedBox(height: 20),
                _output != null
                    ? Text('${_output[0]['label']}',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15
                  ),
                )
                    : Container(),
                SizedBox(height: 10),
              ],),)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RaisedButton(
                    child: Text("Câmera"),
                    onPressed: (){
                      pickImage();
                    }
                ),
                RaisedButton(
                    child: Text("Galeria"),
                    onPressed: (){
                      pickGalleryImage();
                    }
                )
              ],
            )





          ],
        ),
      ),
    );
  }
}
