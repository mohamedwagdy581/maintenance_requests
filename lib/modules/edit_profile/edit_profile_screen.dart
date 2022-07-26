
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maintenance/shared/components/components.dart';
import 'package:flutter_maintenance/shared/network/cubit/states.dart';
import 'package:flutter_maintenance/style/custom_icons.dart';

import '../../shared/network/cubit/cubit.dart';

// ignore: must_be_immutable
class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  late var emailController = TextEditingController();
  late var nameController = TextEditingController();
  late var phoneController = TextEditingController();
  late var bioController = TextEditingController();
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

/*  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      emailController.text = documentSnapshot['email'];
      nameController.text = documentSnapshot['name'];
      phoneController.text = documentSnapshot['phone'];
      bioController.text = documentSnapshot['bio'];
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, AppStates state) {},
      builder: (BuildContext context, AppStates state) {
        //var userModel = AppCubit.get(context).userModel;
        //var profileImage = AppCubit.get(context).profileImage;
        final Stream<QuerySnapshot> dataStream =
            FirebaseFirestore.instance.collection('users').snapshots();

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Edit Profile',
            ),
          ),
          body: StreamBuilder<QuerySnapshot>(
            stream: dataStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something Wrong! ${snapshot.error}');
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                final DocumentSnapshot documentSnapshot =
                    snapshot.data!.docs.first;
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: formKey,
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
                                      Container(
                                        height: 140.0,
                                        width: double.infinity,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(4.0),
                                            topRight: Radius.circular(4.0),
                                          ),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                'https://img.freepik.com/free-photo/indecisive-girl-picks-from-two-choices-looks-questioned-troubled-crosses-hands-across-chest-hesitates-suggested-products-wears-yellow-t-shirt-isolated-crimson-wall_273609-42552.jpg?w=1380'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {},
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
                                        child:
                                            AppCubit.get(context).image != null
                                                ? CircleAvatar(
                                                    radius: 60.0,
                                                    backgroundImage: FileImage(AppCubit.get(context).image!),
                                                  )
                                                : const FlutterLogo(),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        AppCubit.get(context).pickImage();
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
                            height: 20.0,
                          ),
                          defaultTextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            label: 'Email',
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Email must not be empty';
                              }
                              return null;
                            },
                            prefix: CustomIcons.user,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          defaultTextFormField(
                            controller: nameController,
                            keyboardType: TextInputType.name,
                            label: 'Name',
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Name must not be empty';
                              }
                              return null;
                            },
                            prefix: CustomIcons.user,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          defaultTextFormField(
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            label: 'Phone',
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Phone must not be empty';
                              }
                              return null;
                            },
                            prefix: Icons.phone,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          defaultTextFormField(
                            controller: bioController,
                            keyboardType: TextInputType.name,
                            label: 'Bio',
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Bio must not be empty';
                              }
                              return null;
                            },
                            prefix: Icons.info_outline_rounded,
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          defaultButton(
                            onPressed: () async {
                              final String name = nameController.text;
                              final String email = emailController.text;
                              final String phone = phoneController.text;
                              final String bio = bioController.text;

                              await users.doc(documentSnapshot.id).update({
                                'name': name,
                                'email': email,
                                'phone': phone,
                                'bio': bio,
                              });
                              nameController.text = '';
                              emailController.text = '';
                              phoneController.text = '';
                              bioController.text = '';
                              showToast(
                                message: 'Updated Successfully',
                                state: ToastStates.SUCCESS,
                              );
                            },
                            text: 'Update',
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }
}
/*
AppCubit.get(context).image !=
null
? Image.file(
AppCubit.get(context).image!,
fit: BoxFit.cover,
width: 100,
height: 100,
)
: const FlutterLogo(),*/
