import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
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
      body: GetX<ScriptInputCtr>(
        builder: (_) => controller.scriptInputIsLoading.value == true
        ? const Center(child: CircularProgressIndicator(),)
        : SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20,),
                const Text("대본을 입력해주세요"),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: ListView.builder(
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
                                  child: TextField(
                                    controller: controller.script.value[index],
                                    minLines: 1,
                                    maxLines: null,
                                    onChanged: (value) {
                                      controller.updateScript(index, value);
                                    },
                                    buildCounter: (context,
                                        {required currentLength, required isFocused, maxLength}) {
                                      return Text("$currentLength 자");
                                    },
                                    decoration: const InputDecoration(
                                        hintText: "문단을 입력해주세요",
                                        border: OutlineInputBorder(),
                                    ),
                                  ),
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
                    )
                  ),
                ),
                TextButton(
                  onPressed: () { controller.addParagraph(); },
                  child: const Text("문단 추가")
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        child: const Text("대본 입력 완료"),
                        onPressed: () {
                          controller.inputConfirmBtn(context);
                        },
                    ),
                  ),
                ),
              ],
            ),
        ),
      ),
    );
  }
}

