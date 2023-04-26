import 'cache_helper.dart';

const kTransitionDuration = Duration(milliseconds: 250);
String? token;
bool isDark = CacheHelper.getData(key: 'isDark') ?? true;
String isLoginKey = 'IS_LOGIN';
String emailKey = 'EMAIL';
String fullNameKey = 'FULL_NAME';
