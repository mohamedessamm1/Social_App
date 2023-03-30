import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Share/cubit/Cubit.dart';
import '../../Share/cubit/States.dart';


class ChatsScreen extends  StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit,AppState>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold(
            backgroundColor: Colors.black,
            body: Column(
              children: [
                Text('chat screen')
              ],
            ) ,
          );
        },
    );
  }
}
