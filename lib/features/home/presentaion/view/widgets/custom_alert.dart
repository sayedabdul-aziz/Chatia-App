import 'package:chatia/features/home/presentaion/view_model/cubit/home_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/styles/app_color.dart';
import '../../../../../core/utils/cache_helper.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/widgets/custom_loading_widget.dart';

class CustomAlertWidget extends StatelessWidget {
  CustomAlertWidget({super.key});
  var name = CacheHelper.getData(key: fullNameKey);
  var email = CacheHelper.getData(key: emailKey);
  var id = FirebaseAuth.instance.currentUser!.uid;
  var groupName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is CreateGroupLoadingState) {
            return const CustomCircularProgressIndicator();
          } else {
            var cubit = HomeCubit.get(context);
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              backgroundColor: ColorManager.darkCardColor,
              titleTextStyle: Theme.of(context).textTheme.bodyLarge,
              contentTextStyle: Theme.of(context).textTheme.bodyMedium,
              title: const Text('Create a group'),
              content: TextFormField(
                controller: groupName,
                style: Theme.of(context).textTheme.bodyMedium,
                keyboardType: TextInputType.name,
                cursorColor: ColorManager.primaryColor,
                decoration: const InputDecoration(
                  hintText: 'Enter a group name.',
                ),
                validator: (value) {
                  if (value!.length < 6) {
                    return 'Please Enter at least 6 characters';
                  } else {
                    return null;
                  }
                },
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      GoRouter.of(context).pop();
                    },
                    child: const Text("Cancel")),
                TextButton(
                    onPressed: () {
                      if (groupName.text.length > 4) {
                        cubit
                            .createGroup(name, id, groupName.text)
                            .then((value) => GoRouter.of(context).pop());
                      }
                    },
                    child: const Text(
                      "Create",
                    )),
              ],
            );
          }
        },
      ),
    );
  }
}
