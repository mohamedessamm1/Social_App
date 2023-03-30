import 'package:flutter/material.dart';

import 'modules/settings/Settings.dart';

class login extends  StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(30.0),
      child: Center(
        child: Column(
          children: [
            Text('Sign in ',style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold),),
            SizedBox(
              height: 10,
            ),
            Text('Create an acount',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500),),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text('Email'),
              ],
            ),
            TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                  )
              ),
            ),
            MaterialButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen(),));
            },
              height:70 ,minWidth: 800,
              color: Colors.red,
              child: Text('Sign in'),
              shape:OutlineInputBorder(borderRadius: BorderRadius.circular(40)),

            )
          ],
        ),
      ),
    );
  }
}
