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
          const SizedBox(
            height: 30.0,
          ),
          /*Container(
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
                color: AppCubit.get(context).isDark
                    ? Colors.deepOrange
                    : Colors.blue,
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
          ),*/
          customListTile(
            context: context,
            onTap: ()
            {
              navigateTo(context, EditProfileScreen());
            },
            prefixIcon: Icons.person,
            suffixIcon: CustomIcons.chevron_right,
            title: 'My Account',
            subTitle: 'Edit your Account',
          ),

          const SizedBox(
            height: 30.0,
          ),
          customListTile(
            context: context,
            onTap: ()
            {
              AppCubit.get(context).changeAppModeTheme();
            },
            prefixIcon: Icons.brightness_4_outlined,
            suffixIcon: AppCubit.get(context).isDark
                ? CustomIcons.moon
                : CustomIcons.sun,
            title: AppCubit.get(context).isDark
                ? 'Dark'
                : 'Light',
            subTitle: 'Click to Switch Theme',
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
              backgroundColor: AppCubit.get(context).isDark
                  ? Colors.deepOrange
                  : Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  Widget customListTile({
    required context,
    VoidCallback? onTap,
    required IconData prefixIcon,
    required IconData suffixIcon,
    required String title,
    required String subTitle,
  }) =>
      Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ListTile(
          onTap: onTap,
          leading: Icon(
            prefixIcon,
            color:
                AppCubit.get(context).isDark ? Colors.deepOrange : Colors.blue,
            size: 35.0,
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            subTitle,
            style: Theme.of(context).textTheme.caption,
          ),
          trailing: Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Icon(
                suffixIcon,
              color: AppCubit.get(context).isDark
                  ? Colors.deepOrange
                  : Colors.blue,
            ),
          ),
        ),
      );
}
