import 'package:flutter/material.dart';
import 'package:wafer/core/utils/styles.dart';
import 'package:wafer/features/posts/presentation/views/widgets/custom_card.dart';

class PostsView extends StatelessWidget {
  const PostsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body:
      //  SafeArea(
      // child: Column(
      //   crossAxisAlignment: CrossAxisAlignment.end,
      //   children: [
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.end,
      //         children: [
      //           Text(
      //             'المنشــــــورات',
      //             style: Styles.textStyle30.copyWith(
      //               fontWeight: FontWeight.bold,
      //             ),
      //           ),
      //           Spacer(),
      //           Icon(Icons.search, size: 30, color: Colors.black),
      //         ],
      //       ),
      //     ),
      //     CustomCard(
      //       imagePath: 'assets/images/test.png',
      //       title: 'طلب مساعدة في الرياضيات',
      //       text:
      //           'أحتاج إلى مساعدة في حل مسائل الرياضيات للصف العاشر. هل يمكن لأحد مساعدتي؟',
      //     ),
      //     CustomCard(
      //       imagePath: 'assets/images/test.png',
      //       title: 'عرض دروس خصوصية في الفيزياء',
      //       text:
      //           'أنا طالب في الجامعة وأقدم دروس خصوصية في الفيزياء. إذا كنت مهتمًا، يرجى التواصل معي.  ',
      //     ),
      //   ],
      // ),
      // ),
    );
  }
}
