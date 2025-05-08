import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_plus_fe/presentation/constants/colors.dart';
import 'package:social_plus_fe/presentation/constants/text_styles.dart';
import '../viewmodels/home_viewmodel.dart';
import '../widgets/common_app_bar.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/primary_action_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final viewModel = context.read<HomeViewModel>();
      viewModel.loadLessons();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();

    return Scaffold(
      appBar: buildCommonAppBar(username: '김민성님'),
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '이번주 인기강좌 TOP 5',
              style: AppTextStyles.subtitleR.copyWith(color: AppColors.text),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 330,
              child: viewModel.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                clipBehavior: Clip.none,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: viewModel.lessons.length,
                padding: const EdgeInsets.only(right: 16),
                itemBuilder: (context, index) {
                  final lesson = viewModel.lessons[index];
                  return _buildLessonCard(
                    context,
                    imagePath: lesson.imagePath,
                    title: lesson.title,
                    description: lesson.description,
                    buttonText: lesson.isAvailable
                        ? '시작하기'
                        : '레슨 완료 후 이용하세요',
                    onPressed: lesson.isAvailable
                        ? () {
                      // TODO: 다음 화면 이동
                    }
                        : null,
                  );
                },
              ),
            ),
            const SizedBox(height: 76),
            Text(
              '맞춤 대화 연습을 진행해보세요',
              style: AppTextStyles.subtitleR.copyWith(color: AppColors.text),
            ),
            const SizedBox(height: 12),
            PrimaryActionButton(
              text: '레슨 진행하기',
              onPressed: () {},
              icon: Image.asset(
                'assets/images/leftArrowCircle.png',
                width: 24,
                height: 24,
              ),
              alignment: MainAxisAlignment.start,
              width: 280,
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 1,
        onTap: (index) {
          // TODO: 내비게이션 처리
        },
      ),
    );
  }

  Widget _buildLessonCard(
      BuildContext context, {
        required String imagePath,
        required String title,
        required String description,
        required String buttonText,
        VoidCallback? onPressed,
      }) {
    return Container(
      width: 280,
      height: 350,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: AppColors.lightGray,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                child: Image.asset(imagePath, width: double.infinity, height: 130, fit: BoxFit.cover),
              ),
              const Positioned(
                top: 10,
                right: 10,
                child: Icon(Icons.star, color: Colors.amber),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(title, style: AppTextStyles.body.copyWith(color: AppColors.text)),
                const SizedBox(height: 8),
                Divider( // ✅ 구분선
                  color: AppColors.gray,
                  thickness: 1,
                  height: 16, // 위아래 padding 역할
                ),
                Text(description, style: AppTextStyles.caption.copyWith(color: AppColors.black50), textAlign: TextAlign.center,),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: onPressed,
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    child: Text(buttonText, style: AppTextStyles.caption.copyWith(color: Colors.white)),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
