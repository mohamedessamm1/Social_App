import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social/Share/componant/Componant.dart';
import 'package:social/Share/cubit/Cubit.dart';
import 'package:social/Share/cubit/States.dart';
import 'package:social/modules/call/Videopage.dart';

import 'callpage.dart';

class callscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var Textcontorl = TextEditingController();
    Image myimage = Image.asset('assets/images/call.png');

    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  ConditionalBuilder(
                      condition: myimage != null,
                      builder: (context) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                                child: Column(
                              children: [
                                SizedBox(
                                  height: 80.h,
                                ),
                                myimage,
                                Text(
                                  'Pick your operation',
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                    Expanded(
                                      child: MyButton(
                                          function: () {
                                            AppCubit.get(context)
                                                .buttontoggle(0);
                                            print(AppCubit.get(context).buttn);
                                          },
                                          text: 'CALL',
                                          backgroundcolor:
                                              AppCubit.get(context).buttn == 0
                                                  ? Colors.blue.shade900
                                                  : Colors.grey.shade900),
                                    ),
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                    Expanded(
                                      child: MyButton(
                                          function: () {
                                            AppCubit.get(context)
                                                .buttontoggle(1);
                                            print(AppCubit.get(context).buttn);
                                          },
                                          text: 'Video',
                                          backgroundcolor:
                                              AppCubit.get(context).buttn == 1
                                                  ? Colors.blue.shade900
                                                  : Colors.grey.shade900),
                                    ),
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                if (AppCubit.get(context).buttn == 0) ...{
                                  Text(
                                    'Enter your Call id',
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      style: TextStyle(color: Colors.white),
                                      controller: Textcontorl,
                                      decoration: InputDecoration(
                                          fillColor: Colors.grey.shade900,
                                          filled: true,
                                          hintStyle:
                                              TextStyle(color: Colors.white),
                                          labelText: 'call ID',
                                          hintText: 'Please Enter Call ID',
                                          labelStyle:
                                              TextStyle(color: Colors.white),
                                          border: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white)),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white)),
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white))),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: MyButton(backgroundcolor: Colors.blue.shade900,function: (){
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        callpage(
                                                          callid:
                                                          Textcontorl
                                                              .text,
                                                        )));
                                          }, text: 'Connect')
                                        ),
                                      ],
                                    ),
                                  )
                                } else ...{
                                  Text(
                                    'Enter your Video call id',
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      style: TextStyle(color: Colors.white),
                                      controller: Textcontorl,
                                      decoration: InputDecoration(
                                          fillColor: Colors.grey.shade900,
                                          filled: true,
                                          hintStyle:
                                          TextStyle(color: Colors.white),
                                          labelText: 'Video ID',
                                          hintText: 'Please Enter Video ID',
                                          labelStyle:
                                          TextStyle(color: Colors.white),
                                          border: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white)),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white)),
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white))),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: MyButton(backgroundcolor: Colors.blue.shade900,function: (){
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          VideoPage(
                                                            callid:
                                                            Textcontorl
                                                                .text,
                                                          )));
                                            }, text: 'Connect')
                                        ),
                                      ],
                                    ),
                                  )
                                },
                                SizedBox(
                                  height: 20.h,
                                ),
                              ],
                            )),
                          ),
                      fallback: (context) => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 600.h,
                              ),
                              Center(
                                child: CircularProgressIndicator(
                                    color: Colors.red),
                              ),
                            ],
                          ))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
