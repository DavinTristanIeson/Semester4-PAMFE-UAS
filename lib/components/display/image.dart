import 'dart:io';

import 'package:flutter/material.dart';
import 'package:memoir/components/display/info.dart';

import '../../helpers/constants.dart';
import '../../helpers/styles.dart';

class ImageContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget child;
  const ImageContainer(
      {super.key, required this.child, this.width, this.height});

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
  final BoxFit fit;
  const MaybeFileImage(
      {super.key,
      this.image,
      this.width,
      this.height,
      this.fit = BoxFit.cover});

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
                  return const LoadingComponent();
                case ConnectionState.none:
                  return buildNoImage();
                case ConnectionState.done:
                  if (snapshot.data!) {
                    return Image.file(File(image!.path),
                        width: width, height: height, fit: fit);
                  } else {
                    return buildNoImage();
                  }
              }
            }));
  }
}
