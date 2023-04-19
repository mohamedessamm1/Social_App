import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/HomeLayout/HomeLayout.dart';
import 'package:social/Share/Cache_Helper/CacheHelper.dart';
import 'package:social/Share/constants/constants.dart';
import 'package:social/Share/cubit/Cubit.dart';
import 'package:social/Share/cubit/States.dart';

import '../../models/UserCreateModel.dart';
import 'Signup_States.dart';

class SignCubit extends Cubit<SignStates> {
  SignCubit() : super(SignInitialState());

  static SignCubit get(context) => BlocProvider.of(context);

  SigninFirebase({name, email, pass, context, phone, bio}) {
    emit(SiginRegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: pass,
    )
        .then((value) {
      print('done');
      GLOBALuid = value.user?.uid;
      UserCreate(
          bio:
              'The art of living involves knowing when to hold on and when to let go.',
          name: name.toString().toLowerCase(),
          email: email,
          pass: pass,
          phone: phone,
          uid: value.user?.uid,
          image:
              'https://toowoombaautoservices.com.au/wp-content/uploads/2020/01/person-1824144_1280-1080x1080.png',
          ImageBackGround:
              'https://th.bing.com/th/id/OIP.GpxDsdeZVdeaesbxJzeURAHaEK?pid=ImgDet&rs=1');
      emit(SignRegisterSuccessState());
      CacheHelper.savedata(key: 'uid', value: value.user?.uid);
      print(CacheHelper.getdata(key: 'uid').toString());
      AppCubit.get(context).GetUserData();
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
    image,
    ImageBackGround,
    bio,
  }) {
    CreateUserModel globalmodel = CreateUserModel(
        name: name,
        email: email,
        password: pass,
        phone: phone,
        uid: uid,
        image: image,
        ImageBackGround: ImageBackGround,
        bio: bio);
    FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .set(globalmodel.tojson())
        .then((value) {});
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
