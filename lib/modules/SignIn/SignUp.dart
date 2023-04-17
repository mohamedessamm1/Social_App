
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../Share/componant/Componant.dart';
import '../Login/Login.dart';
import 'Signup_Cubit.dart';
import 'Signup_States.dart';


class RegisterScreen extends  StatelessWidget {
  var formkey = GlobalKey<FormState>();
  var emailcontrol = TextEditingController();
  var passwordcontrol = TextEditingController();
  var namecontorl = TextEditingController();
  var phonecontrol = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SignCubit(),
        child: BlocConsumer<SignCubit, SignStates>(
          listener: (context, state) {
            if(state is SignRegisterSuccessState){
              Fluttertoast.showToast(
                  msg: "SignUp successful",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0.sp
              );
            }
            if(state is SignRegistrerrorState){
              Fluttertoast.showToast(
                  msg: "Email Format is Incorect",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0.sp
              );
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
                              SizedBox(height: 140.h,),
                              Form(
                                key: formkey,
                                child: Padding(
                                  padding:  EdgeInsets.symmetric(horizontal: 25.w),
                                  child: Column(
                                    children: [

                                      // NAME FIELD///////////////////////////////////////////////////
                                      Row(
                                        children: [
                                          Text(
                                            '   Name',
                                            style: TextStyle(

                                                fontSize: 20.sp,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),

                                      defaultFormField(
                                        bordercircular: 10.r,
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return 'enter your name';
                                          }
                                          return null;
                                        },
                                        controller: namecontorl,
                                        type: TextInputType.name,
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      //EMAIL FIELD////////////////////////////////////////////////////
                                      Row(
                                        children: [
                                          Text(
                                            '   Email',
                                            style: TextStyle(
                                                fontSize: 20.sp,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),

                                      defaultFormField(
                                        bordercircular: 10.r,
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return 'enter your email';
                                          }
                                          return null;
                                        },
                                        controller: emailcontrol,
                                        type: TextInputType.emailAddress,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      //PASSWORD FIELD//////////////////////////////////////////
                                      Row(
                                        children: [
                                          Text(
                                            '   password',
                                            style: TextStyle(
                                                fontSize: 20.sp,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),

                                      defaultFormField(
                                        maxlines: 1,
                                        suffixColor: SignCubit.get(context).colorr,
                                        bordercircular: 10.r,
                                        isPassword:
                                        SignCubit.get(context).passvisible,

                                        suffix: SignCubit.get(context).suffixx,
                                        suffixTab: () {
                                          SignCubit.get(context).passwordvis();
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
                                      // PHONE FIELD//////////////////////////////////////////////
                                      const SizedBox(
                                        height: 20,
                                      ),

                                      Row(
                                        children: [
                                          Text(
                                            '   Phone',
                                            style: TextStyle(
                                                fontSize: 20.sp,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),

                                      defaultFormField(

                                        bordercircular: 10.r,
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return 'enter your phone';
                                          }
                                          return null;
                                        },
                                        controller: phonecontrol,
                                        type: TextInputType.phone,
                                      ),
                                      SizedBox(
                                        height: 50.h,
                                      ),

                                      ConditionalBuilder(
                                          condition: state is! SiginRegisterLoadingState,
                                          builder: (context) => defaultButton(
                                            backgroundColor: Colors.blue.shade900,

                                            Texte: 'Sign Up',
                                            function: () {
                                              if (formkey.currentState!.validate()) {
                                                SignCubit.get(context).SigninFirebase(
                                                    name: namecontorl.text,
                                                    email: emailcontrol.text,
                                                    pass: passwordcontrol.text,
                                                    context: context,
                                                    phone: phonecontrol.text
                                                );
                                              }


                                            },
                                          ),
                                          fallback: (context) =>  Center(
                                              child: CircularProgressIndicator(color: Colors.blue.shade900,))),
                                      SizedBox(
                                        height: 30.h,
                                      ),

                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'have an account? ',
                                            style: TextStyle(
                                                fontSize: 15.sp,
                                                color: Colors.grey),
                                          ),
                                          TextButton(
                                              onPressed: () {
                                                {
                                                  Navigator.pushReplacement(
                                                    context,
                                                    PageRouteBuilder(
                                                      pageBuilder:
                                                          (_, __, ___) =>
                                                          loginscreen(),
                                                      transitionDuration:
                                                      const Duration(
                                                          milliseconds:
                                                          300),
                                                      transitionsBuilder:
                                                          (_, a, __, c) =>
                                                          FadeTransition(
                                                              opacity: a,
                                                              child: c),
                                                    ),
                                                  );
                                                }
                                                ;
                                              },
                                              child: Text(
                                                'Login',
                                                style: TextStyle(
                                                    fontSize: 16.sp,
                                                    color: Colors.blue.shade900,
                                                    fontWeight:
                                                    FontWeight.bold),
                                              )),
                                        ],
                                      ),

                                      // const Spacer()
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
