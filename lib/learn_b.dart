// ignore_for_file: prefer_const_constructors

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'custom_appbar.dart';
import 'package:audioplayers/audioplayers.dart';

class LearnB extends StatelessWidget {
  const LearnB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AudioPlayer player = AudioPlayer();
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Color(0xFF7CC5CB),
        toolbarHeight: 70,
        title: CustomAppBar(imageLink: '',),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20.0),
          ),
        ),
      ),
      body: Container(
        color: Color.fromRGBO(235, 252, 250, 100),
        child: Padding(
          padding: EdgeInsets.all(50.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset('Assets/sea.jpg'),
              Image.asset('Assets/baa.png'),
              IconButton(
                icon: Icon(Icons.mic),
                iconSize: 90,
                color: Color(0xFFFAC963),
                onPressed: () async {
                  String audioasset = "Assets/audio/baa.mp3";
                  ByteData bytes = await rootBundle.load(audioasset); //load sound from assets
                  Uint8List  soundbytes = bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
                  int result = await player.playBytes(soundbytes);
                  if(result == 1){ //play success
                    print("Sound playing successful.");
                  }else{
                    print("Error while playing sound.");
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}