import 'package:chatia/features/auth/presentation/views/login_view.dart';
import 'package:chatia/features/chat/presentaion/view/chat_Info.dart';
import 'package:chatia/features/chat/presentaion/view/chat_view.dart';
import 'package:chatia/features/search/presentaion/view/search_view.dart';
import 'package:chatia/features/search/presentaion/view_model/cubit/search_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/views/register_view.dart';
import '../../features/chat/presentaion/view_model/cubit/message_cubit.dart';
import '../../features/home/data/group_model.dart';
import '../../features/home/presentaion/view/home_view.dart';
import '../../features/profile/presentaion/view/profile_view.dart';
import '../../features/splash_screen/splash_screen.dart';

abstract class AppRouter {
  static const onboardingView = '/onboardingView';
  static const loginView = '/loginView';
  static const registerView = '/registerView';
  static const emailVerifyView = '/emailVerifyView';
  static const homeView = '/homeView';
  static const searchView = '/searchView';
  static const profileView = '/profileView';
  static const chatView = '/chatView';
  static const chatInfoView = '/chatInfoView';
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: loginView,
        builder: (context, state) => LoginView(),
      ),
      GoRoute(
        path: registerView,
        builder: (context, state) => RegisterView(),
      ),
      GoRoute(
        path: homeView,
        builder: (context, state) => const HomeView(),
      ),
      GoRoute(
        path: profileView,
        builder: (context, state) => ProfileView(),
      ),
      GoRoute(
        path: searchView,
        builder: (context, state) => BlocProvider(
          create: (context) => SearchCubit(),
          child: SearchView(),
        ),
      ),
      GoRoute(
        path: chatView,
        builder: (context, state) {
          var model = state.extra as GroupModel;
          return BlocProvider(
            create: (context) => MessageCubit()..getMembers(model.groupId),
            child: ChatView(
              model: model,
            ),
          );
        },
      ),
      GoRoute(
        path: chatInfoView,
        builder: (context, state) {
          var model = state.extra as GroupModel;
          return BlocProvider(
            create: (context) => MessageCubit()..getMembers(model.groupId),
            child: ChatInfoView(
              model: model,
            ),
          );
        },
      ),
    ],
  );
}
