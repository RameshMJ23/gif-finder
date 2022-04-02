
import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gifsearcher/bloc/internet_connection/internet_state.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetCubit extends Cubit<InternetState>{

  InternetCubit():super(InternetState());


  checkConnection({bool firstCheck = false}) async{

    if(firstCheck){
      Connectivity().checkConnectivity().then((value){
        if(value == ConnectivityResult.none){
          emit(NoInternet());

        }else{
          InternetConnectionChecker().hasConnection.then((value) {
            if(value){
              emit(InternetAvailable());
            }else{
              emit(NoInternet());
            }
          });
        }
      });
    }

    Connectivity().onConnectivityChanged.listen((event) async{
      if(event == ConnectivityResult.none){
        emit(NoInternet());
      }else{
        InternetConnectionChecker().hasConnection.then((value){
          if(value){
            emit(InternetAvailable());
          }else{
            emit(NoInternet());
          }
        });
      }
    });
  }
}