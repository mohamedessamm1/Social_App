import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Share/cubit/Cubit.dart';
import '../../Share/cubit/States.dart';

class UsersScreen extends  StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit,AppState>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold(
            body: Column(
              children: [
                Text('Users Screen ')
              ],
            ) ,
          );
        },
    );
  }
}
