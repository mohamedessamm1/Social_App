import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:social/Share/componant/Componant.dart';
import 'package:social/modules/SignIn/Signup_Cubit.dart';
import 'package:social/modules/SignIn/Signup_States.dart';
import '../../Share/Cache_Helper/CacheHelper.dart';
import '../../Share/constants/constants.dart';
import '../../Share/cubit/Cubit.dart';
import '../../Share/cubit/States.dart';

class UpdateProfileScreen extends StatelessWidget {
  var UpdateName = TextEditingController();
  var UpdateBio = TextEditingController();
  var UpdatePhone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        UpdateName.text = userModel!.name.toString();
        UpdateBio.text = userModel!.bio.toString();
        UpdatePhone.text = userModel!.phone.toString();
        var imageprofile = AppCubit.get(context).profileImage;
        var imagecover = AppCubit.get(context).CoverImage;
        return Scaffold(
          appBar: AppBar(
            leadingWidth: 135.w,
            leading: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Back to profile',
                  style: TextStyle(color: Colors.blue.shade800),
                )),
            backgroundColor: Colors.black,
            actions: [
              if (state is UploadProfileImageSuccessState ||
                  state is UploadCoverImageSuccessState) ...{
                TextButton(
                    onPressed: () {
                      AppCubit.get(context).UpdateUserData(
                        bio: UpdateBio.text,
                        name: UpdateName.text,
                        phone: UpdatePhone.text,
                      );
                      AppCubit.get(context).GetUserData();
                      Navigator.pop(context);
                    },
                    child: Text(
                      'update',
                      style: TextStyle(color: Colors.blue.shade800),
                    )),
              },
              SizedBox(
                width: 10.w,
              )
            ],
          ),
          backgroundColor: Colors.black,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0.w),
              child: Column(children: [
                if (state is PickProfileSuccesState ||
                    state is PickCoverSuccesState) ...{
                   LinearProgressIndicator(
                    minHeight: 1.9,
                    color: Colors.blue.shade900,
                    backgroundColor: Colors.black,
                  )
                },
                Stack(
                  children: [
                    Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: imagecover == null
                                    ? NetworkImage(
                                        '${userModel?.ImageBackGround}',
                                      )
                                    : FileImage(File(imagecover.path))
                                        as ImageProvider,
                              ),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10.r),
                                  bottomRight: Radius.circular(10.r))),
                          width: double.infinity,
                          height: 160.h,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.shade900.withOpacity(0.7),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10.r),
                                  bottomRight: Radius.circular(10.r))),
                          width: double.infinity,
                          height: 160.h,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              AppCubit.get(context).PickCover();
                            },
                            child: CircleAvatar(
                                backgroundColor:
                                    Colors.grey.shade900.withOpacity(0.8),
                                radius: 40,
                                child: const Icon(
                                  IconBroken.Camera,
                                  size: 60,
                                  color: Colors.white,
                                )),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 105.h,
                        ),
                        Stack(
                          children: [
                            Center(
                              child: CircleAvatar(
                                radius: 70.r,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 68.r,
                                  backgroundImage: imageprofile == null
                                      ? NetworkImage(
                                          '${userModel?.image}',
                                        )
                                      : FileImage(File(imageprofile.path))
                                          as ImageProvider,
                                ),
                              ),
                            ),
                            Center(
                              child: CircleAvatar(
                                backgroundColor:
                                    Colors.grey.shade900.withOpacity(0.5),
                                radius: 68.r,
                                child: Center(
                                  child: InkWell(
                                    onTap: () {
                                      AppCubit.get(context).PickImage();
                                    },
                                    child: CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        radius: 50.r,
                                        child: Icon(
                                          IconBroken.Camera,
                                          size: 50.r,
                                          color: Colors.white,
                                        )),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${userModel?.name}',
                      style: TextStyle(color: Colors.white, fontSize: 20.sp),
                    ),
                    SizedBox(
                      width: 4.h,
                    ),
                    Icon(
                      Icons.verified_rounded,
                      color: Colors.blue.shade800,
                      size: 20.r,
                    )
                  ],
                ),
                SizedBox(
                  height: 8.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: Text(
                    '${userModel?.bio}',
                    style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 35.w,
                    ),
                    Text(
                      'Your name',
                      style: TextStyle(
                          color: Colors.grey.shade300, fontSize: 16.sp),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 20.w,),
                    ConditionalBuilder(
                        condition: state is! UpdateUserNameDataLoadingState ,
                        builder: (context)=>Expanded(
                          child: defaultFormField(
                              FormFieldStyle: const TextStyle(color: Colors.white),
                              HintStyle: TextStyle(
                                  color: Colors.grey.shade300,
                                  fontWeight: FontWeight.w500),
                              controller: UpdateName,
                              Hint: 'Your Name',
                              type: TextInputType.name,
                              mycolor: Colors.grey.shade800),
                        ),

                        fallback: (context)=>  CircularProgressIndicator(color: Colors.blue.shade900,)
                    ),
                    if(state is! UpdateUserNameDataLoadingState)...{
                      IconButton(onPressed: (){

                        AppCubit.get(context).UpdateUserDataName(
                            name: UpdateName.text
                        );
                      }, icon: Icon(Icons.save,color: Colors.blue.shade900,))

                    }
                  ],
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    SizedBox(
                      width: 35.w,
                    ),
                    Text(
                      'Your bio',
                      style: TextStyle(
                          color: Colors.grey.shade300, fontSize: 16.sp),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20.w,
                    ),
                    ConditionalBuilder(
                        condition: state is! UpdateUserBioDataLoadingState ,
                        builder: (context)=>                    Expanded(
                          child: defaultFormField(
                              mywidth: 300,
                              FormFieldStyle: const TextStyle(color: Colors.white),
                              mycolor: Colors.grey.shade800,
                              HintStyle: TextStyle(
                                  color: Colors.grey.shade300,
                                  fontWeight: FontWeight.w500),
                              Hint: 'Your name',
                              controller: UpdateBio,
                              type: TextInputType.text),
                        ),


                        fallback: (context)=>  CircularProgressIndicator(color: Colors.blue.shade900,)
                    ),
                    if(state is! UpdateUserBioDataLoadingState)...{
                      IconButton(onPressed: (){

                        AppCubit.get(context).UpdateUserDataBio(
                            bio: UpdateBio.text
                        );
                      }, icon: Icon(Icons.save,color: Colors.blue.shade900,))

                    }
,
                  ],
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    SizedBox(
                      width: 35.w,
                    ),
                    Text(
                      'Your phone',
                      style: TextStyle(
                          color: Colors.grey.shade300, fontSize: 16.sp),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    SizedBox(width: 20.w,),
                    ConditionalBuilder(
                        condition: state is! UpdateUserPhoneDataLoadingState ,
                        builder: (context)=> Expanded(
                          child: defaultFormField(
                              FormFieldStyle: const TextStyle(color: Colors.white),
                              mycolor: Colors.grey.shade800,
                              HintStyle: TextStyle(
                                  color: Colors.grey.shade300,
                                  fontWeight: FontWeight.w500),
                              Hint: 'Your Phone',
                              controller: UpdatePhone,
                              type: TextInputType.phone),
                        ),

                        fallback: (context)=>  CircularProgressIndicator(color: Colors.blue.shade900,)
                    ),
                    if(state is! UpdateUserPhoneDataLoadingState)...{
                      IconButton(onPressed: (){

                        AppCubit.get(context).UpdateUserDataPhone(
                            phone: UpdatePhone.text
                        );
                        print(GLOBALuid);
                        print(userModel?.uid);
                      }, icon: Icon(Icons.save,color: Colors.blue.shade900,))

                    }


                  ],
                ),
              ]),
            ),
          ),
        );
      },
    );
  }
}
