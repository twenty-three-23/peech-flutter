import 'package:flutter/material.dart';
import 'package:swm_peech_flutter/features/common/widgets/common_scaffold.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
        children:[ Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Container(
                alignment: Alignment.topLeft,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('닉네임',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                    Text(
                      "의 연습기록입니다.",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  ],
                )),
            SizedBox(height: 24),
            Container(
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                  color: Color(0xFFF4F6FA),
                  borderRadius: BorderRadius.circular(16)),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('총 12시간 20분 20초 사용 가능',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          IconButton(
                              icon: Icon(Icons.refresh), onPressed: () {}),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                      child: Text(
                        '1회 최대 15분 연습 가능',
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  ]),
            ),
            SizedBox(height: 60),
            Column(children: [
              Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "문의하기",
                    style: TextStyle(fontSize: 20, color: Color(0xFF3B3E43)),
                  ),
                  IconButton(
                      icon: const Icon(Icons.arrow_forward_ios),
                      onPressed: () {})
                ],
              )),
              SizedBox(height: 24),
              Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "이용 규칙",
                    style: TextStyle(fontSize: 20, color: Color(0xFF3B3E43)),
                  ),
                  IconButton(
                      icon: const Icon(Icons.arrow_forward_ios),
                      onPressed: () {})
                ],
              )),
            ]),
            SizedBox(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: TextButton(
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
                      child: Text(
                        '로그아웃',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xFFF4F6FA)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Container(
                  child: TextButton(
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
                      child: Text(
                        '회원 탈퇴',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xFFF4F6FA)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            TextButton(
                onPressed: () {},
                child: Container(
                    padding: const EdgeInsets.fromLTRB(180, 10, 180, 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Color(0xFFF4F6FA)),
                    child: Text(
                      "앱 버전 1.0.0",
                      style: TextStyle(fontSize: 20, color: Color(0xFF3B3E43)),
                    ),),),
          ],
        ),
      ]),
    );
  }
}
