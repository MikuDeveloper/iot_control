import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iot_control/globals.dart';

import '../view/home/home_screen.dart';
import '../view/login/login_screen.dart';

final routerConfig = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
      redirect: (context, state) async {
        return await preferences.isExpiredToken() ? '/login' : '/home';
      }
    ),
    GoRoute(
      path: '/home',
      //builder: (context, state) => const HomeScreen()
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        transitionDuration: const Duration(milliseconds: 400),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          /*FadeTransition(
            opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
            child: child,
          ),*/
          SlideTransition(
            position: animation.drive(
                Tween(begin: const Offset(1,0), end: Offset.zero)),
            child: child,
          ),
          //ScaleTransition(scale: animation, child: child),
        child: const HomeScreen()
      )
    )
  ],
  redirect: (context, state) async {
    return await preferences.isExpiredToken() ? '/login' : null;
  }
);