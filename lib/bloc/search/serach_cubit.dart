
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gifsearcher/bloc/search/search_state.dart';
import 'package:gifsearcher/bloc/trending/gif_state.dart';
import 'package:gifsearcher/data/model/gif_model.dart';
import 'package:gifsearcher/data/repository/gif_repo.dart';

class GifSearchCubit extends Cubit<GifSearchState>{

  GifSearchCubit():super(GifSearchInitState());

  int offset = 0;

  fetchGif({required String query}) async{

    if(state is GifSearchLoadingState) return;

    List<GifModel> oldList = [];

    if(state is GifSearchLoadedState){
      oldList = (state as GifSearchLoadedState).allGifs;
    }


    emit(GifSearchLoadingState(oldGifs: oldList));

    if(state is GifSearchLoadingState){
      List<GifModel> gifList = await GifRepo().getGif(offset, query: query);
      List<GifModel> oldGifs = [];
      if(state is GifSearchLoadingState){
        oldGifs = (state as GifSearchLoadingState).oldGifs;
      }

      oldList.addAll(gifList);

      Future.delayed(const Duration(milliseconds: 600), (){
        emit(GifSearchLoadedState(allGifs: oldGifs, offset: offset));
      });
      offset += 10;
    }
  }

  newSearch(){
    offset = 0;
    emit(GifSearchInitState());
  }
}