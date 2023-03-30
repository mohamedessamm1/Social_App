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
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddPost()));
            },
            label: Column(
              children: [
                Icon(
                  IconBroken.Paper_Upload,
                  size: 25.w,
                ),
                Text(
                  'new post',
                  style: TextStyle(fontSize: 10.sp),
                ),
              ],
            ),
            shape: OutlineInputBorder(
                borderSide: BorderSide(style: BorderStyle.none),
                borderRadius: BorderRadius.circular(15.r)),
            elevation: 5,
            heroTag: 'd',
            backgroundColor: Colors.red.shade900,
          ),
          appBar: AppBar(
            backgroundColor: Colors.black,
            actions: [
              IconButton(
                icon: Icon(IconBroken.Notification),
                onPressed: () {},
                color: Colors.white,
              ),
              IconButton(
                icon: Icon(IconBroken.Chat),
                onPressed: () {},
                color: Colors.white,
              ),
            ],
            title: Text('home'),
          ),
          body:
              AppCubit.get(context).screens[AppCubit.get(context).Currentindex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: AppCubit.get(context).Currentindex,
            onTap: (index) {
              AppCubit.get(context).ChangeBottomNav(index);
            },
            backgroundColor: Colors.black,
            elevation: 0,
            selectedItemColor: Colors.red,
            unselectedItemColor: Colors.grey,
            enableFeedback: true,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Home,
                  ),
                  label: 'Home',
                  backgroundColor: Colors.black),
              BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Chat,
                  ),
                  label: 'Chat',
                  backgroundColor: Colors.black),
              BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Heart,
                  ),
                  label: 'Heart',
                  backgroundColor: Colors.black),
              BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Setting,
                  ),
                  label: 'Setting',
                  backgroundColor: Colors.black),
            ],
          ),
        );
      },
    );
  }
}
