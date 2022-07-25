import 'package:flutter/material.dart';
import 'package:flutter_maintenance/style/custom_icons.dart';

import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../profile/profile_screen.dart';

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
                navigateTo(context, ProfileScreen());
              },
              leading: const Icon(
                Icons.person,
                color: Colors.blue,
                size: 35.0,
              ),
              title: Text(
                'My_Account',
                style: Theme.of(context).textTheme.bodyText1,
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
            ),
          ),
        ],
      ),
    );
  }
}
