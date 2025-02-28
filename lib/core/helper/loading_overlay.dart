import 'package:flutter/material.dart';
import 'package:foxShop/core/constants/app_colors.dart';
import 'package:foxShop/core/constants/app_space.dart';
import 'package:foxShop/core/helper/helper.dart';
import 'package:foxShop/presentation/screens/success/success_screen.dart';

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
          Center(
            child: Container(
              alignment: Alignment.center,
              width: 100.scale,
              height: 100.scale,
              padding: EdgeInsets.all(appPedding),
              decoration: BoxDecoration(
                color: appWhite,
                borderRadius: BorderRadius.circular(appRadius.scale),
              ),
              child: centerLoading(),
            ),
          ),
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
