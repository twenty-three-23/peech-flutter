import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/common/widgets/colored_button.dart';
import 'package:swm_peech_flutter/features/onboarding/controller/onboarding_controller.dart';

class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = Get.find<OnboardingController>();

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
                GetX<OnboardingController>(
                  builder: (_) => AnimatedOpacity(
                    opacity: _controller.textOpacity.value,
                    duration: const Duration(milliseconds: 250),
                    child: Image.asset(
                      _controller.textList.value[_controller.currentTextIndex.value],
                      height: 96,
                      width: 254,
                    ),
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                GetX<OnboardingController>(
                  builder: (_) => Image.asset(
                    _controller.progressList.value[_controller.currentIndex.value],
                    height: 14,
                    width: 34,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 500,
              child: PageView(
                controller: _controller.pageController,
                onPageChanged: (index) {
                  _controller.onPageChange(index);
                },
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Image.asset(
                      'assets/images/onboarding/onboarding_image_1.png',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Image.asset(
                      'assets/images/onboarding/onboarding_image_2.png',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Image.asset(
                      'assets/images/onboarding/onboarding_image_3.png',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GetX<OnboardingController>(
              builder: (_) => AnimatedOpacity(
                opacity: _controller.startButtonOpacity.value,
                duration: const Duration(milliseconds: 300),
                child: Container(
                  color: Color(0xFFFFFFFF),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 24, right: 24, bottom: 8, top: 8),
                    child: ColoredButton(
                      text: '시작하기',
                      onPressed: () {
                        _controller.startButton(context);
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          GetX<OnboardingController>(
            builder: (_) {
              if (_controller.currentIndex.value != 0)
                return Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    iconSize: 40,
                    onPressed: () {
                      _controller.pageController.previousPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
                    },
                    icon: Icon(Icons.arrow_circle_left),
                  ),
                );
              else
                return SizedBox();
            },
          ),
          GetX<OnboardingController>(
            builder: (_) {
              if (_controller.currentIndex.value != _controller.lastPage)
                return Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    iconSize: 40,
                    onPressed: () {
                      _controller.pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
                    },
                    icon: Icon(Icons.arrow_circle_right),
                  ),
                );
              else
                return SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
