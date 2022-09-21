// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mscoffeeapp/services/auth_service.dart';
import 'package:mscoffeeapp/services/chat_service.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'helpers/constants.dart';
import 'helpers/is_debug.dart';
import 'helpers/theme.dart';
import 'models/coffee.dart';
import 'screens/home.dart';
import 'screens/menu.dart';
import 'screens/menu_detail.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          child: const Text('Login'),
          onPressed: () {
            AuthService.instance.loginInfo.isLoggedIn = true;
          },
        ),
      ),
    );
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final router = GoRouter(
    redirect: (GoRouterState state) {
      final loggedIn = AuthService.instance.loginInfo.isLoggedIn;

      final isLogging = state.location == '/';

      if (!loggedIn && !isLogging) return '/';

      if (loggedIn && isLogging) return '/menu';

      return null;
    },
    refreshListenable: AuthService.instance.loginInfo,
    urlPathStrategy: UrlPathStrategy.path,
    debugLogDiagnostics: true,
    initialLocation: AuthService.instance.loginInfo.isLoggedIn ? '/menu' : '/',
    routes: [
      GoRoute(
        name: 'home',
        path: '/',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const HomeScreen(),
        ),
      ),
      GoRoute(
        name: 'login',
        path: '/login',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        name: 'menu',
        path: '/menu',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const MenuScreen(),
        ),
        routes: [
          GoRoute(
            name: 'details',
            path: ':id', // e.g. /menu/1002
            pageBuilder: (context, state) {
              final coffee = _coffeeFrom(state.params['id']!);
              return MaterialPage(
                key: state.pageKey,
                child: MenuDetails(coffee: coffee),
              );
            },
          ),
        ],
      ),
    ],
    errorPageBuilder: (context, state) => MaterialPage(
      key: state.pageKey,
      child: Scaffold(
        body: Center(
          child: Text(state.error.toString()),
        ),
      ),
    ),
  );

  runZonedGuarded<Future<void>>(
    () async {
      await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp],
      );

      runApp(
        // MaterialApp(
        //   debugShowCheckedModeBanner: false,
        //   themeMode: ThemeMode.system,
        //   home: HomeScreen(),
        //   navigatorKey: CoffeeRouter.instance.navigatorKey,
        //   theme: getTheme(),
        // ),
        MaterialApp.router(
          routeInformationProvider: router.routeInformationProvider,
          routeInformationParser: router.routeInformationParser,
          routerDelegate: router.routerDelegate,
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.system,
          theme: getTheme(),
          builder: (context, child) {
            return StreamChat(
              client: ChatService.instance.client,
              child: child,
            );
          },
        ),
      );
    },
    (error, stackTrace) async {
      print('Caught Dart Error!');
      print('$error');
      print('$stackTrace');
    },
  );

  // This captures errors reported by the Flutter framework.
  FlutterError.onError = (FlutterErrorDetails details) async {
    final dynamic exception = details.exception;
    final StackTrace? stackTrace = details.stack;
    if (isInDebugMode) {
      print('Caught Framework Error!');
      // In development mode simply print to console.
      FlutterError.dumpErrorToConsole(details);
    } else {
      // In production mode report to the application zone
      Zone.current.handleUncaughtError(exception, stackTrace!);
    }
  };
}

Coffee _coffeeFrom(String s) {
  return coffees.where((coffee) => coffee.id.toString() == s).first;
}
