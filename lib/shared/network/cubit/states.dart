abstract class AppStates {}

// App Initial State
class AppInitialState extends AppStates {}

// Change BottomNavigationBar State
class AppChangeBottomNavigationBarState extends AppStates {}

// App Get User State
class AppGetUserLoadingState extends AppStates {}

class AppGetUserSuccessState extends AppStates {}

class AppGetUserErrorState extends AppStates
{
  final String error;

  AppGetUserErrorState(this.error);
}

// Change Mode Theme of App
class AppChangeModeThemeState extends AppStates {}

// Change CityDropDown State
class AppChangeCityDropDownState extends AppStates {}

// Profile Image Picked States
class AppProfileImagePickedSuccessState extends AppStates {}

class AppProfileImagePickedErrorState extends AppStates {}

// Cover Image Picked States
class AppCoverImagePickedSuccessState extends AppStates {}

class AppCoverImagePickedErrorState extends AppStates {}
