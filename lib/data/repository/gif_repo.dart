
import 'package:gifsearcher/data/api_service/api_service.dart';
import 'package:gifsearcher/data/model/gif_model.dart';
import 'package:gifsearcher/data/model/suggestion_model.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

class GifRepo{

  Future<List<GifModel>> getGif(int offset, {String? query}) async{
    final response;

    if(query == null){
      response = await ApiService().fetchGif(offset);
    }else{
      response = await ApiService().fetchQuery(offset, query);
    }

    if(response != null){
      return getGifList(response.body);
    }else{
      return [];
    }
  }

  Future<List<SuggestionModel>> getSuggestions(String suggestionQuery) async{

    final response = await ApiService().fetchSuggestion(suggestionQuery);

    if(response != null){
      return getSuggestionList(response.body);
    }else{
      return [];
    }
  }
}