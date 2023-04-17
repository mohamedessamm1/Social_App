import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:social/Share/Cache_Helper/CacheHelper.dart';
import 'package:social/Share/constants/constants.dart';
import 'package:social/models/AddPostModel.dart';
import '../../Share/cubit/Cubit.dart';
import '../../Share/cubit/States.dart';
import '../addPost/addpost.dart';

AddPostModel? model;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = AppCubit.get(context).posts;
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue.shade900.withOpacity(0.3),
              actions: [
                IconButton(
                  icon: const Icon(Icons.refresh_rounded),
                  onPressed: () {
                    AppCubit.get(context).GetPosts();
                  },
                  color: Colors.white,
                ),
              ],
              title: const Text('home'),
              centerTitle: true,
              leading: const Text(''),
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AddPost()));
              },
              label: Column(
                children: [
                  Icon(
                    Icons.add,
                    size: 25.w,
                  ),
                ],
              ),
              shape: OutlineInputBorder(
                  borderSide: const BorderSide(style: BorderStyle.none),
                  borderRadius: BorderRadius.circular(15.r)),
              elevation: 5,
              heroTag: 'd',
              backgroundColor: Colors.blue.shade900,
            ),
            backgroundColor: Colors.black,
            body: ConditionalBuilder(
                condition: AppCubit.get(context).posts.isNotEmpty ,
                builder: (context) => SingleChildScrollView(
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
                                      CircleAvatar(
                                          backgroundColor:
                                          Colors.grey.shade800,
                                          backgroundImage: NetworkImage(
                                              '${model[index]['MyImage']}')),
                                      SizedBox(
                                        width: 20.w,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${model[index]['MyName']}',
                                            style: const TextStyle(
                                                fontWeight:
                                                FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            '${model[index]['Time']}',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 13.sp),
                                          )
                                        ],
                                      ),
                                      const Spacer(),
                                      model[index]['uid']== CacheHelper.getdata(key: 'uid')?
                                      IconButton(
                                        icon: const Icon(
                                            IconBroken.Delete),
                                        onPressed: () {
                                          AppCubit.get(context).DeletePost(AppCubit.get(context).PostId[index]);

                                        },
                                        color: Colors.white,
                                      )
:
                                          Text(''),



                                    ],
                                  ),
                                  Divider(
                                    color: Colors.grey.shade800,
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 300.w
                                        ,child: Text(
                                          '''  ${model[index]['MyText']} ''',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 24.sp),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  if (model[index]['PostImage'] !=
                                      null) ...{
                                    Container(
                                      width: double.infinity,
                                      height: 400.h,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(
                                              10.r),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  '${model[index]['PostImage']}'))),
                                    ),
                                  },
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Row(
                                    children: [
                                      Spacer(flex: 1),
                                      Icon(IconBroken.Heart,
                                          color: Colors.red),
                                      Text(
                                        '25 Likes',
                                        style: TextStyle(
                                            color: Colors.grey),
                                      ),
                                      Spacer(flex: 12),
                                      Icon(IconBroken.Chat,
                                          color: Colors.grey),
                                      Text(
                                        ' 0 comments',
                                        style: TextStyle(
                                            color: Colors.grey),
                                      ),
                                      Spacer(flex: 1),
                                    ],
                                  ),
                                  Divider(
                                    color: Colors.grey.shade800,
                                  ),
                                  Row(
                                    children: [
                                      CircleAvatar(
                                          radius: 16,
                                          backgroundImage: NetworkImage(
                                              '${userModel?.image}')),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      SizedBox(
                                        width: 190.w,
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            hintText:
                                            'Write a comment...',
                                            hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 15.sp),
                                          ),
                                        ),
                                      ),
                                      const Spacer(
                                        flex: 1,
                                      ),
                                      TextButton(
                                          onPressed: () {
                                          },
                                          child: Row(
                                            children: [
                                              Icon(
                                                IconBroken.Heart,
                                                size: 22.w,
                                                color: Colors.white,
                                              ),
                                              SizedBox(
                                                width: 5.w,
                                              ),
                                              Text(
                                                'Like',
                                                style: TextStyle(
                                                    color:
                                                    Colors.white),
                                              )
                                            ],
                                          )),
                                      const Spacer(
                                        flex: 1,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          separatorBuilder: (context, index) =>
                          const Divider(),
                          itemCount: AppCubit.get(context).posts.length)
                    ],
                  ),
                ),
                fallback: (context) =>  Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue.shade900,
                  ),
                )));
      },
    );
  }
}
