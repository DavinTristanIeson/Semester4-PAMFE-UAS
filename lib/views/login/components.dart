import 'dart:math';

import 'package:flutter/material.dart';
import 'package:memoir/helpers/constants.dart';
import 'package:memoir/helpers/styles.dart';

class FadedCircle extends StatefulWidget {
  final double radius;
  final double xOrigin;
  final double yOrigin;
  final double xMotion;
  final double yMotion;
  final Duration duration;
  const FadedCircle(
      {super.key,
      required this.radius,
      this.xMotion = 64.0,
      this.yMotion = 64.0,
      required this.xOrigin,
      required this.yOrigin,
      required this.duration});

  @override
  State<FadedCircle> createState() => _FadedCircleState();
}

class _FadedCircleState extends State<FadedCircle>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animation;
  @override
  void initState() {
    _animation = AnimationController(vsync: this)
      ..repeat(period: widget.duration);
    super.initState();
  }

  @override
  void dispose() {
    _animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animation,
        child: Container(
          decoration: BoxDecoration(
            color: COLOR_FADED_25,
            borderRadius: BorderRadius.circular(widget.radius / 2),
          ),
          width: widget.radius,
          height: widget.radius,
        ),
        builder: (context, child) {
          return Positioned(
            left: widget.xOrigin +
                cos(_animation.value * 2 * pi) * widget.xMotion,
            top: widget.yOrigin +
                sin(_animation.value * 2 * pi) * widget.yMotion,
            child: child!,
          );
        });
  }
}

class LoginPageGradientBackground extends StatelessWidget {
  final Widget child;
  final double? paddingTop;
  const LoginPageGradientBackground(
      {super.key, required this.child, this.paddingTop});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      decoration: const BoxDecoration(gradient: VGRADIENT_PRIMARY_FADE),
      child: Stack(
        children: [
          FadedCircle(
              radius: 200.0,
              xOrigin: width * 0.6,
              yOrigin: height * 0.1,
              duration: const Duration(seconds: 10)),
          FadedCircle(
              radius: 400.0,
              xOrigin: width * 0.2,
              yMotion: 100.0,
              xMotion: 250.0,
              yOrigin: height * 0.6,
              duration: const Duration(seconds: 7)),
          FadedCircle(
              radius: 300.0,
              xOrigin: width * 0.1,
              xMotion: -80.0,
              yOrigin: height * 0.3,
              duration: const Duration(seconds: 8)),
          Padding(
              padding:
                  const EdgeInsets.all(GAP).copyWith(top: paddingTop ?? GAP),
              child: SingleChildScrollView(child: child)),
        ],
      ),
    );
  }
}

class LoginPageFormContainer extends StatelessWidget {
  final Widget child;
  const LoginPageFormContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    const BorderSide THIN =
        BorderSide(color: Color.fromRGBO(0, 0, 0, 0.05), width: 1.5);
    const BorderSide THICK =
        BorderSide(color: Color.fromRGBO(0, 0, 0, 0.05), width: 5);
    return Container(
        decoration: const BoxDecoration(
            color: COLOR_FADED_25,
            border: Border(
              top: THIN,
              left: THIN,
              right: THIN,
              bottom: THICK,
            ),
            borderRadius: BorderRadius.all(Radius.circular(BR_LARGE))),
        padding: const EdgeInsets.all(GAP_LG),
        child: child);
  }
}
