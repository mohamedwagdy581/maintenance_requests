import 'package:flutter/material.dart';
import 'package:flutter_maintenance/modules/edit_profile/edit_profile_screen.dart';
import 'package:flutter_maintenance/shared/network/cubit/cubit.dart';
import 'package:flutter_maintenance/style/custom_icons.dart';

import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: ListTile(
              onTap: () {
                navigateTo(context, EditProfileScreen());
              },
              leading: Icon(
                Icons.person,
                color: AppCubit.get(context).isDark ? Colors.deepOrange : Colors.blue,
                size: 35.0,
              ),
              title: const Text(
                'My Account',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Edit your Account',
                style: Theme.of(context).textTheme.caption,
              ),
              trailing: const Icon(CustomIcons.chevron_right),
            ),
          ),

          const SizedBox(
            height: 50.0,
          ),

          // Logout Button
          SizedBox(
            width: 150.0,
            child: defaultButton(
              onPressed: () {
                signOut(context);
              },
              text: 'LOGOUT',
              backgroundColor: AppCubit.get(context).isDark ? Colors.deepOrange : Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
