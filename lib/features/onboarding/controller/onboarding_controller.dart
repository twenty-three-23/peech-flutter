import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_user_info_storage.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController(
    initialPage: 0,
  );

  Rx<int> currentIndex = Rx<int>(0); // 현재 페이지 인덱스
  Rx<int> currentTextIndex = Rx<int>(0); // 현재 표시되고 있는 텍스트 이미지 인덱스
  final int lastPage = 2; // 마지막 페이지

  // 온보딩 텍스트 이미지 리스트
  Rx<List<String>> textList = Rx<List<String>>([
    'assets/images/onboarding/onboarding_text_1.png',
    'assets/images/onboarding/onboarding_text_2.png',
    'assets/images/onboarding/onboarding_text_3.png',
  ]);

  // 온보딩 진행도 이미지 리스트
  Rx<List<String>> progressList = Rx<List<String>>([
    'assets/images/onboarding/onboarding_progress_1.png',
    'assets/images/onboarding/onboarding_progress_2.png',
    'assets/images/onboarding/onboarding_progress_3.png',
  ]);

  // 텍스트 이미지 fade out, fade in 애니메이션을 위한 투명도 변수
  Rx<double> textOpacity = Rx<double>(1.0);

  // 시작 버튼 fade out, fade in 애니메이션을 위한 투명도 변수
  Rx<double> startButtonOpacity = Rx<double>(0.0);

  void onPageChange(int index) {
    // 페이지가 변경될 때 fade out 애니메이션을 트리거
    textOpacity.value = 0.0;
    currentIndex.value = index;

    // 딜레이 후 fade in 애니메이션을 트리거
    Future.delayed(const Duration(milliseconds: 250), () {
      textOpacity.value = 1.0;
      currentTextIndex.value = index;
    });

    // 시작하기 버튼 표시
    if (index == lastPage) {
      Future.delayed(const Duration(milliseconds: 1000), () {
        startButtonOpacity.value = 1.0;
      });
    }
  }

  void startButton(BuildContext context) {
    LocalUserInfoStorage().setIsOnboardingFinished(true); // 온보딩 완료 처리
    Navigator.of(context).pushNamed('/root');
  }
}
