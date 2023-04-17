import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:social/Share/Cache_Helper/CacheHelper.dart';
import 'package:social/modules/Login/Login.dart';
import 'package:social/modules/settings/UpdateProfile_screen.dart';
import '../../Share/constants/constants.dart';
import '../../Share/cubit/Cubit.dart';
import '../../Share/cubit/States.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
            condition: state is! UploadProfileImageLoadingState,
            builder: (context) => Scaffold(
              appBar: AppBar(

                actions: [
                  IconButton(onPressed: (){
                    AppCubit.get(context).Currentindex=0;
                    CacheHelper.removedata(key: 'uid');
                    Navigator.pushReplacement(context,(MaterialPageRoute(builder: (context)=>loginscreen())));

                  }, icon:Icon(IconBroken.Logout),
                  ),
                  SizedBox(width: 20.w,),
                ],
                backgroundColor: Colors.blue.shade900.withOpacity(0.3),
                title: const Text('Profile'),
                centerTitle: true,
                leading: const Text(''),
              ),

              backgroundColor: Colors.black,
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                child: Column(children: [
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                '${userModel?.ImageBackGround}',
                              ),
                            ),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10.r),
                                bottomRight: Radius.circular(10.r))),
                        width: double.infinity,
                        height: 160.h,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 105.h,
                          ),
                          Center(
                            child: CircleAvatar(
                              radius: 70.r,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                backgroundColor: Colors.black,
                                  radius: 68.r,
                                  backgroundImage: NetworkImage(
                                    '${userModel?.image}',
                                  )),
                            ),
                          ),
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
                      Text('${userModel?.name}',style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp
                      ),),
                      SizedBox(
                        width: 4.h,
                      ),

                      Icon(Icons.verified_rounded,color: Colors.blue.shade800,size: 20.r,)
                    ],
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 25.w),
                    child: Text('${userModel?.bio}',style: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 14.sp
                        ,
                    ),),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Posts',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp),
                          ),
                          Text(
                            '${
                            AppCubit.get(context).posts.length
                            }',
                            style: TextStyle(color: Colors.grey.shade300),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Friends',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp),
                          ),
                          Text(
                            '${AppCubit.get(context).users.length}',
                            style: TextStyle(color: Colors.grey.shade300),
                          ),
                        ],
                      ),
                      const Spacer(),
                    ],
                  ),
                  SizedBox(height: 20.h,),
                  Row(
                    children: [
                      Expanded(
                          flex: 3,
                          child: OutlinedButton(
                              style: const ButtonStyle(
                                  splashFactory: InkSparkle
                                      .constantTurbulenceSeedSplashFactory,
                                  side: MaterialStatePropertyAll(
                                      BorderSide(color: Colors.grey))),
                              onPressed: () {},
                              child: Text(
                                'new post',
                                style: TextStyle(color: Colors.white),
                              ))),
                      SizedBox(
                        width: 5.w,
                      ),
                      Expanded(
                          flex: 1,
                          child: OutlinedButton(
                              style: const ButtonStyle(
                                  splashFactory: InkSparkle
                                      .constantTurbulenceSeedSplashFactory,
                                  side: MaterialStatePropertyAll(
                                      BorderSide(color: Colors.grey))),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                    MaterialPageRoute(builder: (context) =>UpdateProfileScreen() ,
                                    )
                                );
                              },
                              child: Icon(
                                IconBroken.Edit_Square,
                                color: Colors.white,
                              ))),
                    ],
                  )
                ]),
              ),
            ),
            fallback: (context)=>const Scaffold(
                backgroundColor: Colors.black,
                body: Center(child: CircularProgressIndicator())));

      },
    );
  }
}
