import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maintenance/shared/components/components.dart';
import 'package:flutter_maintenance/style/custom_icons.dart';

import '../../shared/network/cubit/cubit.dart';
import '../../shared/network/cubit/states.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> dataStream = FirebaseFirestore.instance.collection('users').snapshots();
    final userData = FirebaseAuth.instance.currentUser;
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
                              child: Stack(
                                alignment: AlignmentDirectional.topEnd,
                                children: [
                                  SizedBox(
                                    height: 150.0,
                                    width: double.infinity,
                                    child: AppCubit.get(context)
                                        .coverImage !=
                                        null
                                        ? Image(
                                      image: FileImage(
                                        AppCubit.get(context)
                                            .coverImage!,
                                      ),
                                      fit: BoxFit.cover,
                                    )
                                        : Image(
                                      image: NetworkImage(
                                          storeDocs.first['cover'],
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      AppCubit.get(context)
                                          .pickCoverImage();
                                    },
                                    icon: const CircleAvatar(
                                      radius: 20.0,
                                      child: Icon(
                                        Icons.camera_alt,
                                        size: 18.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                CircleAvatar(
                                  radius: 64.0,
                                  backgroundColor: Theme.of(context)
                                      .scaffoldBackgroundColor,
                                  child: CircleAvatar(
                                    radius: 60.0,
                                    child: AppCubit.get(context)
                                        .profileImage !=
                                        null
                                        ? CircleAvatar(
                                      radius: 60.0,
                                      backgroundImage: FileImage(
                                          AppCubit.get(context)
                                              .profileImage!),
                                    )
                                        : CircleAvatar(
                                      radius: 60.0,
                                      backgroundImage: NetworkImage(storeDocs.first['image']),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    AppCubit.get(context)
                                        .pickProfileImage();
                                  },
                                  icon: const CircleAvatar(
                                    radius: 20.0,
                                    child: Icon(
                                      Icons.camera_alt,
                                      size: 18.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        'Name : ${userData?.displayName.toString()}',
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 17),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        'Email : ${userData?.email.toString()}',
                        style: Theme.of(context).textTheme.caption?.copyWith(fontSize: 14.0),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Container(
                          padding: const EdgeInsets.only(left: 8.0),
                          alignment: Alignment.centerLeft,
                          child: Text(
                              'History',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Expanded(
                        child: ListView.separated(
                          itemCount: 6,
                            itemBuilder: (context, index) => Container(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: customListTile(
                                onTapped: ()
                                {
                                  print(dataStream.toList());
                                },
                                leadingWidget: Icon(
                                    Icons.history_outlined,
                                  color:
                                  AppCubit.get(context).isDark ? Colors.deepOrange : Colors.blue,
                                ),
                                title: '${userData?.displayName}',
                                trailingWidget: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Icon(
                                      CustomIcons.arrow_right,
                                    color:
                                    AppCubit.get(context).isDark ? Colors.deepOrange : Colors.blue,
                                  ),
                                ),
                              ),
                            ), separatorBuilder: (BuildContext context, int index) => const Divider(),
                            ),
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
