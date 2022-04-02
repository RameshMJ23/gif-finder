

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechApi{

  final _speechApi = SpeechToText();


  Future<bool> startListening({
    required Function(String result) onResult,
    required Function() onListening,
    required Function() closeListening,
  }) async{

    if(_speechApi.isListening){
      closeListening();
      _speechApi.stop();
      return true;
    }

    bool isAvailable = await _speechApi.initialize();

    if(isAvailable){
      onListening();
      _speechApi.listen(
         onResult: (value){
           closeListening();
           onResult(value.recognizedWords);
         },
      );
    }

    return _speechApi.isListening;
  }

}