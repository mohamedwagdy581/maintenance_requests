import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maintenance/models/user_model.dart';
import 'package:flutter_maintenance/modules/edit_profile/edit_profile_screen.dart';
import 'package:flutter_maintenance/shared/components/components.dart';

import '../../shared/network/cubit/cubit.dart';
import '../../shared/network/cubit/states.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  late var emailController = TextEditingController();
  late var nameController = TextEditingController();
  late var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = AppCubit.get(context).userModel;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Profile'),
          ),
          body: StreamBuilder<List<UserModel>> (
            stream: AppCubit.get(context).readUsers(),
            builder: (context, snapshot)
            {
              if(snapshot.hasError)
              {
                return Text('Somthing Wrong! ${snapshot.error}');
              }else if(snapshot.hasData)
              {
                final users = snapshot.data;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 190.0,
                        child: Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            Align(
                              alignment: AlignmentDirectional.topCenter,
                              child: Container(
                                height: 140.0,
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                  image: DecorationImage(
                                    image: NetworkImage('https://img.freepik.com/free-photo/indecisive-girl-picks-from-two-choices-looks-questioned-troubled-crosses-hands-across-chest-hesitates-suggested-products-wears-yellow-t-shirt-isolated-crimson-wall_273609-42552.jpg?w=1380'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            CircleAvatar(
                              radius: 64.0,
                              backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                              child: const CircleAvatar(
                                radius: 60.0,
                                backgroundImage: NetworkImage('https://img.freepik.com/free-photo/wow-sale-there-amazed-redhead-girl-pointing-left-being-impressed-by-sale-announcement-showing-logo-standing-tshirt-against-white-background_176420-49239.jpg?t=st=1656577210~exp=1656577810~hmac=cc1cccdcd74eead3c597ae7f55984de886bf8c710457355ac173fc0a9ca3c542&w=1380'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        'userModel!.name!',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        'bio ...',
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                child: Column(
                                  children: [
                                    Text(
                                      '100',
                                      style: Theme.of(context).textTheme.subtitle2,
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      'Posts',
                                      style: Theme.of(context).textTheme.caption,
                                    ),
                                  ],
                                ),
                                onTap: () {},
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                child: Column(
                                  children: [
                                    Text(
                                      '265',
                                      style: Theme.of(context).textTheme.subtitle2,
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      'Photos',
                                      style: Theme.of(context).textTheme.caption,
                                    ),
                                  ],
                                ),
                                onTap: () {},
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                child: Column(
                                  children: [
                                    Text(
                                      '10K',
                                      style: Theme.of(context).textTheme.subtitle2,
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      'Followers',
                                      style: Theme.of(context).textTheme.caption,
                                    ),
                                  ],
                                ),
                                onTap: () {},
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                child: Column(
                                  children: [
                                    Text(
                                      '340',
                                      style: Theme.of(context).textTheme.subtitle2,
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      'Followings',
                                      style: Theme.of(context).textTheme.caption,
                                    ),
                                  ],
                                ),
                                onTap: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {},
                              child: const Text('Add Photos'),
                            ),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          OutlinedButton(
                            onPressed: ()
                            {
                              navigateTo(context, EditProfileScreen());
                            },
                            child: const Icon(Icons.edit),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }else
              {
                return const Center(child: CircularProgressIndicator(),);
              }
            },
          ),
        );
      },
    );
  }
}
