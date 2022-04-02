
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gifsearcher/bloc/settings/setting_state.dart';

class SettingsCubit extends Cubit<SettingState>{

  SettingsCubit():super(SettingsInit());

  changeThemeSettings(bool isDarkTheme, SettingState state){
    emit(SettingsChanged(darkTheme: isDarkTheme, listView: false));
    if(state is SettingsChanged){
      emit(SettingsChanged(darkTheme: isDarkTheme, listView: state.listView));
    }else{
      emit(SettingsChanged(darkTheme: isDarkTheme, listView: false));
    }
  }

  changeViewSettings(bool isList, SettingState state){
    if(state is SettingsChanged){
      emit(SettingsChanged(darkTheme: state.darkTheme, listView: isList));
    }else{
      emit(SettingsChanged(darkTheme: false, listView: isList));
    }
  }
}