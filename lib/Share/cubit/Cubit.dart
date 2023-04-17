import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:social/Share/Cache_Helper/CacheHelper.dart';
import 'package:social/Share/constants/constants.dart';
import 'package:social/models/AddPostModel.dart';
import 'package:social/models/UserCreateModel.dart';
import 'package:social/models/message_model.dart';
import 'package:social/modules/SignIn/Signup_Cubit.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:social/modules/call/callpage.dart';

import '../../modules/call/callscreen.dart';
import '../../modules/chat/chats_screen1.dart';
import '../../modules/home/HomeScreen.dart';
import '../../modules/settings/Settings.dart';
import 'States.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  void GetUserData() {
    emit(GetUserDataLoadingState());
    FirebaseFirestore.instance
        .collection('user')
        .doc(CacheHelper.getdata(key: 'uid').toString())
        .get()
        .then((value) {
      userModel = CreateUserModel.fromjson(value.data());
      print(userModel?.uid);
      print(userModel?.image);
      print(userModel?.bio);
      print(userModel?.email);

      emit(GetUserDataState());
    }).catchError((error) {
      emit(GetUserDataErrorState());
    });
  }

  List posts = [];
  List<String> PostId = [];
  List<int> Likes = [];

  LISTzero() {
    Likes = [];
    emit(ListZeroState());
  }

  int Currentindex = 0;

  ChangeBottomNav(index) {
    if (index == 1)
    {
      GetAllUsersData();

    }
    Currentindex = index;
    emit(ChangeBottomNavState());
  }

  List<Widget> screens = [
    const HomeScreen(),
    const ChatsScreen1(),
     callscreen(),
    const SettingsScreen(),
  ];
  File? profileImage;
  final ImagePicker profilepicker = ImagePicker();

  Future PickImage() async {
    final pickfile = await profilepicker.pickImage(source: ImageSource.gallery);
    if (pickfile != null) {
      profileImage = File(pickfile.path);
      UploadProfileImage();

      emit(PickProfileSuccesState());
    } else {
      print('no image ');
      emit(PickProfileErrorState());
    }
  }

  File? PostImag;
  final ImagePicker PostPick = ImagePicker();

  Future PostImage() async {
    final pickPostfile = await PostPick.pickImage(source: ImageSource.gallery);
    if (pickPostfile != null) {
      PostImag = File(pickPostfile.path);
      await UploadPostImage();
      emit(PickPostImageSuccesState());
    } else {
      print('no post iamge ');
      emit(PickPostImageErrorState());
    }
  }

  String? POSTIMAGE;

  UploadPostImage() {
    emit(UploadPostImageLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('image/${Uri.file(PostImag!.path).pathSegments.last}')
        .putFile(PostImag!)
        .then((value) {
      value.ref.getDownloadURL().then((valuee) {
        POSTIMAGE = valuee;
        print(POSTIMAGE);
      });
      emit(UploadPostImageSuccessState());
    }).catchError((Error) {
      emit(UploadPostImageErrorState());
    });
  }

  CancelPostImage() {
    PostImag = null;
    POSTIMAGE = null;
    emit(RemovePostImageSuccessState());
  }

  File? CoverImage;
  final ImagePicker CoverPick = ImagePicker();

  Future PickCover() async {
    final pickCoverfile =
        await CoverPick.pickImage(source: ImageSource.gallery);
    if (pickCoverfile != null) {
      CoverImage = File(pickCoverfile.path);
      await UploadCoverImage();
      emit(PickCoverSuccesState());
    } else {
      print('no cover ');
      emit(PickCoverErrorState());
    }
  }

  String? NewProfileImage;
  String? NewCoverImage;

  UploadProfileImage() {
    emit(UploadProfileImageLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('image/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        NewProfileImage = value.toString();
        print(value.toString());
      });
      emit(UploadProfileImageSuccessState());
    }).catchError((Error) {
      emit(UploadProfileImageErrorState());
    });
  }

  UploadCoverImage() {
    emit(UploadCoverImageLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('image/${Uri.file(CoverImage!.path).pathSegments.last}')
        .putFile(CoverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        NewCoverImage = value.toString();

        print(value.toString());
      });
      emit(UploadCoverImageSuccessState());
    }).catchError((Error) {
      emit(UploadCoverImageErrorState());
    });
  }

  UpdateUserData({
    image,
    cover,
    bio,
    name,
    phone,
  }) {
    emit(UpdateUserDataLoadingState());
    FirebaseFirestore.instance.collection('user').doc(CacheHelper.getdata(key: 'uid').toString()).update({
      'ImageBackGround': NewCoverImage ?? userModel?.ImageBackGround,
      'image': NewProfileImage ?? userModel?.image,
      'bio': bio ?? userModel?.bio,
      'name': name ?? userModel?.name,
      'phone': phone ?? userModel?.phone,
    }).then((value) {
      print('updated');
      GetUserData();
    }).catchError((error) {
      emit(UpdateUserDataErrorState());
    });
  }

  CoverImagee() {
    CoverImage == null
        ? NetworkImage(
            '${userModel?.ImageBackGround}',
          )
        : FileImage(File(CoverImage!.path)) as ImageProvider;
  }

  CancelSettings() {
    CoverImage = null;
    profileImage = null;
    emit(RemoveSettingsSuccessState());
  }

  UpdateUserDataName({
    name,
  }) {
    emit(UpdateUserNameDataLoadingState());
    FirebaseFirestore.instance.collection('user').doc(CacheHelper.getdata(key: 'uid').toString()).update({
      'ImageBackGround': userModel?.ImageBackGround,
      'image': userModel?.image,
      'bio': userModel?.bio,
      'name': name ?? userModel?.name,
      'phone': userModel?.phone,
    }).then((value) {
      print('updated');
      GetUserData();
    }).catchError((error) {
      emit(UpdateUserNameDataErrorState());
    });
  }

  UpdateUserDataBio({
    bio,
  }) {
    emit(UpdateUserBioDataLoadingState());
    FirebaseFirestore.instance.collection('user').doc(CacheHelper.getdata(key: 'uid').toString()).update({
      'ImageBackGround': userModel?.ImageBackGround,
      'image': userModel?.image,
      'bio': bio ?? userModel?.bio,
      'name': userModel?.name,
      'phone': userModel?.phone,
    }).then((value) {
      print('updated');
      GetUserData();
    }).catchError((error) {
      emit(UpdateUserBioDataErrorState());
    });
  }

  UpdateUserDataPhone({
    phone,
  }) {
    emit(UpdateUserPhoneDataLoadingState());
    FirebaseFirestore.instance.collection('user').doc(CacheHelper.getdata(key: 'uid').toString()).update({
      'ImageBackGround': userModel?.ImageBackGround,
      'image': userModel?.image,
      'bio': userModel?.bio,
      'name': userModel?.name,
      'phone': phone ?? userModel?.phone,
    }).then((value) {
      print('updated');
      GetUserData();
    }).catchError((error) {
      emit(UpdateUserPhoneDataErrorState());
    });
  }

  AddMyPostWithImage({MyText}) {
    emit(PostAddedWithImageLoadingState());
    AddPostModel addPostModel = AddPostModel(
      MyImage: userModel?.image,
      MyName: userModel?.name,
      MyText: MyText,
      PostImage: POSTIMAGE,
      Time: DateTime.now().toString(),
      uid: GLOBALuid,
        postindex: DateTime.now().microsecondsSinceEpoch,
    );
    FirebaseFirestore.instance
        .collection('post')
        .add(addPostModel.tojson())
        .then((value) {
      print('post added with image');
      POSTIMAGE = null;
      emit(PostAddedWithImageSuccessState());
    }).catchError((error) {
      emit(PostAddedWithImageErrorState());
    });
  }

  AddMyPost({MyText}) {
    emit(PostAddedLoadingState());
    AddPostModel addPostModel = AddPostModel(
        MyImage: userModel?.image,
        MyName: userModel?.name,
        MyText: MyText,
        Time: DateTime.now().toString(),
        uid: CacheHelper.getdata(key: 'uid').toString(),
        postindex: DateTime.now().microsecondsSinceEpoch);
    FirebaseFirestore.instance
        .collection('post')
        .add(addPostModel.tojson())
        .then((value) {
      print('post added ');
      emit(PostAddedSuccessState());
    }).catchError((error) {
      emit(PostAddedErrorState());
    });
  }

  int year = DateTime.now().year;
  int month = DateTime.now().month;
  int day = DateTime.now().day;
  int hour = DateTime.now().hour;
  int minute = DateTime.now().minute;
  DateTime time = DateTime.now();

  // tim() {
  //   // String x = Jiffy.now().jm;
  //   emit(UpdateTimeAddPostState());
  //   return x;
  // }

  Future PostLike(postid) async {
    await FirebaseFirestore.instance
        .collection('post')
        .doc(postid)
        .collection('like')
        .doc(userModel?.uid)
        .set({'like': true}).then((value) {
      emit(PostLikeSuccessState());
      print(Likes);
      print('likes');
    }).catchError((error) {
      emit(PostLikeErrorState());
    });
  }

  List<CreateUserModel> users = [];

  Future<void>? GetPosts()  {
    Likes.clear();
    emit(GetPostsLoadingState());
     FirebaseFirestore.instance
        .collection('post')
        .orderBy('Time',descending: true)
        .get()
        .then((value) {
      posts = value.docs.map((element) => element.data()).toList();
      PostId = value.docs.map((element) => element.id).toList();
      value.docs.forEach(
          (element) => element.reference.collection('like').get().then((value) {
            
                Likes.add(value.docs.length);
                print(Likes);

                emit(GetPostLikeSuccessState());
              }).catchError((error) {
                emit(GetPostLikeErrorState());
              }));
      emit(GetPostsState());

    }).catchError((error) {
      emit(GetPostsErrorState());
    });
  }


  Future<void>? DeletePost(postid)  {
    emit(DeletePostsLoadingState());
    FirebaseFirestore.instance
        .collection('post').
    doc(postid)
        .delete()
        .then((value) {

      emit(DeletePostsState());
      GetPosts();

    }).catchError((error) {
      emit(DeletePostsErrorState());
    });
  }

