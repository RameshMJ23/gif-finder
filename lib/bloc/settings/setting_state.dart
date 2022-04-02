
import 'package:equatable/equatable.dart';

class SettingState extends Equatable{

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SettingsInit extends SettingState{
  bool darkTheme;
  bool listView;

  SettingsInit({
    this.darkTheme = false,
    this.listView = false
  });

  @override
  // TODO: implement props
  List<Object?> get props => [darkTheme, listView];
}

class SettingsChanged extends SettingState{
  bool darkTheme;
  bool listView;

  SettingsChanged({
    required this.darkTheme,
    required this.listView
  });


  @override
  // TODO: implement props
  List<Object?> get props => [darkTheme, listView];
}