import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:social/modules/Login/Login.dart';
import 'HomeLayout/HomeLayout.dart';
import 'Share/cubit/Cubit.dart';
import 'loginm.dart';
import 'modules/Login/Login_Cubit.dart';
import 'modules/SignIn/SignUp.dart';
import 'modules/SignIn/Signup_Cubit.dart';
import 'modules/settings/Settings.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await  Firebase.initializeApp();

  runApp( const MyApp());


}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, screenUtil) {
          return  MultiBlocProvider(
              providers:

              [
                BlocProvider(create: (context) => AppCubit()),
                BlocProvider(create: (context) => LoginCubit()),
                BlocProvider(create: (context) => SignCubit()..UserCreate()),

              ],
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                home: Scaffold(
                  body: HomeLayout()
                ),
              )
          );
        }
       );
  }
}


