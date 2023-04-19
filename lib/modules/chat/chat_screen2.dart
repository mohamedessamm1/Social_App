import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:social/Share/constants/constants.dart';
import 'package:social/models/message_model.dart';
import '../../Share/cubit/Cubit.dart';
import '../../Share/cubit/States.dart';

class ChatsScreen2 extends StatelessWidget {
  String? uid;
  String? name;
  String? image;

  ChatsScreen2({
    this.uid,
    this.name,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        AppCubit.get(context).GetMessage(ReceiverId: uid);

        return BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {},
          builder: (context, state) {
            var TextControl = TextEditingController();
            ScrollController scrollController = ScrollController();
            final double itemsize = 100;
            return Scaffold(
                resizeToAvoidBottomInset: true,
                backgroundColor: Colors.black,
                appBar: AppBar(
                  leading: IconButton(
                      onPressed: () {
                        AppCubit.get(context).NewChatImage = null;
                        AppCubit.get(context).ChatImage = null;
                        AppCubit.get(context).ChatMessage = [];
                        Navigator.pop(context);
                      },
                      icon: Icon(IconBroken.Arrow___Left)),
                  backgroundColor: Colors.black,
                  title: Row(
                    children: [
                      CircleAvatar(
                          backgroundColor: Colors.grey.shade800,
                          backgroundImage: NetworkImage('${image}')),
                      SizedBox(
                        width: 20.w,
                      ),
                      Text(
                        '${name}',
                        style: TextStyle(fontSize: 18.sp),
                      ),
                    ],
                  ),
                  centerTitle: true,
                ),
                body: ConditionalBuilder(
                    condition: true,
                    builder: (context) => Column(
                          children: [
                            Expanded(
                              child: ListView.separated(
                                  physics: BouncingScrollPhysics(),
                                  controller:
                                      AppCubit.get(context).scrollController,
                                  cacheExtent: AppCubit.get(context).itemsize,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        if (userModel?.uid ==
                                            AppCubit.get(context)
                                                .ChatMessage[index]
                                                .SenderId) ...{
                                          sendmessage(AppCubit.get(context)
                                              .ChatMessage[index]),
                                        } else ...{
                                          receivemessage(AppCubit.get(context)
                                              .ChatMessage[index]),
                                        },
                                      ],
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      SizedBox(),
                                  itemCount:
                                      AppCubit.get(context).ChatMessage.length),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            if (AppCubit.get(context).ChatImage == null) ...{
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 15.w, right: 10.w),
                                child: Container(
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.r),
                                      color: Colors.white),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          controller: TextControl,
                                          decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.r),
                                                borderSide: BorderSide(
                                                    color: Colors
                                                        .transparent), //<-- SEE HERE
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.r),
                                                borderSide: BorderSide(
                                                    color: Colors
                                                        .transparent), //<-- SEE HERE
                                              ),
                                              border: InputBorder.none,
                                              fillColor: Colors.white,
                                              filled: true),
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            AppCubit.get(context).sendMessage(
                                                DateTime:
                                                    DateTime.now().toString(),
                                                Text: TextControl.text,
                                                ReceiverId: uid);
                                            AppCubit.get(context).NewChatImage =
                                                null;

                                            // AppCubit.get(context).getScroll();
                                            // FocusManager.instance.primaryFocus?.unfocus();
                                          },
                                          icon: Icon(
                                            Icons.send,
                                            color: Colors.blue.shade700,
                                          )),
                                      IconButton(
                                          onPressed: () {
                                            AppCubit.get(context)
                                                .PickChatImage();
                                          },
                                          icon: Icon(
                                            IconBroken.Image,
                                            color: Colors.blue.shade800,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            } else ...{
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade900,
                                    borderRadius: BorderRadius.circular(20.r)),
                                height: 205.h,
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 200.h,
                                        width: 200.w,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: FileImage(File(
                                                    AppCubit.get(context)
                                                        .ChatImage!
                                                        .path)),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          width: 360.w,
                                          height: 400.h,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 80.w,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                AppCubit.get(context)
                                                    .sendMessage(
                                                        image: AppCubit.get(
                                                                context)
                                                            .NewChatImage,
                                                        DateTime: DateTime.now()
                                                            .toString(),
                                                        ReceiverId: uid);
                                                AppCubit.get(context)
                                                    .NewChatImage = null;
                                                AppCubit.get(context)
                                                    .ChatImage = null;
                                              },
                                              icon: Icon(
                                                Icons.send,
                                                color: Colors.blue,
                                              )),
                                          SizedBox(
                                            height: 50.h,
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                AppCubit.get(context)
                                                    .CancelChatImage();
                                              },
                                              icon: Icon(
                                                IconBroken.Delete,
                                                color: Colors.red.shade800,
                                              )),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            },
                            SizedBox(
                              height: 10.h,
                            )
                          ],
                        ),
                    fallback: (context) => Center(
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Colors.blue.shade900,
                            ),
                          ),
                        )));
          },
        );
      },
    );
  }
}

Widget sendmessage(MessageModel messageModel) {
  return Align(
    alignment: AlignmentDirectional.bottomStart,
    child: Padding(
      padding: EdgeInsets.only(left: 10.w, top: 10.h),
      child: Container(
        width: 230.w,
        decoration: BoxDecoration(
            color: Colors.blue.shade900.withOpacity(0.4),
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(15.r),
              topRight: Radius.circular(15.r),
              topLeft: Radius.circular(15.r),
            )),
        child: Center(
            child: Padding(
          padding: EdgeInsets.all(8.0.w),
          child: messageModel.Image == null
              ? Text(
                  '${messageModel.Text}',
                  style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )
              : Container(child: Image.network('${messageModel.Image}')),
        )),
      ),
    ),
  );
}

Widget receivemessage(MessageModel messageModel) {
  return Align(
      alignment: AlignmentDirectional.bottomEnd,
      child: Padding(
        padding: EdgeInsets.only(right: 10.w, top: 10.h),
        child: Container(
          width: 230.w,
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.4),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15.r),
                topRight: Radius.circular(15.r),
                topLeft: Radius.circular(15.r),
              )),
          child: Center(
              child: Padding(
            padding: EdgeInsets.all(8.0.w),
            child: messageModel.Image == null
                ? Text(
                    '${messageModel.Text}',
                    style: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )
                : Container(child: Image.network('${messageModel.Image}')),
          )),
        ),
      ));
}
