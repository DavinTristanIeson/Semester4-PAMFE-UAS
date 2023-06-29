import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
  final XFile? image;
  final double? width;
  final double? height;
  const MaybeFileImage(
      {super.key,
      this.image,
      this.width = double.maxFinite,
      this.height = double.maxFinite});

  @override
  Widget build(BuildContext context) {
    return ImageContainer(
        child: image != null
            ? Image.file(File(image!.path),
                width: width, height: height, fit: BoxFit.cover)
            : const Center(
                child: Text("NO IMAGE",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: FS_LARGE,
                    )),
              ));
  }
}
