
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'gif_state.dart';
import 'package:gifsearcher/data/model/gif_model.dart';
import 'package:gifsearcher/data/repository/gif_repo.dart';

class GifCubit extends Cubit<GifState>{

  GifCubit():super(GifInitState());

  int offset = 0;

  fetchGif() async{

    if(state is GifLoadingState) return;

    List<GifModel> oldList = [];

    if(state is GifLoadedState){
      oldList = (state as GifLoadedState).allGifs;
    }


    emit(GifLoadingState(oldGifs: oldList));

    if(state is GifLoadingState){

      List<GifModel> gifList = await GifRepo().getGif(offset);
      List<GifModel> oldList = [];

      if(state is GifLoadingState) oldList = (state as GifLoadingState).oldGifs;

      oldList.addAll(gifList);

      Future.delayed(const Duration(milliseconds: 600),(){
        emit(GifLoadedState(allGifs: oldList));
      });
      offset += 10;
    }
  }

  refresh(){
    offset = 0;
    emit(GifInitState());
  }

}