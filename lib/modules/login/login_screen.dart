import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maintenance/shared/network/cubit/cubit.dart';
import 'package:flutter_maintenance/shared/network/local/cash_helper.dart';

import '../../layout/home_layout.dart';
import '../../shared/components/components.dart';
import '../register/register_screen.dart';
import 'login_cubit/login_cubit.dart';
import 'login_cubit/login_states.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  late var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state)
        {
          // Listener in Login State if Error Show toast with error
          if(state is LoginErrorState)
          {
            showToast(
              message: state.error,
              state: ToastStates.ERROR,
            );
          }
          // Listener in Login state if success save uId in CacheHelper and navigate to HomeLayout
          if(state is LoginSuccessState)
          {
            // CacheHelper to save token or Authorization and navigate and finish to the main home screen
            CashHelper.saveData(
              key: 'uId',
              value: state.uId,
            ).then((value) {

              navigateAndFinish(
                context,
                const HomeLayout(),
              );
            });
          }
        },
        builder: (context, state) {
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
                      // Login main text in the screen
                      children: [
                        Text(
                          'Login',
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline4
                              ?.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        //SizedBox between Login Text and Login to Start Text
                        const SizedBox(
                          height: 15.0,
                        ),

                        // subtitle login in the screen
                        Text(
                          'Login to start connect with your company',
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 50.0,
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

                        //SizedBox between Email and Password TextFormField
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
                          secure: LoginCubit.get(context).isPasswordShown,
                          prefix: Icons.password,
                          suffix: LoginCubit.get(context).suffix,
                          suffixPressed: ()
                          {
                            LoginCubit.get(context).changePasswordVisibility();
                          },
                        ),
                        //SizedBox between Password and Login Button
                        const SizedBox(
                          height: 30.0,
                        ),

                        // Login Button
                        ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder: (context) =>
                              defaultButton(
                                onPressed: () {
                                  if(formKey.currentState!.validate())
                                  {
                                    LoginCubit.get(context).userLogin(
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                    );
                                  }
                                },
                                text: 'Login',
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
                              'Don\'t have an account?',
                              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                                color:
                                AppCubit.get(context).isDark ? Colors.white : Colors.black,
                              ),
                            ),
                            defaultTextButton(
                              onPressed: () {
                                navigateAndFinish(
                                  context,
                                  RegisterScreen(),
                                );
                              },
                              text: 'REGISTER',
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
