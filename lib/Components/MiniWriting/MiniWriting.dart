import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MiniWriting extends ConsumerStatefulWidget {
  MiniWriting({super.key});



  @override
  _MiniWritingState createState() => _MiniWritingState();
}

class _MiniWritingState extends ConsumerState<MiniWriting>{

  @override
  Widget build(BuildContext context) {
    GlobalKey titleKey = GlobalKey();
    GlobalKey descKey = GlobalKey();


     return Container(
       width: 200,
       height: 400,
       decoration: BoxDecoration(
         border: Border.all(width: 1)
       ),
       child: Form(
         child: Column(
           children: [
             TextFormField(
               key: titleKey,

             ),
             TextFormField(
               key: descKey,

             )
           ],
         )
       ),
     );
  }
}