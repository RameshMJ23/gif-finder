
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gifsearcher/UI/main_page.dart';
import 'package:gifsearcher/UI/theme/theme_constants.dart';
import 'package:gifsearcher/bloc/settings/setting_cubit.dart';
import 'package:gifsearcher/bloc/settings/setting_state.dart';
import 'package:gifsearcher/bloc/trending/gif_cubit.dart';

class CustomThemeBuilder extends StatefulWidget {

  Function(BuildContext context, ThemeData themeData) buildFunc;

  CustomThemeBuilder({required this.buildFunc});

  @override
  _CustomThemeBuilderState createState() => _CustomThemeBuilderState();
}

class _CustomThemeBuilderState extends State<CustomThemeBuilder> {

  late ThemeData _themeData;

  @override
  void initState() {
    _themeData = lightTheme;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingState>(
      builder: (context, state){
        if(state is SettingsInit){
          _themeData = lightTheme;
        }else if(state is SettingsChanged){
         if(state.darkTheme){
           _themeData = darkTheme;
         }else{
           _themeData = lightTheme;
         }
        }
        return widget.buildFunc(context, _themeData);
      },
    );
  }
}