// List ?x;
  // GetLikes(postid) async {
  //   emit(GetPostsLoadingState());
  //   await FirebaseFirestore.instance
  //       .collection('post')
  //  .doc(postid).collection('like').get()
  //       .then((value) {
  //         x = value.docs;
  //
  //
  //
  //     emit(GetPostLikeSuccessState());
  //   }).catchError((error) {
  //     emit(GetPostLikeErrorState());
  //   });
  //   return          x;
  //
  // }

  GetAllUsersData() {
    emit((GetAllUsersDataLoadingState()));
    users.clear();
      FirebaseFirestore.instance.collection('user').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uid'] != userModel?.uid) {
            users.add(CreateUserModel.fromjson(element.data()));
          }
        });
        emit((GetAllUsersDataState()));
      }).catchError((error) {
        emit((GetAllUsersDataErrorState()));
      });

  }

  sendMessage({
    required DateTime,
    required Text,
    required ReceiverId,
  }) {
    MessageModel messageModel = MessageModel(
      DateTime: DateTime,
      SenderId: userModel?.uid,
      Text: Text,
      ReceiverId: ReceiverId,
    );
    FirebaseFirestore.instance
        .collection('user')
        .doc(userModel?.uid)
        .collection('chat')
        .doc(ReceiverId)
        .collection('message')
        .add(messageModel.tojson())
        .then((value) {
      emit(SuccessSendMessageState());
      print('send succes');
    }).catchError((Error) {
      emit(ErrorSendMessageState());
    });

    FirebaseFirestore.instance
        .collection('user')
        .doc(ReceiverId)
        .collection('chat')
        .doc(userModel?.uid)
        .collection('message')
        .add(messageModel.tojson())
        .then((value) {
      emit(SuccessSendMessageState());
    }).catchError((Error) {
      emit(ErrorSendMessageState());
    });
  }

  List<MessageModel> ChatMessage = [];
  GetMessage({
    required ReceiverId,
  }) {
    FirebaseFirestore.instance
        .collection('user')
        .doc(userModel?.uid)
        .collection('chat')
        .doc(ReceiverId)
        .collection('message')
        .orderBy('DateTime')
        .snapshots()
        .listen((event) {
      ChatMessage = [];
      event.docs.forEach((element) {
        ChatMessage.add(MessageModel.fromjson(element.data()));
      });
      emit(SuccessMessageState());
    });
  }
  ScrollController scrollController = ScrollController();

   getScroll() async{


    SchedulerBinding.instance.addPostFrameCallback((_) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    });
emit(SuccessScrollState());
  }
  int buttn=0;
  buttontoggle(changebutton){
     buttn=changebutton;
     emit(SuccesButtonChangeState());
  }





}
