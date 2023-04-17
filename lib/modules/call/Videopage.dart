import 'dart:math';

import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class VideoPage extends  StatelessWidget {
  final callid ;
  VideoPage({
    this.callid
  });
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
        body:  ZegoUIKitPrebuiltCall(
            appID: 1818420364, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
            appSign: '9526835a452a694c7a0f498952547ec145c4d68347a0768d3d03cb31c90141f6', // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
            userID: userid,
            userName: username,
            callID: callid,
            // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
            config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()

        )
    );
  }
}
String userid = Random().nextInt(10095000).toString();
String username = Random().nextInt(10095000).toString();