import 'dart:io';

import 'package:flutter/material.dart';
import 'package:memoir/components/display/info.dart';

import '../../helpers/constants.dart';
import '../../helpers/styles.dart';

class ImageContainer extends StatelessWidget {
  final Widget? child;
  const ImageContainer({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(GAP)),
          gradient: VGRADIENT_DISABLED_FADE),
      child: child,
    );
  }
}

class MaybeFileImage extends StatelessWidget {
  final File? image;
  final BoxFit fit;
  final Widget? emptyWidget;
  const MaybeFileImage(
      {super.key, this.image, this.fit = BoxFit.cover, this.emptyWidget});

  @override
  Widget build(BuildContext context) {
    if (image == null) {
      return ImageContainer(child: emptyWidget);
    }
    return ImageContainer(
        child: FutureBuilder(
            future: image!.exists(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.active:
                  return const LoadingComponent();
                case ConnectionState.none:
                  return emptyWidget ?? Container();
                case ConnectionState.done:
                  if (snapshot.data!) {
                    return Image.file(File(image!.path), fit: fit);
                  } else {
                    return emptyWidget ?? Container();
                  }
              }
            }));
  }
}
