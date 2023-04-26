import 'package:chatia/core/utils/routers.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/cache_helper.dart';
import '../../../core/utils/extensions.dart';
import 'package:flutter/material.dart';

class SplashBody extends StatefulWidget {
  const SplashBody({super.key});

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody>
    with SingleTickerProviderStateMixin {
  bool isLogin = CacheHelper.getData(key: 'IS_LOGIN') ?? false;
  @override
  void initState() {
    super.initState();
    if (isLogin) {
      navigateToHome(AppRouter.homeView);
    } else {
      navigateToHome(AppRouter.loginView);
    }
  }

  bool isDark = CacheHelper.getData(key: 'isDark') ?? true;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            isDark ? "light-logo".toPng : "dark-logo".toPng,
            width: MediaQuery.of(context).size.width * .6,
          ),
        ],
      ),
    );
  }

  void navigateToHome(String pageName) {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        GoRouter.of(context).pushReplacement(pageName);
      },
    );
  }
}
