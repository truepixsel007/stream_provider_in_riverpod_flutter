import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:r6/stream_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(stockPriceProvider);
    return Scaffold(
      appBar: AppBar(title: Text('Stream Provider')),
      body: Consumer(
        builder: (context, ref, child) {
          return Center(
            child: provider.when(
              skipLoadingOnRefresh: true,
              data: (price) => Text(price.toStringAsFixed(2).toString()),
              loading: () => CircularProgressIndicator(),
              // error: (error,stack) => Text('Error : $error'),
              error:
                  (error, stack) => TextButton(
                    onPressed: () {
                      ref.invalidate(stockPriceProvider);
                    },
                    child: Text('button'),
                  ),
            ),
          );
        },
      ),
    );
  }
}
