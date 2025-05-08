import 'package:flutter/material.dart';
import 'package:social_plus_fe/presentation/constants/colors.dart';
import 'package:social_plus_fe/presentation/pages/chat_page.dart';
import 'package:social_plus_fe/presentation/pages/lesson_page.dart';
import 'package:social_plus_fe/presentation/pages/home_screen.dart';
import 'package:social_plus_fe/presentation/pages/lesson_selection_screen.dart';
import 'package:social_plus_fe/presentation/viewmodels/home_viewmodel.dart';
import 'package:social_plus_fe/presentation/viewmodels/lesson_select_viewmodel.dart';
import 'data/repositories/lesson_repository.dart';
import 'presentation/pages/type_choose_screen.dart';
import 'presentation/pages/job_type_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<LessonRepository>(create: (_) => LessonRepository()),
        ChangeNotifierProvider(
          create: (context) => HomeViewModel(context.read<LessonRepository>()),
        ),
        ChangeNotifierProvider(create: (_) => LessonSelectViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Flutter Demo',
    theme: ThemeData(
      fontFamily: 'Pretendard',
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.chatBackground),
    ),
    initialRoute: '/',
    routes: {
      '/': (context) => const MyHomePage(title: 'Flutter Demo Home Page'),
      LessonListScreen.routeName: (context) => LessonListScreen(),
      ChatPage.routeName: (context) => const ChatPage(),
      // 추가
      '/lessonSelect': (context) => const LessonSelectScreen(),
      '/home': (context) => const HomeScreen(),
    },
  );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // MyHomePage에서 레슨 목록 화면으로 이동
                Navigator.pushNamed(context, LessonListScreen.routeName);
              },
              child: const Text('Go to Lesson List'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}