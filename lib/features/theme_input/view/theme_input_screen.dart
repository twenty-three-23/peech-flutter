import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("발표 주제를 입력해주세요"),
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              maxLines: 1,
              onChanged: (value) {
                controller.updateTheme(value);
              },
              decoration: const InputDecoration(
                  hintText: "발표 주제",
                  border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 10,),
          TextButton(
              onPressed: () {
                controller.finishButton(context);
              },
              child: GetX<ThemeInputCtr>(
                  builder: (_) => controller.isLoading.value == true
                      ? const CircularProgressIndicator()
                      : const Text("입력 완료")
              )
          ),
          const SizedBox(height: 100,),
        ],
      ),
    );
  }
}
