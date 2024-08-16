import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/common/widgets/common_text_field.dart';
import 'package:swm_peech_flutter/features/common/widgets/primary_color_button.dart';
import '../controller/script_input_controller.dart';

class ScriptInputScreen extends StatefulWidget {
  const ScriptInputScreen({super.key});

  @override
  State<ScriptInputScreen> createState() => _ScriptInputScreenState();
}

class _ScriptInputScreenState extends State<ScriptInputScreen> {

  @override
  Widget build(BuildContext context) {

    final controller = Get.find<ScriptInputCtr>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () { Navigator.of(context).pop(); }, icon: const Icon(Icons.arrow_back_ios)),
        title: const Text("대본으로 시작"),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // 화면을 터치하면 키보드를 내리고 포커스를 해제합니다.
        },
        child: Column(
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
                ],
              ),
            ),
            Expanded(
              child: GetX<ScriptInputCtr>(
                builder: (_) => controller.scriptInputIsLoading.value == true
                ? const Center(child: CircularProgressIndicator(),)
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 16,),
                          const Text(
                              "발표할 내용을 적어보세요",
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF3B3E43)
                              )
                          ),
                          const SizedBox(height: 8,),
                          const Text(
                              "발표할 내용을 적으면 예상 시간을 알 수 있어요",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF3B3E43)
                              )
                          ),
                          const SizedBox(height: 24,),
                          ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            itemCount: controller.script.value.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: CommonTextField(
                                          controller: controller.script.value[index],
                                          hintText: '문단을 입력하세요',
                                          minLines: 1,
                                          maxLines: 10,
                                          onChanged: (value) {
                                            controller.updateScript(index, value);
                                          },
                                          showCounter: true,
                                        )
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            "${index + 1}문단",
                                            style: const TextStyle(fontSize: 12),
                                          ),
                                          IconButton(
                                            onPressed: () { controller.removeParagraph(index); },
                                            icon: const Icon(Icons.close)
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 15,),
                                ],
                              );
                            },
                          ),
                          TextButton(
                            onPressed: () { controller.addParagraph(); },
                            child: const Text("문단 추가")
                          ),
                        ],
                      ),
                    ),
                ),
              ),
            ),
            if(controller.scriptInputIsLoading.value == false)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  children: [
                    Expanded(
                      child: PrimaryColorButton(
                        text: '대본 입력 완료',
                        onPressed: () {
                          controller.inputConfirmBtn(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 16,)
          ],
        ),
      ),
    );
  }
}

