import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maintenance/modules/edit_profile/edit_profile_screen.dart';
import 'package:flutter_maintenance/shared/network/cubit/states.dart';
import 'package:flutter_maintenance/style/custom_icons.dart';

import '../shared/components/components.dart';
import '../shared/components/constants.dart';
import '../shared/network/cubit/cubit.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {

        var cubit = AppCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.appBarTitle[cubit.currentIndex]),
          ),
          // **************************  The Drawer  ***************************
          drawer: Drawer(
            child: ListView(
              children: <Widget>[
                // Header
                UserAccountsDrawerHeader(
                  accountName: const Text('Mohamed Wagdy'),
                  accountEmail: const Text('Mohamed@gmail.com'),
                  currentAccountPicture: GestureDetector(
                    child: const CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  decoration: const BoxDecoration(
                      color: Colors.blue,
                  ),
                ),

                // Body
                InkWell(
                  onTap: () {
                    navigateAndFinish(context, const HomeLayout());
                  },
                  child: const ListTile(
                    title: Text(
                        'Home Page',
                    ),
                    leading: Icon(
                      Icons.home,
                      color: Colors.green,
                    ),
                  ),
                ),

                InkWell(
                  onTap: () {
                    navigateTo(context, EditProfileScreen());
                  },
                  child: const ListTile(
                    title: Text('My_Account'),
                    leading: Icon(
                      Icons.person,
                      color: Colors.blue,
                    ),
                  ),
                ),

                const Divider(),

                InkWell(
                  onTap: () {},
                  child: const ListTile(
                    title: Text('About'),
                    leading: Icon(
                      Icons.help,
                      color: Colors.blue,
                    ),
                  ),
                ),

                InkWell(
                  onTap: () {
                    signOut(context);
                  },
                  child: const ListTile(
                    title: Text('Logout'),
                    leading: Icon(
                      Icons.logout_outlined,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ***********************  The Scaffold Body  ***********************
          body: cubit.screens[cubit.currentIndex],

          // Bottom Navigation Bar
          bottomNavigationBar: BottomNavigationBar(
            onTap: (int index)
            {
              cubit.changeBottomNavBar(index);
            },
            items:
            const [
              BottomNavigationBarItem(
                icon: Icon(
                  CustomIcons.home,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  CustomIcons.chat,
                ),
                label: 'Chats',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  CustomIcons.settings,
                ),
                label: 'Settings',
              ),
            ],
            currentIndex: cubit.currentIndex,
          ),
        );
      },
    );
  }
}
