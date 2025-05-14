import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:social_plus_fe/presentation/constants/colors.dart';
import 'package:social_plus_fe/presentation/viewmodels/home_viewmodel.dart';
import 'package:social_plus_fe/presentation/viewmodels/lesson_scenario_viewmodel.dart';
import 'package:social_plus_fe/presentation/viewmodels/lesson_select_viewmodel.dart';
import 'package:social_plus_fe/presentation/viewmodels/user_preferences_viewmodel.dart';
import 'core/navigation/app_router.dart';
import 'data/repository/mock_scenario_repository.dart';
import 'data/repository/user_preferences_repository_impl.dart';
import 'domain/repository/popular_lesson_repository.dart';
import 'data/user_preferences_data_source.dart';
import 'package:provider/provider.dart';

void main() {
  GoRouter.optionURLReflectsImperativeAPIs = true;
  runApp(
    ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 769, minHeight: 600),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LessonScenarioViewModel(MockScenarioRepository())),
          Provider<LessonRepository>(create: (_) => LessonRepository()),
          ChangeNotifierProvider(
            create:
                (context) => HomeViewModel(context.read<LessonRepository>()),
          ),
          ChangeNotifierProvider(create: (_) => LessonSelectViewModel()),
          ChangeNotifierProvider(
            create:
                (_) => UserPreferencesViewModel(
                  UserPreferencesRepositoryImpl(UserPreferencesDataSource()),
                ),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'SocialPlus',
      theme: ThemeData(
        fontFamily: 'Pretendard',
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.chatBackground),
      ),
      routerConfig: appRouter,
    );
  }
}
