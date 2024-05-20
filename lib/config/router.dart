import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../globals.dart';
import '../model/entities/client.dart';
import '../model/entities/delivery.dart';
import '../view/employee/map_screen.dart';
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
        return await auth.isExpiredToken() ? '/login' : '/home';
      }
    ),
    GoRoute(
      path: '/home',
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
    ),
    GoRoute(
      path: '/map',
      pageBuilder: (context, state) {
        final Map<String, dynamic> extra = state.extra! as Map<String, dynamic>;
        final delivery = extra['delivery'] as Delivery;
        final client = extra['client'] as Client;

        return CustomTransitionPage(
          key: state.pageKey,
          transitionDuration: const Duration(milliseconds: 400),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(
              opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
              child: child
            ),
          child: MapScreen(delivery: delivery, client: client)
        );
      },
      /*builder: (context, state) {
        final Map<String, dynamic> extra = state.extra! as Map<String, dynamic>;
        final delivery = extra['delivery'] as Delivery;
        final client = extra['client'] as Client;
        return MapScreen(delivery: delivery, client: client);
      }*/
    ),
  ],
  redirect: (context, state) async {
    return await auth.isExpiredToken() ? '/login' : null;
  }
);