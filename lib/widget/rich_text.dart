import 'package:flutter/material.dart';
import '../resources/resources.dart';

class TextRich extends StatelessWidget {
  const TextRich({
    super.key,
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 200),
      child: RichText(
        text: TextSpan(
          text: title,
          style: TextStyle(color: ColorManager.blackColor, fontSize: 13, fontWeight: FontWeight.bold),
          children: <TextSpan>[
            TextSpan(
              text: '\t $description',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ),
    );
  }
}
