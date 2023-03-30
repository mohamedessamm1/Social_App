import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icon_broken/icon_broken.dart';
import '../../Share/cubit/Cubit.dart';
import '../../Share/cubit/States.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(

          backgroundColor: Colors.black,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => Card(
                          color: Colors.grey.shade900,
                          child: Padding(
                            padding: EdgeInsets.all(5.0.w),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const CircleAvatar(
                                        backgroundImage:
                                            AssetImage('assets/images/me.jpg')),
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Mohamed essam',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          'March 26, 2023 01:00 GMT',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 13.sp),
                                        )
                                      ],
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      icon: const Icon(IconBroken.More_Circle),
                                      onPressed: () {},
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                                Divider(
                                  color: Colors.grey.shade800,
                                ),
                                const Text(
                                  '''
There are many variations of passages of Lorem Ips
um available, but the majority have suffered alterat
ion in some form, by injected humour, or randomised words which don't look even slightly believable.
 If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text.
 ''',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 180.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      image: const DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              'https://thumbs.dreamstime.com/b/beautiful-girl-tank-top-reaching-hands-stretching-arms-forward-smiling-welcome-hugging-greeting-someone-beautiful-girl-238738790.jpg'))),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Row(
                                  children: const [
                                    Spacer(flex: 1),
                                    Icon(IconBroken.Heart, color: Colors.red),
                                    Text(
                                      ' 169 Likes',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Spacer(flex: 12),
                                    Icon(IconBroken.Chat, color: Colors.grey),
                                    Text(
                                      ' 125 comments',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Spacer(flex: 1),
                                  ],
                                ),
                                Divider(
                                  color: Colors.grey.shade800,
                                ),
                                Row(
                                  children: [
                                    const CircleAvatar(
                                        radius: 16,
                                        backgroundImage: NetworkImage(
                                            'https://machohairstyles.com/wp-content/uploads/2017/03/professional-hairstyle-for-men-7.jpg')),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Container(
                                      width: 190.w,
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          hintText: 'Write a comment...',
                                          hintStyle: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 15.sp),
                                        ),
                                      ),
                                    ),
                                    Spacer(flex: 1,),

                                    Icon(IconBroken.Heart,
                                        color: Colors.red, size: 18.w),
                                    const Text(
                                      ' Like',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Spacer(flex: 1,),

                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: 15)
              ],
            ),
          ),
        );
      },
    );
  }
}
