import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/pages/splash_page.dart';
import '../../presentation/pages/home_screen.dart';
import '../../presentation/pages/lesson_page.dart';
import '../../presentation/pages/lesson_selection_screen.dart';
import '../../presentation/pages/job_type_screen.dart';
import '../../presentation/pages/type_choose_screen.dart';
import '../../presentation/pages/chat_page.dart';
import '../../presentation/routes/route_names.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: RouteNames.splash,
  routes: [
    GoRoute(
      path: RouteNames.splash,
      builder: (context, state) => SplashPage(),
    ),
    GoRoute(
      path: RouteNames.home,
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: RouteNames.lesson,
      builder: (context, state) {
        final lessonIndex = int.tryParse(state.uri.queryParameters['index'] ?? '0') ?? 0;
        return LessonMissionsScreen(lessonIndex: lessonIndex);
      },
    ),
    GoRoute(
      path: RouteNames.lessonSelection,
      builder: (context, state) => LessonSelectionScreen(),
    ),
    GoRoute(
      path: RouteNames.jobType,
      builder: (context, state) => JobTypeScreen(),
    ),
    GoRoute(
      path: RouteNames.typeChoose,
      builder: (context, state) => TypeChooseScreen(),
    ),
    GoRoute(
      path: RouteNames.chat,
      builder: (context, state) {
        final lessonIndex = int.tryParse(state.uri.queryParameters['index'] ?? '0') ?? 0;
        final scenarioId = state.uri.queryParameters['scenarioId'] ?? 'daily_lesson_1';

        return ChatPage(
          lessonIndex: lessonIndex,
          scenarioId: scenarioId,
        );
      },
    ),
  ],
);
