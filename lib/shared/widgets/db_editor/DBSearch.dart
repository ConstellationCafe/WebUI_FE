// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../../../data/DBEditorTest/DBController.dart';
// // import '../../../data/DBEditor/DBcontroller.dart';
//
// class DBSearch extends ConsumerStatefulWidget {
//   final DBController controller;
//
//   const DBSearch({super.key, required this.controller});
//
//   @override ConsumerState<DBSearch> createState() => _DBSearchState();
// }
//
// class _DBSearchState extends ConsumerState<DBSearch> {
//   final TextEditingController controller = TextEditingController();
//   final inputRegex = RegExp(r"^\s*(\w+)\s*=\s*'(.*)'\s*$");
//
//   bool checkValidateInput(String text) {
//     return inputRegex.hasMatch(text);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 60,
//       child: TextFormField(
//         controller: controller,
//         style: const TextStyle(
//           color: Colors.black,
//           fontSize: 16,
//           fontWeight: FontWeight.w400,
//         ),
//         decoration: InputDecoration(
//           filled: false,
//           contentPadding: const EdgeInsets.symmetric(
//             horizontal: 16,
//             vertical: 14,
//           ),
//           border: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Colors.grey[700]!,
//               width: 1,
//             ),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Colors.grey[700]!,
//               width: 1,
//             ),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Colors.blue[300]!,
//               width: 2,
//             ),
//           ),
//           errorBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Theme.of(context).colorScheme.onError,
//               width: 1,
//             ),
//           ),
//           focusedErrorBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Theme.of(context).colorScheme.onError,
//               width: 2,
//             ),
//           ),
//         ),
//         onFieldSubmitted: (value) {
//           if (value.trim().isEmpty) {
//             // 빈칸 입력 시 필터 초기화
//             setState(() {
//               controller.clear();
//               widget.controller.clearFilter();
//             });
//             return;
//           }
//           else if (checkValidateInput(value)) {
//             setState(() {
//               controller.text = value;
//               final match = inputRegex.firstMatch(value);
//               final key = match!.group(1)!;
//               final optionValue = match.group(2)!;
//               widget.controller.filter(key, optionValue);
//             });
//           }
//           else {
//             setState(() {
//               controller.clear(); // 텍스트 초기화
//             });
//             ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(
//                   content: Text("입력 형식이 잘못되었습니다. key='value' 형식으로 입력해주세요."),
//                   duration: Duration(seconds: 2),
//                 )
//             );
//             setState(() {
//               controller.clear();
//             });
//           }
//         },
//       ),
//     );
//   }
// }