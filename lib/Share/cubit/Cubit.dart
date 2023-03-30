import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../modules/chat/chats_screen.dart';
import '../../modules/home/HomeScreen.dart';
import '../../modules/settings/Settings.dart';
import '../../modules/users/UsersScreen.dart';
import 'States.dart';

class AppCubit extends Cubit<AppState>{
  AppCubit() :super(AppInitialState());
  static AppCubit get(context) =>BlocProvider.of(context);

  int Currentindex=0;

   ChangeBottomNav(index){
    Currentindex=index;
    emit(ChangeBottomNavState());
  }

List<Widget> screens=[

  HomeScreen(),
  ChatsScreen(),
  UsersScreen(),
  SettingsScreen(),

];

}