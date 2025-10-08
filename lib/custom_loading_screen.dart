import 'package:flutter/material.dart';

class OverlayLoadingProgress {
  static OverlayEntry? _overlay;

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
                color: Colors.black38,
              ),
              height: 100,
              width: 100,
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                // color: Colors.black38,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: Text(
                loadingText,
                textAlign: TextAlign.center,
                style: TextStyle(
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

    _overlay = OverlayEntry(builder: (BuildContext context) {
      return _LoadingWidget(
        color: color,
        barrierColor: barrierColor,
        widget: widget ?? defaultWidget,
        gifOrImagePath: gifOrImagePath,
        barrierDismissible: barrierDismissible,
        loadingWidth: loadingWidth,
      );
    });
    Overlay.of(context).insert(_overlay!);
  }

  static stop() {
    if (_overlay == null) return;
    _overlay!.remove();
    _overlay = null;
  }
}

class _LoadingWidget extends StatelessWidget {
  final Widget? widget;
  final Color? color;
  final Color? barrierColor;
  final String? gifOrImagePath;
  final bool barrierDismissible;
  final double? loadingWidth;
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
          onTap: () {},
          child: Center(
            child: widget ??
                SizedBox.square(
                  dimension: loadingWidth,
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