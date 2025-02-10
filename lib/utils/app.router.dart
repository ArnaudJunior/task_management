import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_management/screens/analytics/widget.analytics.dart';
import 'package:task_management/screens/bottom_nav/screen.bottom_nav_bar.dart';
import 'package:task_management/screens/calendar/screen.calendar.dart';
import 'package:task_management/screens/home/widget.home.dart';
import 'package:task_management/screens/login/screen.login.dart';
import 'package:task_management/screens/profile/widget.profile.dart';
import 'package:task_management/screens/register/screen.register.dart';
import 'package:task_management/screens/tasks/widget.tasks.dart';

class AppRouter {
  final String initialRoute;

  AppRouter({required this.initialRoute});

  GoRouter get router {
    return GoRouter(
      debugLogDiagnostics: true,
      initialLocation: _formatInitialRoute(initialRoute),
      observers: [GoRouterObserver()],
      routes: <RouteBase>[
        // GoRoute(
        //   path: WelcomeScreen.path,
        //   name: WelcomeScreen.name,
        //   builder: (BuildContext context, GoRouterState state) {
        //     return const WelcomeScreen();
        //   },
        // ),
        GoRoute(
          path: LoginScreen.path,
          name: LoginScreen.name,
          builder: (BuildContext context, GoRouterState state) {
            return const LoginScreen();
          },
          routes: [],
        ),

        GoRoute(
          path: RegisterScreen.path,
          name: RegisterScreen.name,
          builder: (BuildContext context, GoRouterState state) {
            return const RegisterScreen();
          },
        ),

        // ==> SHELLROUTE CLIENT

        StatefulShellRoute(
          navigatorContainerBuilder: (BuildContext context,
              StatefulNavigationShell navigationShell, List<Widget> children) {
            return ScaffoldWithNavigation(
                navigationShell: navigationShell, children: children);
          },
          builder: (BuildContext context, GoRouterState state,
              StatefulNavigationShell shell) {
            return CustomerBottomNavigationScreen(shell: shell);
          },
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: HomeScreen.path, // Route pour le Dashboard
                  name: HomeScreen.name,
                  builder: (BuildContext context, GoRouterState state) {
                    return const HomeScreen(); // First screen in BottomNavigationGerant
                  },
                  routes: [
                    // GoRoute(
                    //     path: AnalytiqueScreen.path,
                    //     name: AnalytiqueScreen.name,
                    //     builder: (BuildContext context, GoRouterState state) {
                    //       return const AnalytiqueScreen();
                    //     }),
                    // GoRoute(
                    //   path: CalendarScreen.path,
                    //   name: CalendarScreen.name,
                    //   builder: (BuildContext context, GoRouterState state) {
                    //     return const CalendarScreen();

                    //   }
                    // ),

                    GoRoute(
                      path: AddTaskScreen.path,
                      name: AddTaskScreen.name,
                      builder: (BuildContext context, GoRouterState state) {
                        return const AddTaskScreen();
                      },
                    ),
                  ],
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                    path: AnalytiqueScreen.path,
                    name: AnalytiqueScreen.name,
                    builder: (BuildContext context, GoRouterState state) {
                      return const AnalytiqueScreen();
                    }),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                    path: CalendarScreen.path,
                    name: CalendarScreen.name,
                    builder: (BuildContext context, GoRouterState state) {
                      return const CalendarScreen();
                    }),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                    path: ProfileScreen.path,
                    name: ProfileScreen.name,
                    builder: (BuildContext context, GoRouterState state) {
                      return const ProfileScreen();
                    }),
              ],
            ),
          ],
        ),

        // ==> SHELLROUTE VISITEUR

        // ==> SHELLROUTE CLIENT

        // Icon Button

        // Icon Button
      ],
    );
  }

  String _formatInitialRoute(String route) {
    if (route.startsWith('//')) {
      route = route.substring(1);
    }
    return route.isNotEmpty ? route : LoginScreen.path;
  }
}

class GoRouterObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    print('Did push route ${route.settings.name}');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    print('Did pop route ${route.settings.name}');
  }
}

class ScaffoldWithNavigation extends StatelessWidget {
  const ScaffoldWithNavigation({
    required this.navigationShell,
    required this.children,
    super.key,
  });

  final StatefulNavigationShell navigationShell;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: children[navigationShell.currentIndex],
    );
  }
}
