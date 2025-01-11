import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewCustom extends StatelessWidget {
  final String url;
  const PhotoViewCustom({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PhotoView(
          imageProvider: NetworkImage(url),
        ),
        Positioned(
          right: 16,
          top: 40,
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.close,
                weight: 4,
              ),
            ),
          ),
        )
      ],
    );
  }
}
