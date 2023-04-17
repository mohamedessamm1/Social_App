import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:social/modules/addPost/addpost.dart';

import '../Share/cubit/Cubit.dart';
import '../Share/cubit/States.dart';

class HomeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body:
              AppCubit.get(context).screens[AppCubit.get(context).Currentindex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: AppCubit.get(context).Currentindex,
            onTap: (index) {
              AppCubit.get(context).ChangeBottomNav(index);
            },
            backgroundColor: Colors.black,
            elevation: 0,
            selectedItemColor: Colors.blue.shade800,
            unselectedItemColor: Colors.grey,
            enableFeedback: true,
            items: [
              const BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Home,
                  ),
                  label: 'Home',
                  backgroundColor: Colors.black),
              const BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Chat,
                  ),
                  label: 'Chat',
                  backgroundColor: Colors.black),
              const BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Video
                    ,
                  ),
                  label: 'Video Call',
                  backgroundColor: Colors.black),
              const BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Profile,
                  ),
                  label: 'Profile',
                  backgroundColor: Colors.black),
            ],
          ),
        );
      },
    );
  }
}
