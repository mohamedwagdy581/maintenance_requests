import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
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

  List<UserModel> users = [];
  void getAllUsers ()
  {
    FirebaseFirestore.instance.collection('users').get().then((value)
    {
      value.docs.forEach((element)
      {
        users.add(UserModel.fromJson(element.data()));
        print(users);
        emit(AppGetAllUserSuccessState());
      });
    }).catchError((error)
    {
      print(error.toString());
      emit(AppGetAllUserErrorState(error));
    });
  }


  // ProfilePickedImage
  //XFile? profileImage;
  String profileImageUrl = '';
  void pickUploadProfileImage() async
  {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 75,
    );
    final imagePermanent = await saveImagePermanently(image!.path);
    Reference reference = FirebaseStorage.instance.ref().child('profilepic.jpg');
    await reference.putFile(File(image.path));
    reference.getDownloadURL().then((value)
    {
      profileImageUrl = value;
      CashHelper.saveData(key: profileImage, value: imagePermanent.path);
      print(value);
      emit(AppProfileImagePickedSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(AppProfileImagePickedErrorState());
    });

  }
  // To Store Image in Directory Path
  Future<File> saveImagePermanently(String imagePath) async
  {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');
    return File(imagePath).copy(image.path);
  }

  // Cover Picked image
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
      coverImageUrl = value;
      print(value);
      emit(AppCoverImagePickedSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(AppCoverImagePickedErrorState());
    });

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
