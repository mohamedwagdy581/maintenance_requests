import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_maintenance/models/user_model.dart';
import 'package:flutter_maintenance/modules/chat/chat_screen.dart';
import 'package:flutter_maintenance/modules/request_order/request_order_screen.dart';
import 'package:flutter_maintenance/modules/settings/settings_screen.dart';
import 'package:flutter_maintenance/shared/components/constants.dart';
import 'package:flutter_maintenance/shared/network/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_maintenance/shared/network/local/cash_helper.dart';
import 'package:image_picker/image_picker.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  // Get context to Easily use in a different places in all Project
  static AppCubit get(context) => BlocProvider.of(context);

  // List of AppBar Title
  List<String> appBarTitle = const [
    'Home',
    'Chat',
    'Settings',
  ];

  // Change BottomNavigationBar index
  int currentIndex = 0;
  List<Widget> screens = const [
    RequestOrderScreen(),
    ChatScreen(),
    SettingsScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavigationBarState());
  }

  UserModel? userModel;

  void getUserData() {
    emit(AppGetUserLoadingState());

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = UserModel.fromJson(value.data()!);
      emit(AppGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(AppGetUserErrorState(error.toString()));
    });
  }

  File? profileImage;

  Future pickProfileImage() async {
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
        maxHeight: 512,
        maxWidth: 512,
        imageQuality: 75,
      );
      Reference reference = FirebaseStorage.instance.ref().child('profilepic.jpg');
      if (image == null) {
        print('No Image Selected!');
        emit(AppProfileImagePickedErrorState());
        return;
      } else {
        await reference.putFile(File(image.path));
        reference.getDownloadURL().then((value)
        {
          print(value);
        });
        final imageTemporary = File(image.path);
        profileImage = imageTemporary;
        emit(AppProfileImagePickedSuccessState());
      }
    } on PlatformException catch (error) {
      print('Failed to pick image ${error.toString()}');
    }
  }

  File? coverImage;

  Future pickCoverImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        print('No Image Selected!');
        emit(AppCoverImagePickedErrorState());
        return;
      } else {
        final imageTemporary = File(image.path);
        coverImage = imageTemporary;
        emit(AppCoverImagePickedSuccessState());
      }
    } on PlatformException catch (error) {
      print('Failed to pick image ${error.toString()}');
    }
  }

  // Function to Change Theme mode
  bool isDark = false;

  void changeAppModeTheme({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeThemeState());
    } else {
      isDark = !isDark;
      CashHelper.setBoolean(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeThemeState());
      });
    }
  }
}


/*
String coverImageUrl = '';
  void pickUploadCoverImage() async
  {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 75,
    );
    Reference reference = FirebaseStorage.instance.ref().child('coverpic.jpg');
    await reference.putFile(File(image!.path));
    reference.getDownloadURL().then((value)
    {
      profileImageUrl = value;
      print(value);
      emit(AppCoverImagePickedSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(AppCoverImagePickedErrorState());
    });

  }
*/
