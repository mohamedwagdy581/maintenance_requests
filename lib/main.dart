import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maintenance/layout/home_layout.dart';
import 'package:flutter_maintenance/shared/components/constants.dart';
import 'package:flutter_maintenance/shared/network/cubit/cubit.dart';
import 'package:flutter_maintenance/shared/network/cubit/states.dart';
import 'package:flutter_maintenance/shared/network/local/cash_helper.dart';
import 'package:flutter_maintenance/shared/network/remote/dio_helper.dart';
import 'package:flutter_maintenance/splash_screen.dart';
import 'package:flutter_maintenance/style/themes.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  DioHelper.init();
  await CashHelper.init();
  bool? isDark = CashHelper.getData(key: 'isDark');
  profileImage = CashHelper.getData(key: 'imagePath');

  Widget widget;
  uId = CashHelper.getData(key: 'uId');

  if(uId != null)
  {
    widget = const HomeLayout();
  }else
  {
    widget = const SplashScreen();
  }

  runApp(MyApp(
    isDark: isDark,
    loadImage: profileImage,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final String? loadImage;
  final Widget startWidget;

  const MyApp({
    super.key,
    required this.isDark,
    required this.loadImage,
    required this.startWidget,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..getUserData()..changeAppModeTheme(fromShared: isDark,)..getAllUsers(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {},
        builder: (BuildContext context, AppStates state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}
