import 'package:flutter/material.dart';
import 'package:swm_peech_flutter/features/common/widgets/colored_button.dart';

class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController pageController = PageController(
    initialPage: 0,
  );

  int _currentIndex = 0; // 현재 페이지 인덱스
  int _currentTextIndex = 0; // 현재 표시되고 있는 텍스트 이미지 인덱스
  int _lastPage = 2; // 마지막 페이지

  // 온보딩 텍스트 이미지 리스트
  List<String> textList = [
    'assets/images/onboarding/onboarding_text_1.png',
    'assets/images/onboarding/onboarding_text_2.png',
    'assets/images/onboarding/onboarding_text_3.png',
  ];

  // 온보딩 진행도 이미지 리스트
  List<String> progressList = [
    'assets/images/onboarding/onboarding_progress_1.png',
    'assets/images/onboarding/onboarding_progress_2.png',
    'assets/images/onboarding/onboarding_progress_3.png',
  ];

  // 텍스트 이미지 fade out, fade in 애니메이션을 위한 투명도 변수
  double _textOpacity = 1.0;

  // 시작 버튼 fade out, fade in 애니메이션을 위한 투명도 변수
  double _startButtonOpacity = 0.0;

  // 온보딩 이미지 높이를 가져오기 위한 GlobalKey
  final GlobalKey onboardImageKey = GlobalKey(); // GlobalKey 추가

  // 온보딩 이미지의 높이
  double onboardingImageHeight = 0;

  @override
  void initState() {
    // 화면 크기에 맞게 확장된 온보딩 이미지의 높이 구해오기
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox renderBox = onboardImageKey.currentContext?.findRenderObject() as RenderBox;
      setState(() {
        onboardingImageHeight = renderBox.size.height;
        print('onboardingImageHeight: $onboardingImageHeight');
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFFFFFF),
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                ),
                AnimatedOpacity(
                  opacity: _textOpacity,
                  duration: const Duration(milliseconds: 250),
                  child: Image.asset(
                    textList[_currentTextIndex],
                    height: 96,
                    width: 254,
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Image.asset(
                  progressList[_currentIndex],
                  height: 14,
                  width: 34,
                ),
              ],
            ),
          ),
          PageView(
            controller: pageController,
            onPageChanged: (index) {
              // 페이지가 변경될 때 fade out 애니메이션을 트리거
              setState(() {
                _textOpacity = 0.0;
                _currentIndex = index;
              });

              // 딜레이 후 fade in 애니메이션을 트리거
              Future.delayed(const Duration(milliseconds: 250), () {
                setState(() {
                  _textOpacity = 1.0;
                  _currentTextIndex = index;
                });
              });

              // 시작하기 버튼 표시
              if (index == _lastPage) {
                Future.delayed(const Duration(milliseconds: 1000), () {
                  setState(() {
                    _startButtonOpacity = 1.0;
                  });
                });
              }
            },
            children: [
              Align(
                key: onboardImageKey,
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  'assets/images/onboarding/onboarding_image_1.png',
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  'assets/images/onboarding/onboarding_image_2.png',
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  'assets/images/onboarding/onboarding_image_3.png',
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedOpacity(
              opacity: _startButtonOpacity,
              duration: const Duration(milliseconds: 300),
              child: Container(
                color: Color(0xFFFFFFFF),
                child: Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24, bottom: 8, top: 8),
                  child: ColoredButton(
                    text: '시작하기',
                    onPressed: () {
                      Navigator.of(context).pushNamed('/root');
                    },
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
