import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/ConstPadding.dart';
import '../../../../core/constants/ConstSize.dart';
import '../state/Notifier/friendly_match_notifier.dart';
import 'SubmitButton.dart';

class ViewFriendlyMatch extends ConsumerStatefulWidget {
  final double width;

  const ViewFriendlyMatch({
    super.key,
    required this.width
  });

  @override
  ConsumerState<ViewFriendlyMatch> createState() => _ViewFriendlyMatchState();
}

class _ViewFriendlyMatchState extends ConsumerState<ViewFriendlyMatch> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(friendlyMatchProvider);

    return SizedBox(
      width: widget.width,
      child: Container(
          padding: ConstPadding.bigPaddingAll,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("섀버 별자리 Cafe",
                          style: TextStyle(
                            fontWeight: FontWeight.bold, // 볼드체
                          )
                      ),
                      Text("${state.sender}님의 친선"),
                    ],
                  ),
                  Spacer(),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.asset(
                      "assets/icons/main_icon.jpg",
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
              Text("Version",
                  style: TextStyle(
                    fontWeight: FontWeight.bold, // 볼드체
                  )
              ),
              Text(state.version),
              Text("Mode",
                  style: TextStyle(
                    fontWeight: FontWeight.bold, // 볼드체
                  )
              ),
              Text(state.mode),
              Text("Platform",
                  style: TextStyle(
                    fontWeight: FontWeight.bold, // 볼드체
                  )
              ),
              Text(state.platform),
              Text("Room",
                  style: TextStyle(
                    fontWeight: FontWeight.bold, // 볼드체
                  )
              ),
              Text(state.roomNumber),
              if (state.message.isNotEmpty) ...[
                Text("Message",
                    style: TextStyle(
                      fontWeight: FontWeight.bold, // 볼드체
                    )
                ),
                Text(state.message)
              ],
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "* 친선모집 방법 : 빗자루의 /친선모집 명령어나 인게임 모집글을 복사해서 붙여넣으세요 !",
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: ConstSize.bigWidth),
                  SubmitButton()
                ],
              )
            ],
          )
      ),
    );
  }
}