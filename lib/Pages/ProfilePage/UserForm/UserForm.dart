import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserForm extends ConsumerWidget {
  const UserForm({super.key});

  @override
  Widget build(BuildContext build, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(10),
      ),
      width: 500,
      height: 500,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // 회원증 제목
          Center(
            child: Text(
              "회원증",
              style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 16),

          // 역할, 포인트, 길드, 발급 일자를 Table로 정리
          Table(
            border: TableBorder.all(color: Colors.white),
            children: [
              TableRow(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "역할",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "포인트",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "길드",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "발급 일자",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16),

          // 구분선
          Container(
            height: 1,
            color: Colors.white,
            margin: EdgeInsets.symmetric(vertical: 8),
          ),

          // 대회 경력 제목
          Center(
            child: Text(
              "대회 경력",
              style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 12),

          // S1, S2 구분
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // S1 (왼쪽)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "S1",
                        style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Flexible(
                        child: ListView(
                          children: [
                            Text(
                              "제 17회 리틀스노우 대회 우승",
                              style: TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "제 100회 SKO 준우승",
                              style: TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "제 14회 스프링 토너먼트 3위",
                              style: TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // 세로 구분선
                Container(
                  width: 1,
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(horizontal: 16),
                ),

                // S2 (오른쪽)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "S2",
                        style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Flexible(
                        child: ListView(
                          children: [
                            Text(
                              "대회 경력 없음",
                              style: TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
