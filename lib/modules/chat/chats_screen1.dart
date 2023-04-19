import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:social/models/UserCreateModel.dart';
import 'package:social/modules/chat/chat_screen2.dart';

import '../../Share/cubit/Cubit.dart';
import '../../Share/cubit/States.dart';
import '../home/HomeScreen.dart';

class ChatsScreen1 extends StatelessWidget {
  const ChatsScreen1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      AppCubit.get(context).GetAllUsersData();
                    },
                    icon: Icon(Icons.refresh_rounded))
              ],
              backgroundColor: Colors.blue.shade900.withOpacity(0.3),
              title: const Text('Messages'),
              leading: const Text(''),
            ),
            body: ConditionalBuilder(
                condition: state is! GetAllUsersDataLoadingState,
                builder: (context) => ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: SizedBox(
                            height: 66.h,
                            child: InkWell(
                              splashColor: Colors.blue.shade900,
                              highlightColor: Colors.blue,
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChatsScreen2(
                                              uid: AppCubit.get(context)
                                                  .users[index]
                                                  .uid,
                                              name: AppCubit.get(context)
                                                  .users[index]
                                                  .name,
                                              image: AppCubit.get(context)
                                                  .users[index]
                                                  .image,
                                            )));
                              },
                              child: Row(
                                children: [
                                  CircleAvatar(
                                      radius: 24.r,
                                      backgroundColor: Colors.grey.shade800,
                                      backgroundImage: NetworkImage(
                                          '${AppCubit.get(context).users[index].image}')),
                                  SizedBox(
                                    width: 15.w,
                                  ),
                                  Text(
                                    '${AppCubit.get(context).users[index].name}',
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    icon: const Icon(IconBroken.More_Circle),
                                    onPressed: () {},
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                    separatorBuilder: (context, index) => Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Divider(
                            color: Colors.grey.shade800,
                          ),
                        ),
                    itemCount: AppCubit.get(context).users.length),
                fallback: (context) => Center(
                      child: CircularProgressIndicator(
                        color: Colors.blue.shade900,
                      ),
                    )));
      },
    );
  }
}
