import 'dart:io';

import 'package:flutter/material.dart';

import '../../helpers/constants.dart';
import '../../helpers/styles.dart';

class ImageContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget child;
  const ImageContainer(
      {super.key,
      required this.child,
      this.width = double.maxFinite,
      this.height = double.maxFinite});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(GAP)),
          gradient: VGRADIENT_DISABLED_FADE),
      height: height,
      width: width,
      child: child,
    );
  }
}

class MaybeFileImage extends StatelessWidget {
  final File? image;
  final double? width;
  final double? height;
  const MaybeFileImage(
      {super.key,
      this.image,
      this.width = double.maxFinite,
      this.height = double.maxFinite});

  Widget buildNoImage() {
    return const Center(
      child: Text("NO IMAGE",
          style: TextStyle(
            color: Colors.black54,
            fontSize: FS_LARGE,
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (image == null) {
      return ImageContainer(child: buildNoImage());
    }
    return ImageContainer(
        width: width,
        height: height,
        child: FutureBuilder(
            future: image!.exists(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.active:
                  return const CircularProgressIndicator();
                case ConnectionState.none:
                  return buildNoImage();
                case ConnectionState.done:
                  if (snapshot.data!) {
                    return Image.file(File(image!.path),
                        width: width, height: height, fit: BoxFit.cover);
                  } else {
                    return buildNoImage();
                  }
              }
            }));
  }
}
