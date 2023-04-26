import 'package:chatia/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../services/auth_services.dart';
import '../styles/app_color.dart';
import '../utils/cache_helper.dart';
import '../utils/constants.dart';
import '../utils/routers.dart';

class CustomDrawerWidget extends StatelessWidget {
  CustomDrawerWidget({super.key});

  var name = CacheHelper.getData(key: fullNameKey);
  var email = CacheHelper.getData(key: emailKey);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Drawer(
      backgroundColor: ColorManager.darkCardColor,
      width: width * .5,
      child: Container(
        alignment: Alignment.center,
        child: ListView(
          children: [
            20.ph,
            const Icon(
              Icons.account_circle_rounded,
              size: 120,
            ),
            10.ph,
            Text(
              name,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            15.ph,
            const Divider(
              color: ColorManager.greyColor,
              height: 5,
              endIndent: 20,
              indent: 20,
            ),
            15.ph,
            Column(
              children: [
                ListTile(
                  leading: Icon(Icons.groups_2_rounded,
                      color: ColorManager.primaryColor),
                  onTap: () {
                    GoRouter.of(context).pushReplacement(AppRouter.homeView);
                  },
                  title: Text(
                    'Groups',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.person,
                    color: ColorManager.primaryColor,
                  ),
                  onTap: () {
                    GoRouter.of(context).push(AppRouter.profileView);
                  },
                  title: Text(
                    'Profile',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.logout_rounded,
                      color: ColorManager.primaryColor),
                  onTap: () async {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: ColorManager.darkCardColor,
                          titleTextStyle: Theme.of(context).textTheme.bodyLarge,
                          contentTextStyle:
                              Theme.of(context).textTheme.bodyMedium,
                          title: const Text('Logout'),
                          content: const Text('Are you sure ?'),
                          actions: [
                            IconButton(
                                onPressed: () {
                                  GoRouter.of(context).pop();
                                },
                                icon: const Icon(Icons.cancel_outlined)),
                            IconButton(
                                onPressed: () async {
                                  await AuthServices().logout().then((value) {
                                    GoRouter.of(context)
                                        .pushReplacement(AppRouter.loginView);
                                  });
                                },
                                icon: const Icon(
                                    Icons.check_circle_outline_rounded)),
                          ],
                        );
                      },
                    );
                  },
                  title: Text(
                    'Logout',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
