import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter_ibm_watson/flutter_ibm_watson.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String text = "";
  AudioPlayer _audioPlayer = new AudioPlayer();
  String APIKEY = "48vp1qSMXo8Gpv_2HuseDCx7cPbl8H3eBFpynZze2lPN";
  String IBM_URL =
      "https://api.us-south.text-to-speech.watson.cloud.ibm.com/instances/bd0c3fd6-98ec-4d27-b37a-489325dc1dde";

  void TTS(String txt) async {
    IamOptions options =
        await IamOptions(iamApiKey: APIKEY, url: IBM_URL).build();
    TextToSpeech service = new TextToSpeech(iamOptions: options);
    Uint8List speech = await service.toSpeech(txt);
    _audioPlayer.playBytes(speech);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(onChanged: (value) {
                setState(() {
                  text = value;
                });
              }),
            ),
            ElevatedButton(
                onPressed: () {
                  TTS(text);
                },
                child: Text("Speak"))
          ],
        ),
      ),
    );
  }
}
