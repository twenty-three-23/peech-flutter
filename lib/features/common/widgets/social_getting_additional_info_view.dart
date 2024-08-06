import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swm_peech_flutter/features/common/controllers/social_login_controller.dart';
import 'package:swm_peech_flutter/features/common/models/user_additional_info_view_state.dart';
import 'package:swm_peech_flutter/features/common/models/user_gender.dart';

Widget socialGettingAdditionalInfoView(BuildContext context, SocialLoginCtr controller) {
  return SizedBox(
    child: Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 40,),
              const Text(
                '계속하려면 사용자 정보를 입력해주세요',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                '입력 후 진행하던 작업으로 돌아갈 수 있습니다.',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey
                ),
              ),
              if(controller.userAdditionalInfoViewState.value == UserAdditionalInfoViewState.loading)
                const Column(
                  children: [
                    SizedBox(height: 50,),
                    SizedBox(height: 50, width: 50, child: CircularProgressIndicator()),
                  ],
                )
              else if(controller.userAdditionalInfoViewState.value == UserAdditionalInfoViewState.input)
                Column(
                  children: [
                    const SizedBox(height: 40),
                    TextFormField(
                      initialValue: controller.lastName.value,
                      onChanged: (value) {
                        controller.lastName.value = value;
                      },
                      decoration: const InputDecoration(
                        labelText: '성 (last name)',
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      initialValue: controller.firstName.value,
                      onChanged: (value) {
                        controller.firstName.value = value;
                      },
                      decoration: const InputDecoration(
                        labelText: '이름 (first name)',
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      initialValue: controller.nickname.value,
                      onChanged: (value) {
                        controller.nickname.value = value;
                      },
                      decoration: const InputDecoration(
                        labelText: '닉네임 (nickname)',
                      ),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const Text('생년월일 (birthday)'),
                            const SizedBox(height: 5,),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                              ),
                              onPressed: () async {
                                final selectedDate = await showDatePicker(
                                  context: context,
                                  initialDate: controller.birthday.value,
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime.now(),
                                );
                                if (selectedDate != null) {
                                  controller.birthday.value = selectedDate;
                                }
                              },
                              child: Text(
                                "${controller.birthday.value.year.toString()}-${controller.birthday.value.month.toString().padLeft(2, '0')}-${controller.birthday.value.day.toString().padLeft(2, '0')}",
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text('성별 (gender)'),
                            const SizedBox(height: 5,),
                            DropdownButton<UserGender?>(
                              value: controller.gender.value,
                              onChanged: (UserGender? newValue) {
                                controller.gender.value = newValue ?? UserGender.unknown;
                              },
                              items: [UserGender.male, UserGender.female, UserGender.unknown]
                                  .map<DropdownMenuItem<UserGender?>>((UserGender userGender) {
                                return DropdownMenuItem<UserGender?>(
                                  value: userGender,
                                  child: Text(
                                    {UserGender.male: '남성', UserGender.female: '여성', UserGender.unknown: '비공개'}[userGender]!,
                                  ),
                                );
                              }).toList(),
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 65),
                    if(controller.userAdditionalInfoViewLoginFailed.value)
                      const Text(
                        '입력하지 않은 정보가 있습니다. 다시 확인해주세요.',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.red,
                        ),
                      )
                    else
                      const SizedBox(height: 22),
                    Row(
                      children: [
                        Expanded(
                            child: ElevatedButton(
                                onPressed: () { controller.additionInfoConfirmBtn(context); },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                ),
                                child: const Text('완료',)
                            )
                        ),
                      ],
                    )
                  ],
                ),
              const SizedBox(height: 40,),
            ],
          ),
        ),
      ),
    ),
  );
}