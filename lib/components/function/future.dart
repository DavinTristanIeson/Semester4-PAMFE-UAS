import 'dart:async';

import 'package:flutter/material.dart';
import 'package:memoir/components/display/info.dart';
import 'package:objectbox/objectbox.dart';

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

class QueryObserver<T> extends StatefulWidget {
  final QueryBuilder<T> query;
  final Widget Function(BuildContext, List<T>) builder;
  const QueryObserver({super.key, required this.query, required this.builder});

  @override
  State<QueryObserver<T>> createState() => _QueryObserverState<T>();
}

class _QueryObserverState<T> extends State<QueryObserver<T>> {
  List<T>? data;
  late Stream<Query<T>> stream;
  late Query<T> query;
  late StreamSubscription _subscription;

  void listenToQuery() {
    stream = widget.query.watch(triggerImmediately: true);
    _subscription = stream.listen((event) async {
      query = event;
      final tempData = await event.findAsync();
      setState(() => data = tempData);
    });
  }

  @override
  void initState() {
    listenToQuery();
    super.initState();
  }

  @override
  void dispose() {
    query.close();
    _subscription.cancel();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant QueryObserver<T> oldWidget) {
    if (oldWidget.query != widget.query) {
      _subscription.cancel();
      listenToQuery();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return data == null
        ? const LoadingComponent()
        : widget.builder(context, data!);
  }
}
