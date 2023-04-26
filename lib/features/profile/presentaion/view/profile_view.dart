import 'package:chatia/core/utils/cache_helper.dart';
import 'package:chatia/core/utils/constants.dart';
import 'package:chatia/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/widgets/custom_drawer_widget.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  var name = CacheHelper.getData(key: fullNameKey);
  var email = CacheHelper.getData(key: emailKey);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: CustomDrawerWidget(),
      appBar: AppBar(
        title: const Text(
          'Profile',
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                FontAwesomeIcons.magnifyingGlass,
                size: 17,
              ))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.account_circle_rounded,
              size: 120,
            ),
            20.ph,
            Text(
              name,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            15.ph,
            Text(
              email,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
