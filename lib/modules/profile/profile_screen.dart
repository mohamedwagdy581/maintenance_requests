import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maintenance/modules/edit_profile/edit_profile_screen.dart';
import 'package:flutter_maintenance/shared/components/components.dart';

import '../../shared/network/cubit/cubit.dart';
import '../../shared/network/cubit/states.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> dataStream = FirebaseFirestore.instance.collection('users').snapshots();
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Profile'),
          ),
          body: StreamBuilder<QuerySnapshot> (
            stream: dataStream,
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot)
            {
              if(snapshot.hasError)
              {
                return Text('Something Wrong! ${snapshot.error}');
              }else if(snapshot.hasData)
              {
                final List storeDocs = [];
                snapshot.data!.docs.map((DocumentSnapshot documentSnapshot)
                {
                  Map users = documentSnapshot.data() as Map<String, dynamic>;
                  storeDocs.add(users);
                  users['uId'] = documentSnapshot.id;
                }).toList();
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
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                  image: DecorationImage(
                                    image: NetworkImage(storeDocs.first['cover']),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            CircleAvatar(
                              radius: 64.0,
                              backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60.0,
                                backgroundImage: NetworkImage(storeDocs.first['image']),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        storeDocs.first['name'],
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        storeDocs.first['bio'],
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
