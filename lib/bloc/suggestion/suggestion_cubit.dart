
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gifsearcher/bloc/suggestion/suggestion_state.dart';
import 'package:gifsearcher/data/model/suggestion_model.dart';
import 'package:gifsearcher/data/repository/gif_repo.dart';

class SuggestionCubit extends Cubit<SuggestionState>{

  SuggestionCubit():super(SuggestionsInit());

  fetchSuggestions(String query) async{
    if(state is SuggestedState){
      emit(SuggestionsInit());
    }

    List<SuggestionModel> suggestionList = await GifRepo().getSuggestions(query);


    emit(SuggestedState(suggestedWords: suggestionList));
  }

  newSuggestions(){
    emit(SuggestionsInit());
  }
}