import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/common/widgets/common_scaffold.dart';
import 'package:swm_peech_flutter/features/common/widgets/common_text_field.dart';
import 'package:swm_peech_flutter/features/common/widgets/colored_button.dart';
import '../controller/script_input_controller.dart';

class FullScriptInputScreen extends StatefulWidget {
  const FullScriptInputScreen({super.key});

  @override
  State<FullScriptInputScreen> createState() => _FullScriptInputScreenState();
}

class _FullScriptInputScreenState extends State<FullScriptInputScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ScriptInputCtr>();

    return CommonScaffold(
      appBarTitle: '대본으로 시작',
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // 화면을 터치하면 키보드를 내리고 포커스를 해제합니다.
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  const SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: SvgPicture.asset(
                      'assets/images/progress_indicator_filled.svg',
                      semanticsLabel: 'progress bar',
                      fit: BoxFit.fill,
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: SvgPicture.asset(
                      'assets/images/progress_indicator_empty.svg',
                      semanticsLabel: 'progress bar',
                      fit: BoxFit.fill,
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: SvgPicture.asset(
                      'assets/images/progress_indicator_empty.svg',
                      semanticsLabel: 'progress bar',
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GetX<ScriptInputCtr>(
                builder: (_) => controller.scriptInputIsLoading.value == true
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 16,
                              ),
                              const Text("발표할 내용을 적어보세요",
                                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Color(0xFF3B3E43), height: 34 / 22)),
                              const SizedBox(
                                height: 8,
                              ),
                              const Text("발표할 내용을 적으면 예상 시간을 알 수 있어요",
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF3B3E43), height: 22 / 14)),
                              const SizedBox(
                                height: 24,
                              ),
                              CommonTextField(
                                hintText: '문단을 입력하세요',
                                minLines: 10,
                                onChanged: (value) {
                                  controller.changeFullScript(value);
                                },
                                showCounter: true,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            GetX<ScriptInputCtr>(builder: (_) {
              if (controller.scriptInputIsLoading.value == false) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ColoredButton(
                          text: '대본 입력 완료',
                          onPressed: () {
                            controller.fullScriptInputConfirmBtn(context);
                          },
                          backgroundColor: const Color(0xFF3B3E43),
                          textColor: const Color(0xFFFFFFFF),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const Text('');
            }),
            const SizedBox(
              height: 8,
            )
          ],
        ),
      ),
    );
  }
}
