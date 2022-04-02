
import 'package:equatable/equatable.dart';
import 'package:gifsearcher/data/model/gif_model.dart';

class GifSearchState extends Equatable{

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GifSearchInitState extends GifSearchState{

}

class GifSearchLoadingState extends GifSearchState{
  List<GifModel> oldGifs;


  GifSearchLoadingState({required this.oldGifs});

  @override
  // TODO: implement props
  List<Object?> get props => [oldGifs];
}

class GifSearchLoadedState extends GifSearchState{
  List<GifModel> allGifs;
  int offset;

  GifSearchLoadedState({required this.allGifs, required this.offset});

  @override
  // TODO: implement props
  List<Object?> get props => [allGifs, offset];
}
