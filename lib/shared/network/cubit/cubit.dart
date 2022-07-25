import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_maintenance/models/user_model.dart';
import 'package:flutter_maintenance/modules/chat/chat_screen.dart';
import 'package:flutter_maintenance/modules/request_order/request_order_screen.dart';
import 'package:flutter_maintenance/modules/settings/settings_screen.dart';
import 'package:flutter_maintenance/shared/components/constants.dart';
import 'package:flutter_maintenance/shared/network/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';


class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super(AppInitialState());

  // Get context to Easily use in a different places in all Project
  static AppCubit get(context) => BlocProvider.of(context);

  // List of AppBar Title
  List<String> appBarTitle = const
  [
    'Home',
    'Chat',
    'Settings',
  ];

  // Change BottomNavigationBar index
  int currentIndex = 0;
  List<Widget> screens = const
  [
    RequestOrderScreen(),
    ChatScreen(),
    SettingsScreen(),
  ];
  void changeBottomNavBar (int index)
  {
    currentIndex = index;
    emit(AppChangeBottomNavigationBarState());
  }

  // Change City DropDown menu
  int cityIndex = 1;
  List<String> city = const
  [
    'Jazan',
    'Sabia',
    'Jeddah',
    'Riyadh',
  ];
  void changeCityDropDown (int index)
  {
    cityIndex = index;
    emit(AppChangeCityDropDownState());
  }

  UserModel? userModel;
  void getUserData ()
  {
    emit(AppGetUserLoadingState());

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value)
    {
      userModel = UserModel.fromJson(value.data()!);
      emit(AppGetUserSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(AppGetUserErrorState(error.toString()));
    });
  }

  File? profileImage;
  final ImagePicker picker = ImagePicker();

  Future getProfileImage() async
  {
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery,);

    if(pickedFile != null)
    {
      profileImage = File(pickedFile.path);
      emit(AppProfileImagePickedSuccessState());
    }else
    {
      print('No Image Selected!');
      emit(AppProfileImagePickedErrorState());
    }
  }

}