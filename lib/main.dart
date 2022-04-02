import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gifsearcher/UI/main_page.dart';
import 'UI/theme/theme_builder.dart';
import 'package:gifsearcher/bloc/internet_connection/internet_cubit.dart';
import 'package:gifsearcher/bloc/search/serach_cubit.dart';
import 'package:gifsearcher/bloc/settings/setting_cubit.dart';
import 'package:gifsearcher/bloc/suggestion/suggestion_cubit.dart';
import 'bloc/trending/gif_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GifCubit()),
        BlocProvider(create: (context) => GifSearchCubit()),
        BlocProvider(create: (context) => SuggestionCubit()),
        BlocProvider(create: (context) => InternetCubit()),
        BlocProvider(create: (context) => SettingsCubit())
      ],
      child: CustomThemeBuilder(
        buildFunc: (context, theme){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Gif finder',
            theme: theme,
            //darkTheme: darkTheme,
            home: MainPage(),
          );
        },
      ),
    );
  }

}
