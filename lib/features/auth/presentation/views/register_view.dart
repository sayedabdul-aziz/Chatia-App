import 'package:chatia/core/utils/cache_helper.dart';
import 'package:chatia/core/utils/extensions.dart';
import 'package:chatia/core/widgets/custom_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/styles/app_color.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/routers.dart';
import '../../../../core/widgets/custom_button.dart';
import '../views_model/cubit/auth_cubit.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var passController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
      if (state is RegisterSucessState) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'doneeeeee',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ));
        CacheHelper.saveData(key: isLoginKey, value: true);
        CacheHelper.saveData(key: emailKey, value: state.model.email);
        CacheHelper.saveData(key: fullNameKey, value: state.model.fullName);
        GoRouter.of(context).pushReplacement(AppRouter.homeView);
      } else if (state is RegisterErrorState) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            state.error.toString(),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ));
      }
    }, builder: (context, state) {
      var cubit = AuthCubit.get(context);
      return SafeArea(
        child: Scaffold(
          body: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        isDark ? 'light-logo'.toPng : 'dark-logo'.toPng,
                        height: 60,
                      ),
                      50.ph,
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome Back',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    fontSize: 25,
                                  ),
                            ),
                            10.ph,
                            Text(
                              'Register now to chat with all world.',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      20.ph,
                      TextFormField(
                        controller: nameController,
                        style: Theme.of(context).textTheme.bodyMedium,
                        keyboardType: TextInputType.name,
                        cursorColor: ColorManager.primaryColor,
                        decoration: const InputDecoration(
                            labelText: 'Full Name',
                            prefixIcon: Icon(Icons.person)),
                        validator: (value) {
                          if (value!.length < 6) {
                            return 'Please Enter at least 6 characters';
                          } else {
                            return null;
                          }
                        },
                      ),
                      20.ph,
                      TextFormField(
                        controller: emailController,
                        style: Theme.of(context).textTheme.bodyMedium,
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: ColorManager.primaryColor,
                        decoration: const InputDecoration(
                            labelText: 'Email Address',
                            prefixIcon: Icon(Icons.email_rounded)),
                        validator: (value) {
                          if (RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value!)) {
                            return null;
                          } else {
                            return 'Please Enter a valid email address.';
                          }
                        },
                      ),
                      20.ph,
                      TextFormField(
                        controller: passController,
                        style: Theme.of(context).textTheme.bodyMedium,
                        obscureText: cubit.obscureText,
                        keyboardType: TextInputType.visiblePassword,
                        cursorColor: ColorManager.primaryColor,
                        decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  cubit.changeEyeIcon();
                                },
                                icon: Icon(cubit.suffix))),
                        validator: (value) {
                          if (value!.length < 6) {
                            return 'Please Enter at least 6 characters';
                          } else {
                            return null;
                          }
                        },
                        onFieldSubmitted: (value) async {
                          if (formKey.currentState!.validate()) {
                            await cubit.register(nameController.text,
                                emailController.text, passController.text);
                          }
                        },
                      ),
                      20.ph,
                      state is RegisterLoadingState
                          ? const CustomCircularProgressIndicator()
                          : CustomButton(
                              text: 'Register',
                              onTap: () async {
                                if (formKey.currentState!.validate()) {
                                  await cubit.register(
                                      nameController.text,
                                      emailController.text,
                                      passController.text);
                                }
                              },
                            ),
                      25.ph,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'I have an account. ',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          GestureDetector(
                            onTap: () {
                              GoRouter.of(context).push(AppRouter.loginView);
                            },
                            child: Text(
                              'Login Now !',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: ColorManager.primaryColor,
                                  ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
