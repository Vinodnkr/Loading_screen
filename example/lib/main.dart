import 'package:flutter/material.dart';
import 'package:custom_loading_screen/custom_loading_screen.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Loading Screen Example',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Custom Loading Screen Demo')),
        body: const LoadingDemo(),
      ),
    );
  }
}

class LoadingDemo extends StatelessWidget {
  const LoadingDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () async {
                // Show default loading overlay
                OverlayLoadingProgress.start(
                  context,
                  loadingText: 'Loading default overlay...',
                );

                // Simulate some async work
                await Future.delayed(const Duration(seconds: 3));

                // Hide overlay
                OverlayLoadingProgress.stop();
              },
              child: const Text('Show Default Loading'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Show custom loading overlay
                OverlayLoadingProgress.start(
                  context,
                  widget: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        CircularProgressIndicator(color: Colors.orange),
                        SizedBox(height: 10),
                        Text(
                          'Custom Loader...',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  barrierDismissible: false,
                );

                // Simulate async task
                await Future.delayed(const Duration(seconds: 3));

                // Stop overlay
                OverlayLoadingProgress.stop();
              },
              child: const Text('Show Custom Loading'),
            ),
          ],
        ),
      );
    });
  }
}
