

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/HomeLayout/HomeLayout.dart';

import 'Login_States.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);


void LoginFirebase({
    email,
  password,
  context
}){
  emit(LoginLoadingState());
  FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password
  ).then((value){
    print(value.additionalUserInfo?.isNewUser);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeLayout(),));
    emit(LoginSuccesState());

  }
  ).catchError((error){
    emit(LoginErrorState());
  });
}


  bool passvisible = true;
  IconData? suffixx = Icons.visibility_off;
Color? colorr;
  passwordvis() {
    passvisible = !passvisible;
    suffixx = passvisible ? Icons.visibility_off : Icons.visibility;
    colorr = passvisible ? Colors.grey : Colors.red;

    emit(passstate());
  }
}
