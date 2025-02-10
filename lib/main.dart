import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_management/database/app.generalmanager.dart';
import 'package:task_management/theme/theme.app.dart';
import 'package:task_management/utils/app.router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GeneralManagerDB.initSharedPreferences();
  String? lastRoute = await GeneralManagerDB.getLastRoute();
  print(lastRoute);

  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  runApp(MyApp(initialRoute: lastRoute ?? '/'));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.initialRoute});
  final String initialRoute;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AppRouter _appRouter;

  @override
  void initState() {
    _appRouter = AppRouter(initialRoute: widget.initialRoute);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Task Management App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      routerConfig: _appRouter.router,
    );
  }
}
