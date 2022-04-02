
import 'dart:developer';

import 'package:http/http.dart' as http;

class ApiService{

  static const limit = 10;

  static const apiKey = "nuDXk5UcSvMKtEfeKlytg7W0sOxW6XnV";

  static const baseUrl = "https://api.giphy.com/v1/gifs/trending?api_key=$apiKey&limit=$limit";

  static const searchUrl = "https://api.giphy.com/v1/gifs/search?api_key=$apiKey";

  static const suggestionUrl = 'https://api.datamuse.com/sug?s=';

  Future<http.Response?> fetchGif(int offset) async{
    try{
      http.Response response = await http.get(Uri.parse("$baseUrl&offset=$offset"));

      if(response.statusCode == 200){
        return response;
      }else{
        return null;
      }
    }catch(e){
      log(e.toString());
    }
  }

  Future<http.Response?> fetchQuery(int offset, String query) async{
    try{
      http.Response response = await http.get(Uri.parse("$searchUrl&q=$query&limit=$limit&offset=$offset"));

      if(response.statusCode == 200){
        return response;
      }else{
        return null;
      }
    }catch(e){
      log(e.toString());
    }
  }

  Future<http.Response?> fetchSuggestion(String suggestionQuery) async{
    try{
      http.Response response = await http.get(Uri.parse("$suggestionUrl$suggestionQuery&max=5"));

      if(response.statusCode == 200){
        return response;
      }else{
        return null;
      }
    }catch(e){
      log(e.toString());
    }
  }
}