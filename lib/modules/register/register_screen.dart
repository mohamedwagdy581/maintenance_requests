import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maintenance/layout/home_layout.dart';
import 'package:flutter_maintenance/modules/login/login_screen.dart';
import 'package:flutter_maintenance/modules/register/register_cubit/register_cubit.dart';
import 'package:flutter_maintenance/modules/register/register_cubit/register_states.dart';
import 'package:flutter_maintenance/shared/network/cubit/cubit.dart';

import '../../shared/components/components.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  late var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state)
        {
          // Listener in create user success state if success navigate and finish to Home Layout
          if(state is CreateUserSuccessState)
          {
            navigateAndFinish(context, const HomeLayout());
          }
        },
        builder: (context, state)
        {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sign Up',
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline4
                              ?.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        //SizedBox between SignUp Text and Login to Start Text
                        const SizedBox(
                          height: 15.0,
                        ),

                        Text(
                          'Register to start connect with your company',
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(
                            color: Colors.grey,
                          ),
                        ),

                        const SizedBox(
                          height: 30.0,
                        ),

                        // TextFormField of Name
                        defaultTextFormField(
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          label: 'Name',
                          textStyle: Theme.of(context).textTheme.subtitle1?.copyWith(
                            color:
                            AppCubit.get(context).isDark ? Colors.white : Colors.black,
                          ),
                          validator: (String? value) {
                            if(value!.isEmpty)
                            {
                              return 'Please enter your Name';
                            }
                            return null;
                          },
                          prefix: Icons.person,
                        ),

                        //SizedBox between Name and Email Address TextFormField
                        const SizedBox(
                          height: 15.0,
                        ),

                        // TextFormField of Email Address
                        defaultTextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          label: 'Email Address',
                          textStyle: Theme.of(context).textTheme.subtitle1?.copyWith(
                            color:
                            AppCubit.get(context).isDark ? Colors.white : Colors.black,
                          ),
                          validator: (String? value) {
                            if(value!.isEmpty)
                            {
                              return 'Please enter your email address';
                            }
                            return null;
                          },
                          prefix: Icons.email_outlined,
                        ),

                        //SizedBox between Email and Phone TextFormField
                        const SizedBox(
                          height: 15.0,
                        ),

                        // TextFormField of Phone
                        defaultTextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.emailAddress,
                          label: 'Phone',
                          textStyle: Theme.of(context).textTheme.subtitle1?.copyWith(
                            color:
                            AppCubit.get(context).isDark ? Colors.white : Colors.black,
                          ),
                          validator: (String? value) {
                            if(value!.isEmpty)
                            {
                              return 'Please enter your Phone';
                            }
                            return null;
                          },
                          prefix: Icons.phone,
                        ),

                        //SizedBox between Phone and Password TextFormField
                        const SizedBox(
                          height: 15.0,
                        ),

                        // TextFormField of Password
                        defaultTextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          label: 'Password',
                          textStyle: Theme.of(context).textTheme.subtitle1?.copyWith(
                            color:
                            AppCubit.get(context).isDark ? Colors.white : Colors.black,
                          ),
                          validator: (String? value) {
                            if(value!.isEmpty)
                            {
                              return 'Please enter your email address';
                            }
                            return null;
                          },
                          secure: RegisterCubit.get(context).isPasswordShown,
                          prefix: Icons.password,
                          suffix: RegisterCubit.get(context).suffix,
                          suffixPressed: ()
                          {
                            RegisterCubit.get(context).changePasswordVisibility();
                          },
                        ),

                        //SizedBox between Password and Login Button
                        const SizedBox(
                          height: 30.0,
                        ),

                        // Register Button
                        ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          builder: (context) =>
                              defaultButton(
                                onPressed: () {
                                  if(formKey.currentState!.validate())
                                  {
                                    RegisterCubit.get(context).userRegister(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone: phoneController.text,
                                      image: '',
                                    );
                                  }
                                },
                                text: 'Register',
                                backgroundColor:
                                AppCubit.get(context).isDark ? Colors.deepOrange : Colors.blue,
                              ),
                          fallback: (context) =>
                          const Center(child: CircularProgressIndicator()),
                        ),

                        //SizedBox between Login Button and Don't have an account
                        const SizedBox(
                          height: 15.0,
                        ),

                        // Row that contain Don't have an account text and Register TextButton
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Have an account?',
                              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                                color:
                                AppCubit.get(context).isDark ? Colors.white : Colors.black,
                              ),
                            ),
                            defaultTextButton(
                              onPressed: () {
                                navigateAndFinish(
                                  context,
                                  LoginScreen(),
                                );
                              },
                              text: 'Login',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
