
import 'dart:convert';

class SuggestionModel{

  String word;
  String score;
  
  SuggestionModel({
    required this.word,
    required this.score
  });
}

List<SuggestionModel> getSuggestionList(String jsonString) => List<SuggestionModel>.from(
  jsonDecode(jsonString).map((suggestion) => SuggestionModel(
      word: suggestion['word'],
      score: suggestion['score'].toString()
  ))
);