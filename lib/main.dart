import 'package:chatia/core/utils/routers.dart';
import 'package:chatia/features/auth/presentation/views_model/cubit/auth_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme/cubit/cubit.dart';
import 'core/theme/cubit/states.dart';
import 'core/theme/theme_manager.dart';
import 'core/utils/cache_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBDba1V5Gd6Cph0XWsgP4IzwneWV2BmkwM",
            authDomain: "chatia-7c8d0.firebaseapp.com",
            projectId: "chatia-7c8d0",
            storageBucket: "chatia-7c8d0.appspot.com",
            messagingSenderId: "641355884643",
            appId: "1:641355884643:web:0ac07213cf1f5315623056",
            measurementId: "G-N54D592R2Q"));
  } else {
    await Firebase.initializeApp();
  }

  await CacheHelper.init();
  bool? isDark = CacheHelper.getData(key: 'isDark') ?? true;

  runApp(MyApp(
    isDark!,
  ));
}

class MyApp extends StatelessWidget {
  bool isDark;
  MyApp(this.isDark, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ModeCubit()..changeAppMode(shared: isDark),
        ),
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
      ],
      child: BlocConsumer<ModeCubit, AppStates>(
          builder: (context, state) {
            return MaterialApp.router(
              routerConfig: AppRouter.router,
              debugShowCheckedModeBanner: false,
              title: 'Chatia',
              theme: lightMode,
              darkTheme: darkMode,
              themeMode: ModeCubit.get(context).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
            );
          },
          listener: (context, state) {}),
    );
  }
}
