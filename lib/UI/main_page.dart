
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gifsearcher/UI/widgets/gif_builder.dart';
import 'package:gifsearcher/UI/widgets/loading_widgets.dart';
import 'package:gifsearcher/bloc/internet_connection/internet_cubit.dart';
import 'package:gifsearcher/bloc/internet_connection/internet_state.dart';
import 'package:gifsearcher/bloc/search/search_state.dart';
import 'package:gifsearcher/bloc/search/serach_cubit.dart';
import 'package:gifsearcher/bloc/settings/setting_cubit.dart';
import 'package:gifsearcher/bloc/settings/setting_state.dart';
import 'package:gifsearcher/bloc/speech_to_search.dart';
import 'package:gifsearcher/bloc/suggestion/suggestion_cubit.dart';
import 'package:gifsearcher/bloc/suggestion/suggestion_state.dart';
import 'package:gifsearcher/data/model/suggestion_model.dart';
import '../bloc/trending/gif_cubit.dart';
import '../bloc/trending/gif_state.dart';
import 'package:gifsearcher/data/model/gif_model.dart';


class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  late ScrollController controller;
  bool loading = false;
  late List<GifModel> gifList;
  late GlobalKey<RefreshIndicatorState> refKey;

  @override
  void initState(){
    refKey = GlobalKey<RefreshIndicatorState>();
    BlocProvider.of<GifCubit>(context).fetchGif();
    BlocProvider.of<InternetCubit>(context).checkConnection(firstCheck: true);
    controller = ScrollController();

    controller.addListener(() {
      if(controller.position.atEdge){
        if(controller.position.pixels != 0){

          BlocProvider.of<GifCubit>(context).fetchGif();
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Text("Gif", style: TextStyle(fontSize: 40.0, letterSpacing: 8.5),),
                        const SizedBox(width: 5,),
                        Icon(Icons.search, size: 40.0,)
                      ],
                    ),
                    const Text(
                        "Finder",
                        style: TextStyle(fontSize: 40.0, letterSpacing: 8.5)
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10.0,),
              ListTile(
                leading: const Text(
                  "Dark theme",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18.0,
                    letterSpacing: 5
                  ),
                ),
                trailing: BlocBuilder<SettingsCubit, SettingState>(
                  builder: (context, state){

                    bool value;

                    if(state is SettingsInit){
                      value = state.darkTheme;
                    }else if(state is SettingsChanged){
                      value = state.darkTheme;
                    }else{
                      value = false;
                    }

                    return Switch(
                        value: value,
                        onChanged: (newVal){
                          BlocProvider.of<GifCubit>(context).refresh();
                          BlocProvider.of<SettingsCubit>(context).changeThemeSettings(newVal, state);
                          if(Scaffold.of(context).isDrawerOpen) Scaffold.of(context).openEndDrawer();
                        }
                    );
                  },
                ),
              ),
              const SizedBox(height: 10.0,),
              ListTile(
                leading: const Text(
                  "List view",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18.0,
                    letterSpacing: 5
                  )
                ),
                trailing: BlocBuilder<SettingsCubit, SettingState>(
                  builder: (context, state){

                    bool value;

                    if(state is SettingsInit){
                      value = state.listView;
                    }else if(state is SettingsChanged){
                      value = state.listView;
                    }else{
                      value = false;
                    }

                    return Switch(
                      value: value,
                      onChanged: (val){
                        BlocProvider.of<GifCubit>(context).refresh();
                        BlocProvider.of<SettingsCubit>(context).changeViewSettings(val, state);
                        if(Scaffold.of(context).isDrawerOpen) Scaffold.of(context).openEndDrawer();
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          iconTheme: Theme.of(context).iconTheme,
          toolbarHeight: 100.0,
          title: Text(
            "Gif Finder",
            style: TextStyle(
                fontSize: 30.0,
                letterSpacing: 7.0,
                fontWeight: FontWeight.w300,
                color: Theme.of(context).textTheme.caption!.color
            ),
          ),
          centerTitle: true,
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Theme.of(context).textTheme.caption!.color!, width: 2.0),
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(10.0), bottomLeft: Radius.circular(10.0)),
          ),
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          actions: [
            IconButton(
                onPressed: (){
                  showSearch(context: context, delegate: GifSearch());
                },
                icon: Icon(
                  Icons.search,
                  color: Theme.of(context).iconTheme.color,
                  size: 30.0,
                ),
              tooltip: "Search gifs",
            ),

          ],
        ),
        body: RefreshIndicator(
          key: refKey,
          onRefresh: onRefresh,
          color: Theme.of(context).progressIndicatorTheme.circularTrackColor,
          backgroundColor: Theme.of(context).progressIndicatorTheme.refreshBackgroundColor,
          child: BlocBuilder<InternetCubit, InternetState>(
            builder: (context, internetState){

              if(internetState is InternetAvailable){
                BlocProvider.of<GifCubit>(context).fetchGif();
              }

              return BlocBuilder<GifCubit, GifState>(
                builder: (context, state){

                  if(internetState is InternetAvailable){
                    if(state is GifInitState){
                      return loadingWidget(context);
                    }else if(state is GifLoadingState){

                      loading = true;
                      gifList = state.oldGifs;

                      if(gifList.isEmpty){
                        return loadingWidget(context);
                      }
                    }else if(state is GifLoadedState){
                      loading = false;
                      gifList = state.allGifs;
                    }

                    return BlocBuilder<SettingsCubit, SettingState>(
                      builder: (context, settingsState){
                        if(settingsState is SettingsChanged){
                          if(settingsState.listView){
                            return gifListBuilderWidget(
                                gifList: gifList, controller: controller, loading: loading, context: context);
                          }else{
                            return gifGridBuilderWidget(
                                loading: loading,
                                controller: controller,
                                gifList: gifList,
                                context: context
                            );
                          }
                        }

                        return gifGridBuilderWidget(
                            loading: loading,
                            controller: controller,
                            gifList: gifList,
                            context: context
                        );
                      },
                    );
                  }else if(internetState is NoInternet){

                    return Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "No Internet,",
                            style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                          TextButton(
                            child: const Text(
                              "Try Again",
                              style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blue
                              ),
                            ),
                            onPressed: (){
                              refKey.currentState?.build(context);
                              refKey.currentState?.show();
                            },
                          )
                        ],
                      )
                    );

                  }else{
                    return loadingWidget(context);
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }


  Future<void> onRefresh(){
    BlocProvider.of<GifCubit>(context).refresh();
    BlocProvider.of<GifCubit>(context).fetchGif();
    return Future.delayed(Duration(milliseconds: 500),(){

    });
  }
}

class GifSearch extends SearchDelegate {

  ScrollController controller = ScrollController();
  late List<GifModel> gifList;
  late bool loading = false;
  int i = 0;


  @override
  Widget buildSuggestions(BuildContext context) {

    BlocProvider.of<GifSearchCubit>(context).newSearch();

    if(query.isNotEmpty){
      BlocProvider.of<SuggestionCubit>(context).fetchSuggestions(query);
    }


    if(i == 0){
      controller.addListener(() {
        if(controller.position.atEdge){
          if(controller.position.pixels != 0 ){
            BlocProvider.of<GifSearchCubit>(context).fetchGif(query: query);
          }
        }
      });
      i++;
    }

    return BlocBuilder<InternetCubit, InternetState>(
      builder: (context, internetState){
        if(internetState is InternetAvailable){
          return BlocBuilder<SuggestionCubit, SuggestionState>(
            builder: (context, state){

              if(state is SuggestionsInit) return loadingWidget(context);

              if(state is SuggestedState){
                return ListView.builder(
                    itemBuilder: (context,index){

                      List<String> list = containsQuery(state.suggestedWords, query);
                      String searchedWord = list[index];//state.suggestedWords[index].word;
                      String boldPart;
                      String remainingPart;

                      try{
                        boldPart = searchedWord.substring(0, query.length);
                        remainingPart = searchedWord.substring(query.length);
                      }catch(e){
                        return loadingWidget(context);
                      }

                      return list.isNotEmpty
                          ? ListTile(
                            title: RichText(
                              text: TextSpan(
                                  text: boldPart,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 18.0
                                  ),
                                  children: [
                                    TextSpan(
                                        text: remainingPart,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 18.0
                                        )
                                    )
                                  ]
                              ),
                            ),
                            onTap: (){
                              query = state.suggestedWords[index].word;
                              showResults(context);
                            },
                          )
                          : const Center(
                            child: CircularProgressIndicator(),
                        );
                    },
                    itemCount: containsQuery(state.suggestedWords, query).length
                ) ;
              }else{
                return loadingWidget(context);
              }
            },
          );
        }else{
          return showNoInternet();
        }
      },
    );
  }


  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.close),
        tooltip: "Close",
        onPressed: (){
          if(query.isEmpty){
            close(context, "");
          }else{
            query = "";
          }
        },
      ),
      IconButton(
        icon: Icon(Icons.mic),
        tooltip: "Voice search",
        onPressed: () async{
          SpeechApi().startListening(
            onResult: (String searchTerm){
              query = searchTerm;
              BlocProvider.of<GifSearchCubit>(context).newSearch();
              showSuggestions(context);
            },
            onListening: (){
              BlocProvider.of<SuggestionCubit>(context).newSuggestions();
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Listening...."),
                  )
              );
            },
            closeListening: (){
                ScaffoldMessenger.of(context).clearSnackBars();
            }
          );
        },

      )
    ];
  }

  @override
  void showSuggestions(BuildContext context) {
    // TODO: implement showSuggestions
    super.showSuggestions(context);
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: (){
        close(context, "");
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return BlocBuilder<InternetCubit, InternetState>(
      builder: (context, internetState){
        if(internetState is InternetAvailable){
          return BlocBuilder<GifSearchCubit, GifSearchState>(
            builder: (context, state){
              if(state is GifSearchInitState){
                return loadingWidget(context);
              }else if(state is GifSearchLoadingState){
                loading = true;
                gifList = state.oldGifs;

                if(gifList.isEmpty){
                  return loadingWidget(context);
                }
              }else if(state is GifSearchLoadedState){
                loading = false;
                gifList = state.allGifs;
              }

              return BlocBuilder<SettingsCubit, SettingState>(
                builder: (context, settingsState){
                  if(settingsState is SettingsChanged){
                    if(settingsState.listView){
                      return gifListBuilderWidget(
                          gifList: gifList, controller: controller, loading: loading, context: context);
                    }else{
                      return gifGridBuilderWidget(
                          loading: loading,
                          controller: controller,
                          gifList: gifList,
                          context: context
                      );
                    }
                  }

                  return gifGridBuilderWidget(
                      loading: loading,
                      controller: controller,
                      gifList: gifList,
                      context: context
                  );
                },
              );
            },
          );
        }else{
          return showNoInternet();
        }
      },
    );

  }

  ////widget
  Widget showNoInternet(){
    return const Center(
      child: Text(
        "Oops! No internet",
        style: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  List<String> containsQuery(List<SuggestionModel> suggestionList, String query){

    List<String> filteredList = [];
    suggestionList.map((suggestion){
      if(suggestion.word.length >= query.length){
        filteredList.add(suggestion.word);
      }
    }).toList();

    return filteredList;
  }

  @override
  void close(BuildContext context, _) {

    BlocProvider.of<GifSearchCubit>(context).newSearch();
    BlocProvider.of<SuggestionCubit>(context).newSuggestions();
    super.close(context, _);

  }

  @override
  void showResults(BuildContext context) {
    // TODO: implement showResults

    BlocProvider.of<GifSearchCubit>(context).newSearch();
    BlocProvider.of<GifSearchCubit>(context).fetchGif(query: query);


    super.showResults(context);
  }

}
