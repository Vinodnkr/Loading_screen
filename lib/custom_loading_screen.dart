import 'package:flutter/material.dart';

/// A utility class to show and hide a customizable loading overlay.
///
/// Provides static methods [start] and [stop] to manage an overlay
/// on top of the current screen. The overlay can display a default
/// loader or a custom widget.
class OverlayLoadingProgress {
  static OverlayEntry? _overlay;

  /// Starts the overlay loading screen.
  ///
  /// [context] is required to get the current overlay.
  /// [barrierColor] sets the background color of the overlay.
  /// [widget] is an optional custom widget to show instead of the default loading screen.
  /// [color] is the color used in the default loader container.
  /// [gifOrImagePath] optionally shows an image or GIF in the overlay.
  /// [barrierDismissible] determines if tapping outside dismisses the overlay.
  /// [loadingWidth] sets the width/height of the default loading widget.
  /// [loadingText] sets the text below the loader in the default widget.
  static start(
    BuildContext context, {
    Color? barrierColor = Colors.black54,
    Widget? widget,
    Color color = Colors.black38,
    String? gifOrImagePath,
    bool barrierDismissible = true,
    double? loadingWidth,
    String loadingText = 'Saving changes. Please wait...',
  }) async {
    if (_overlay != null) return;

    // Default widget if none is provided
    final defaultWidget = Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: color,
              ),
              height: 100,
              width: 100,
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.purple,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                loadingText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    _overlay = OverlayEntry(
      builder: (BuildContext context) => _LoadingWidget(
        color: color,
        barrierColor: barrierColor,
        widget: widget ?? defaultWidget,
        gifOrImagePath: gifOrImagePath,
        barrierDismissible: barrierDismissible,
        loadingWidth: loadingWidth,
      ),
    );

    Overlay.of(context).insert(_overlay!);
  }

  /// Stops the overlay loading screen if it is currently visible.
  ///
  /// Does nothing if no overlay is active.
  static stop() {
    if (_overlay == null) return;
    _overlay!.remove();
    _overlay = null;
  }
}

/// Internal widget used by [OverlayLoadingProgress] to render
/// the overlay with optional custom content.
///
/// This widget is private and should not be used outside the library.
class _LoadingWidget extends StatelessWidget {
  final Widget? widget;
  final Color? color;
  final Color? barrierColor;
  final String? gifOrImagePath;
  final bool barrierDismissible;
  final double? loadingWidth;

  /// Creates an internal loading overlay widget.
  ///
  /// This widget is private and used by [OverlayLoadingProgress].
  const _LoadingWidget({
    Key? key,
    this.widget,
    this.color,
    this.barrierColor,
    this.gifOrImagePath,
    required this.barrierDismissible,
    this.loadingWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: barrierDismissible ? OverlayLoadingProgress.stop : null,
      child: Container(
        constraints: const BoxConstraints.expand(),
        color: barrierColor,
        child: GestureDetector(
          onTap: () {}, // Prevent taps from dismissing inner content
          child: Center(
            child: widget ??
                SizedBox.square(
                  dimension: loadingWidth ?? 50,
                  child: gifOrImagePath != null
                      ? Image.asset(gifOrImagePath!)
                      : const CircularProgressIndicator(strokeWidth: 3),
                ),
          ),
        ),
      ),
    );
  }
}


// type 1
  // //time bounded overlay loading screen
    //       OverlayLoadingProgress.start(
      //         context, );
  //  //Simulate a delay for demonstration purposes
             //       await Future.delayed(
             //           const Duration(seconds: 8));
             //       OverlayLoadingProgress.stop();
             //     },


// type 2
    // //to start the overlay in the function where you want to show it
      // OverlayLoadingProgress.start(context,
      //                                 loadingText:
      //                                     'Loading changes. Please wait...');

    // //stop the overlay in the function where you want to stop it
     // OverlayLoadingProgress.stop();