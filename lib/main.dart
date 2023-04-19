import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social/Share/Cache_Helper/CacheHelper.dart';
import 'package:social/modules/Login/Login.dart';
import 'package:social/modules/addPost/addpost.dart';
import 'package:social/modules/chat/chats_screen1.dart';
import 'HomeLayout/HomeLayout.dart';
import 'Share/constants/constants.dart';
import 'Share/cubit/Cubit.dart';
import 'modules/Login/Login_Cubit.dart';
import 'modules/SignIn/SignUp.dart';
import 'modules/SignIn/Signup_Cubit.dart';
import 'modules/settings/Settings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.initcache();
  String cacheint = CacheHelper.getdata(key: 'uid').toString();
  print(cacheint);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(350, 750),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, screenUtil) {
          return MultiBlocProvider(
              providers: [
                BlocProvider(
                    create: (context) => AppCubit()
                      ..GetUserData()
                      ..GetPosts()),
                BlocProvider(create: (context) => LoginCubit()),
                BlocProvider(create: (context) => SignCubit()),
              ],
              child: MaterialApp(
                theme: ThemeData(fontFamily: 'arimo'),
                debugShowCheckedModeBanner: false,
                home: Scaffold(
                    body: CacheHelper.getdata(key: 'uid') == null
                        ? loginscreen()
                        : HomeLayout()),
              ));
        });
  }
}
