import 'package:flutter/material.dart';
import 'package:custom_loading_screen/custom_loading_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Loading Screen Demo',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Custom Loading Example')),
        body: Builder(
          builder: (context) => Center(
            child: ElevatedButton(
              onPressed: () async {
                OverlayLoadingProgress.start(
                  context,
                  loadingText: 'Loading... Please wait.',
                );

                await Future.delayed(const Duration(seconds: 2));
                OverlayLoadingProgress.stop();
              },
              child: const Text('Show Loading Screen'),
            ),
          ),
        ),
      ),
    );
  }
}
