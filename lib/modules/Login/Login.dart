import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../Share/cubit/Cubit.dart';
import '../../Share/cubit/States.dart';

import '../../Share/componant/Componant.dart';
import '../SignIn/SignUp.dart';
import 'Login_Cubit.dart';
import 'Login_States.dart';

class loginscreen extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  var emailcontrol = TextEditingController();
  var passwordcontrol = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => LoginCubit(),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccesState) {
              Fluttertoast.showToast(
                  msg: "Login successful",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0.sp);
            }
            if (state is LoginErrorState) {
              Fluttertoast.showToast(
                  msg: "Email or Password is Incorect",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0.sp);
            }
          },
          builder: (context, state) {
            return Scaffold(
              backgroundColor: Colors.black,
              body: SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    children: [
                      Stack(
                  children: [
                    Image.asset('assets/images/ground.png'),
                    Column(
                      children: [
                        Form(
                          key: formkey,
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 150.h,
                              right: 30.w,
                              left: 30.w,
                            ),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [

                                Text(
                                  'Free and Always Free not like blue bird',

                                  style: TextStyle(
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Text(
                                  ' Email',
                                  style: TextStyle(
                                      height: 3,
                                      fontSize: 20.sp,
                                      color: Colors.white),
                                ),
                                defaultFormField(
                                  bordercircular: 20.r,
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return 'enter your email';
                                    }
                                    return null;
                                  },
                                  controller: emailcontrol,
                                  type: TextInputType.emailAddress,
                                ),
                                Text(
                                  ' password',
                                  style: TextStyle(
                                      height: 3,
                                      fontSize: 20.sp,
                                      color: Colors.white),
                                ),
                                defaultFormField(
                                  maxlines: 1,
                                  bordercircular: 20.r,
                                  suffixColor:
                                  LoginCubit.get(context).colorr,
                                  isPassword:
                                  LoginCubit.get(context).passvisible,
                                  onSubmit: (value) {},
                                  suffix: LoginCubit.get(context).suffixx,
                                  suffixTab: () {
                                    LoginCubit.get(context).passwordvis();
                                  },
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return 'enter your password';
                                    }
                                    return null;
                                  },
                                  controller: passwordcontrol,
                                  type: TextInputType.visiblePassword,
                                ),
                                SizedBox(
                                  height: 40.h,
                                ),
                                ConditionalBuilder(
                                    condition:
                                    state is! LoginLoadingState,
                                    builder: (context) => defaultButton(
                                      backgroundColor:Colors.blue.shade900,
                                      Texte: 'Login',
                                      function: ()

                                      {
                                        if (formkey.currentState!.validate()) {
                                          LoginCubit.get(context)
                                              .LoginFirebase(
                                              email:
                                              emailcontrol.text,
                                              password:
                                              passwordcontrol
                                                  .text,
                                              context: context);
                                        }


                                      },
                                    ),
                                    fallback: (context) => Center(
                                        child:
                                        CircularProgressIndicator(
                                          color: Colors.blue.shade900,
                                        ))),
                                Padding(
                                  padding:
                                  EdgeInsets.only(top: 5.h, bottom: 80.h),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Don’t have an account? ',
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            color: Colors.white),
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      RegisterScreen(),
                                                ));
                                          },
                                          child: Text(
                                            'Sign In',
                                            style: TextStyle(
                                                fontSize: 16.sp,
                                                color: Colors.blue.shade900,
                                                fontWeight: FontWeight.bold),
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                  ],
              )
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
