import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maintenance/models/user_model.dart';
import 'package:flutter_maintenance/shared/components/components.dart';
import 'package:flutter_maintenance/shared/network/cubit/cubit.dart';
import 'package:flutter_maintenance/shared/network/cubit/states.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state)
      {

        var cubit = AppCubit.get(context);
        var user = FirebaseAuth.instance;

        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => buildChatItem(context, user.currentUser?.displayName,/*cubit.users[index]*/),
          separatorBuilder: (context, index) => const Divider(thickness: 2.0,),
          itemCount: 10,
        );

          /*ConditionalBuilder(
          condition: cubit.users.length > 0,
          builder: (context) => ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildChatItem(context, cubit.users[index]),
            separatorBuilder: (context, index) => const Divider(thickness: 2.0,),
            itemCount: cubit.users.length,
          ),
          fallback: (context) => const Center(child: CircularProgressIndicator()),
        );*/
      },
    );
  }

  Widget buildChatItem(context,user,/* UserModel userModel*/) => InkWell(
    onTap: ()
    {
      print(AppCubit.get(context).users.first);
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children:
        [
          const CircleAvatar(
            radius: 25.0,
            backgroundImage: NetworkImage('https://icons-for-free.com/iconfiles/png/512/person-1324760545186718018.png'),
          ),
          const SizedBox(
            width: 15.0,
          ),
          Text(
            '${user}',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          defaultTextButton(onPressed: ()
          {
            print(AppCubit.get(context).userModel?.email);
            //print(userModel.name);
          }, text: 'test')
        ],
      ),
    ),
  );
}
