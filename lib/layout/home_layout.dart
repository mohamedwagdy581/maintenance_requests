import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maintenance/modules/profile/profile_screen.dart';
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
        var user = FirebaseAuth.instance.currentUser;

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
                  accountName: Text('${user!.displayName}'),
                  accountEmail: Text('${user.email}'),
                  currentAccountPicture: cubit.profileImageUrl == ''
                      ? Image.network('https://icons-for-free.com/iconfiles/png/512/person-1324760545186718018.png')
                      : CircleAvatar(
                      backgroundImage: NetworkImage(
                          cubit.profileImageUrl,
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
                    navigateTo(context, const ProfileScreen());
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
                  onTap: ()
                  {},
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
