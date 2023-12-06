import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class OnBoardPages extends StatelessWidget {
  const OnBoardPages({
    Key? key,
    required this.imgUrl,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

  final String imgUrl;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: AssetImage(imgUrl),
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 30),
            ),
            Text(
              " -- $subTitle --",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 17
              ),
            )
          ],
        ),
      ),
    );
  }
}
