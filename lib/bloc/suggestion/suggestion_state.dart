
import 'package:equatable/equatable.dart';
import 'package:gifsearcher/data/model/suggestion_model.dart';

class SuggestionState extends Equatable{

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SuggestionsInit extends SuggestionState{

}

class SuggestedState extends SuggestionState{

  List<SuggestionModel> suggestedWords;

  SuggestedState({required this.suggestedWords});

  @override
  // TODO: implement props
  List<Object?> get props => [suggestedWords];
}
