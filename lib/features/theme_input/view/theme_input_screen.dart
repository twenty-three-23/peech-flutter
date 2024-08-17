import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_practice_mode_storage.dart';
import 'package:swm_peech_flutter/features/common/widgets/common_text_field.dart';
import 'package:swm_peech_flutter/features/common/widgets/primary_color_button.dart';
import 'package:swm_peech_flutter/features/theme_input/controller/theme_input_controller.dart';

class ThemeInputScreen extends StatelessWidget {
  const ThemeInputScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final ThemeInputCtr controller = Get.find<ThemeInputCtr>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("발표 주제 입력"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                SvgPicture.asset(
                    'assets/images/progress_indicator_filled.svg',
                    semanticsLabel: 'progress bar'
                ),
                const SizedBox(width: 4,),
                SvgPicture.asset(
                    'assets/images/progress_indicator_empty.svg',
                    semanticsLabel: 'progress bar'
                ),
                const SizedBox(width: 4,),
                SvgPicture.asset(
                    'assets/images/progress_indicator_empty.svg',
                    semanticsLabel: 'progress bar'
                ),
                const SizedBox(width: 4,),
                SvgPicture.asset(
                    'assets/images/progress_indicator_empty.svg',
                    semanticsLabel: 'progress bar'
                ),
              ],
            ),
          ),
          Expanded(
            child: GetX<ThemeInputCtr>( builder: (_) => controller.isLoading.value == true
            ? const Center(child: CircularProgressIndicator(),)
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16,),
                    const Text(
                      "무엇에 대해 발표하시나요?",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF3B3E43),
                        height: 34 / 22
                      )
                    ),
                    const SizedBox(height: 8,),
                    const Text(
                        "발표할 주제나 제목을 적어보세요",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF3B3E43),
                          height: 22 / 14
                        )
                    ),
                    const SizedBox(height: 24,),
                    CommonTextField(
                      hintText: '대본의 제목을 입력해주세요',
                      maxLines: 1,
                      onChanged: (value) {
                        controller.updateTheme(value);
                      },
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: ColoredButton(
                            text: '입력 완료',
                            onPressed: () {
                              LocalPracticeModeStorage().setMode(PracticeMode.withScript);
                              controller.finishButton(context);
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8,),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                              onPressed: () {
                                LocalPracticeModeStorage().setMode(PracticeMode.noScript);
                                controller.finishButton(context);
                              },
                              child: const Text(
                                "대본없이 녹음 바로 하기",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF3B3E43),
                                  height: 22 / 14,
                                )
                              )
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8,)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
