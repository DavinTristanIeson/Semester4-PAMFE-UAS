import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../helpers/constants.dart';

mixin SnackbarMessenger {
  void sendMessage(BuildContext context, String message) {
    ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      messenger.showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(message),
      ));
    });
  }

  void sendError(BuildContext context, String message) {
    ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      messenger.showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(message,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            )),
        backgroundColor: COLOR_DANGER_CONTAINER,
      ));
    });
  }

  void sendSuccess(BuildContext context, String message) {
    ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      messenger.showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(message,
            style: const TextStyle(
              color: COLOR_SUCCESS,
              fontWeight: FontWeight.bold,
            )),
        backgroundColor: const Color.fromARGB(255, 226, 255, 230),
      ));
    });
  }
}

class LoadingComponent extends StatelessWidget {
  const LoadingComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          constraints: BoxConstraints.loose(const Size.square(100.0)),
          padding: const EdgeInsets.all(GAP_LG),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.0),
            color: COLOR_DARKEN_25,
          ),
          alignment: Alignment.center,
          child: const CircularProgressIndicator(color: COLOR_SECONDARY)),
    );
  }
}

class ErrorMessage extends StatelessWidget {
  final String reason;
  final Widget? child;
  const ErrorMessage({super.key, required this.reason, this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(GAP_LG),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.7),
        ),
        alignment: Alignment.center,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(
            Icons.error,
            color: COLOR_DANGER,
            size: 48,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: GAP_LG),
            child: Text(reason,
                style: const TextStyle(
                    color: COLOR_DANGER,
                    fontFamily: "Josefin Sans",
                    fontSize: 16)),
          ),
          if (child != null) child!
        ]),
      ),
    );
  }
}

class ErrorComponent extends StatelessWidget {
  final String? title;
  final String? reason;
  final Widget? child;
  const ErrorComponent({super.key, this.reason, this.child, this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(GAP_LG),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(BR_LARGE),
          color: Colors.black.withOpacity(0.5),
        ),
        alignment: Alignment.center,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(
            Icons.error,
            color: COLOR_DANGER,
            size: 48,
          ),
          Text(title ?? UNEXPECTED_ERROR,
              style: const TextStyle(
                  color: COLOR_DANGER,
                  fontWeight: FontWeight.bold,
                  fontSize: 18)),
          if (reason != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: GAP_LG),
              child: Text(reason!,
                  style: const TextStyle(color: COLOR_DANGER, fontSize: 16)),
            ),
          if (child != null) child!
        ]),
      ),
    );
  }
}
