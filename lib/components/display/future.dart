import 'package:flutter/widgets.dart';

import 'info.dart';

class AsyncRender<T> extends StatelessWidget {
  final Future<T> future;
  final Widget? loadingComponent;
  final Widget Function(BuildContext, String)? errorBuilder;
  final Widget Function(BuildContext context, T? data) builder;
  const AsyncRender(
      {super.key,
      required this.builder,
      required this.future,
      this.loadingComponent,
      this.errorBuilder});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const LoadingComponent();
          }
          if (snapshot.hasError) {
            return ErrorComponent(reason: snapshot.error.toString());
          }
          return builder(context, snapshot.data);
        });
  }
}
