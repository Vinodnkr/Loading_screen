Custom Loading Screen

A simple and customizable Flutter overlay loading screen for showing progress indicators with optional text, images, and custom widgets. Ideal for loading, saving, or uploading states in your app.

Features

Easy to start and stop with one line of code

Supports custom widgets, text, and colors

Optional barrier dismissible behavior

Installation

Add the package to your pubspec.yaml:

dependencies:
custom_loading_screen:
git:
url: https://github.com/<your-username>/custom_loading_screen.git

Then run:

flutter pub get

Usage
import 'package:flutter/material.dart';
import 'package:custom_loading_screen/custom_loading_screen.dart';

ElevatedButton(
onPressed: () async {
// Show the loading screen
OverlayLoadingProgress.start(
context,
loadingText: 'Loading... Please wait.',
);

    // Simulate a task
    await Future.delayed(const Duration(seconds: 2));

    // Hide the loading screen
    OverlayLoadingProgress.stop();

},
child: const Text('Show Loading Screen'),
)

Notes

Ensure the context passed to start() has an Overlay (usually from a Scaffold or Builder widget).

You can provide a custom widget or GIF by passing the widget or gifOrImagePath parameters.
