import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/HomeLayout/HomeLayout.dart';

import '../../models/UserCreateModel.dart';
import 'Signup_States.dart';

class SignCubit extends Cubit<SignStates> {
  SignCubit() : super(SignInitialState());
  static SignCubit get(context) => BlocProvider.of(context);

  SigninFirebase({
    name,
    email,
    pass,
    context,
    phone,
  }) {
    emit(SiginRegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: pass,
    )
        .then((value) {
      print('done');
      UserCreate(
        name: name,
        email: email,
        pass: pass,
        phone: phone,
        uid: value.user?.uid
      );
      emit(SignRegisterSuccessState());
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeLayout()));
    }).catchError((error) {
      emit(SignRegistrerrorState());
    });
  }

  UserCreate({
    name,
    email,
    pass,
    phone,
    uid,
  }) {
    emit(UserCreateLoadingState());
    CreateUserModel model = CreateUserModel(
      name: name,
      email: email,
      password: pass,
      phone: phone,
      uid: uid,
    );

    FirebaseFirestore.instance.collection('user').doc(uid).set(model.tojson()).then((value){
      print('done');
      emit(UserCreateSuccessState());
    });
  }

  bool RememberMe = false;
  void ChangeRememberMe() {
    RememberMe = !RememberMe;
    emit(ChangeRememberMeState());
  }

  bool passvisible = true;
  IconData? suffixx = Icons.visibility_off;
  Color? colorr;
  passwordvis() {
    passvisible = !passvisible;

    suffixx = passvisible ? Icons.visibility_off : Icons.visibility;
    colorr = passvisible ? Colors.grey : Colors.red;
    emit(SignPassState());
  }
}
