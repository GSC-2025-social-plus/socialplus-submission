import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:social_plus_fe/presentation/widgets/app_scaffold.dart';
import 'package:social_plus_fe/presentation/pages/chat_page.dart';
import 'package:social_plus_fe/presentation/constants/colors.dart';
import 'package:social_plus_fe/presentation/constants/text_styles.dart';
import '../../domain/models/scenario.dart';
import '../viewmodels/lesson_scenario_viewmodel.dart';
import '../viewmodels/user_preferences_viewmodel.dart';
import '../widgets/mission_card.dart';
import '../widgets/primary_action_button.dart';

class LessonMissionsScreen extends StatefulWidget {
  final int lessonIndex;

  const LessonMissionsScreen({
    super.key,
    required this.lessonIndex,
  });

  @override
  State<LessonMissionsScreen> createState() => _LessonMissionsScreenState();
}

class _LessonMissionsScreenState extends State<LessonMissionsScreen> {
  @override
  void initState() {
    super.initState();

    // ViewModel에서 type 가져와서 시나리오 로드
    Future.microtask(() {
      final type = context.read<UserPreferencesViewModel>().conversationType ?? 'daily';
      context.read<LessonScenarioViewModel>().loadScenario(index: widget.lessonIndex, type: type);
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<LessonScenarioViewModel>();
    final scenario = viewModel.scenario;

    if (viewModel.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final missions = scenario?.missions ?? [];

    return CommonScaffold(
      title: scenario?.scenarioName ?? 'Lesson',
      selectedNavIndex: 1,
      backgroundColor: AppColors.background,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    scenario?.scenarioDescription ??
                        '이 레슨에서는 다음 미션들을 수행해볼 거예요.',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.text,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemCount: missions.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, i) {
                        return MissionCard(mission: missions[i]);
                      },
                    ),
                  ),
                  const SizedBox(height: 32),
                  Align(
                    alignment: Alignment.center,
                    child: PrimaryActionButton(
                      text: '시작하기',
                      onPressed: () {
                        final lessonIndex = widget.lessonIndex;
                        final scenarioId = scenario?.scenarioId ?? 'daily_lesson_1'; // 안전하게 fallback
                        context.push(
                          '/chat?index=$lessonIndex&scenarioId=$scenarioId',
                        );
                      },
                      icon: Image.asset(
                        'assets/images/RightArrowCircle.png',
                        width: 24,
                        height: 24,
                        color: Colors.white,
                      ),
                      alignment: MainAxisAlignment.center,
                      width: 177,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}