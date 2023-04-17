import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:social/Share/constants/constants.dart';

import '../../Share/componant/Componant.dart';
import '../../Share/cubit/Cubit.dart';
import '../../Share/cubit/States.dart';

var PostController = TextEditingController();

class AddPost extends StatelessWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var postImage = AppCubit.get(context).PostImag;
        DateTime PostTime = DateTime.now();
        //   var x=  Jiffy.parse('2023-03-11 09:46:46.898192').fromNow();

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            actions: [
              TextButton(
                onPressed: () {
                  AppCubit.get(context).LISTzero();
                  if (postImage == null && PostController.text.isNotEmpty) {
                    AppCubit.get(context).AddMyPost(
                        MyText: PostController.text != ''
                            ? PostController.text
                            : '');
                  } else if (postImage == null && PostController.text.isEmpty) {
                  } else {
                    AppCubit.get(context).AddMyPostWithImage(
                        MyText: PostController.text != ''
                            ? PostController.text
                            : '');
                  }
                  AppCubit.get(context).GetPosts();
                  Navigator.pop(context);
                  AppCubit.get(context).CancelPostImage();
                  PostController.clear();

                },
                child: const Text(
                  'Post',
                  style: TextStyle(color: Colors.red),
                ),
              )
            ],
          ),
          backgroundColor: Colors.black,
          body: Padding(
            padding: EdgeInsets.all(10.0.w),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      child: CircleAvatar(
                          radius: 28.r,
                          backgroundImage: NetworkImage('${userModel?.image}')),
                      radius: 30.r,
                      backgroundColor: Colors.white,
                    ),
                    SizedBox(
                      width: 14.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${userModel?.name}',
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Row(
                          children: [
                            Text(
                              'Public',
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 13.sp),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            Text(
                              '|',
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 13.sp),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            // Text(
                            //   '${AppCubit.get(context).tim()}',
                            //   style: TextStyle(
                            //       color: Colors.grey, fontSize: 13.sp),
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 25.h,
                ),
                defaultFormField(
                  EnableBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade900)),
                  FocuseBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade700)),
                  MyBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade700)),
                  controller: PostController,
                  PaddingVertical: 15,
                  mywidth: 360,
                  FormFieldStyle: const TextStyle(color: Colors.white),
                  HintStyle: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w500),
                  Hint: 'what are you thinking now?',
                  type: TextInputType.name,
                  mycolor: Colors.black,
                ),
                if (postImage != null) ...{
                  if (AppCubit.get(context).POSTIMAGE == null) ...{
                    const LinearProgressIndicator(
                      color: Colors.red,
                      backgroundColor: Colors.black,
                    )
                  },
                  SizedBox(
                    height: 10.h,
                  ),
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(File(postImage.path)),
                            ),
                            borderRadius: BorderRadius.circular(5)),
                        width: 360.w,
                        height: 400.h,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.red.shade800.withOpacity(0.7),
                        child: Center(
                          child: IconButton(
                            icon: const Icon(Icons.close_rounded),
                            onPressed: () {
                              AppCubit.get(context).CancelPostImage();
                            },
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 70.h,
                  ),
                  OutlinedButton(
                      style: ButtonStyle(
                          minimumSize:
                              MaterialStatePropertyAll(Size.fromHeight(50.h)),
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r))),
                          splashFactory: InkRipple.splashFactory,
                          side: const MaterialStatePropertyAll(
                              BorderSide(strokeAlign: 0, color: Colors.white))),
                      onPressed: () {
                        AppCubit.get(context).PostImage();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            IconBroken.Image,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          const Text(
                            'Change The Photo',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ))
                } else ...{
                  SizedBox(
                    height: 25.h,
                  ),
                  const Text(''),
                  OutlinedButton(
                      style: ButtonStyle(
                          minimumSize:
                              MaterialStatePropertyAll(Size.fromHeight(50.h)),
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r))),
                          splashFactory: InkRipple.splashFactory,
                          side: MaterialStatePropertyAll(BorderSide(
                              strokeAlign: 0, color: Colors.grey.shade700))),
                      onPressed: () {
                        print(PostTime.toString());
                        AppCubit.get(context).PostImage();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            IconBroken.Image,
                            color: Colors.grey.shade600,
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          Text(
                            'Add Photo',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ],
                      ))
                },
              ],
            ),
          ),
        );
      },
    );
  }
}
