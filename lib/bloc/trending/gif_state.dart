
import 'package:equatable/equatable.dart';
import 'package:gifsearcher/data/model/gif_model.dart';

class GifState extends Equatable{

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GifInitState extends GifState{

}

class GifLoadingState extends GifState{
  List<GifModel> oldGifs;


  GifLoadingState({required this.oldGifs});

  @override
  // TODO: implement props
  List<Object?> get props => [oldGifs];
}

class GifLoadedState extends GifState{
  List<GifModel> allGifs;

  GifLoadedState({required this.allGifs});

  @override
  // TODO: implement props
  List<Object?> get props => [allGifs];
}


