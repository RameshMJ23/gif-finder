
import 'dart:convert';

class GifModel{

  String title;
  String userName;
  String url;

  GifModel({
    required this.title,
    required this.url,
    required this.userName
  });

  factory GifModel.fromJson(json) => GifModel(
      title: json['title'],
      url: json['images']['fixed_height']['url'],
      userName: json['username'] ?? ""
  );
}

List<GifModel> getGifList(String jsonString) => List<GifModel>.from(jsonDecode(jsonString)['data'].map(
    (gif) => GifModel.fromJson(gif)
));
