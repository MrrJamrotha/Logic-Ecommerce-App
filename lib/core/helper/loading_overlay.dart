import 'package:flutter/material.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/presentation/screens/success/success_screen.dart';

class LoadingOverlay {
  static OverlayEntry? _overlayEntry;

  static void show(BuildContext context) {
    if (_overlayEntry != null) return; // Prevent multiple overlays

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          ModalBarrier(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.5),
            dismissible: false,
          ),
          centerLoading(),
        ],
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  static void showPlaceOrderSuccess(BuildContext context) {
    if (_overlayEntry != null) return; // Prevent multiple overlays

    _overlayEntry = OverlayEntry(
      builder: (context) => SuccessScreen(),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  static void hide() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
