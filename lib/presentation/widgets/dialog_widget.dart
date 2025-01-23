import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class DialogFactory {
  Widget build({
    required String title,
    required String content,
    String cancelText = "cancel",
    String confirmText = "confirm",
    Function()? onCancel,
    Function()? onConfirm,
  });

  static DialogFactory createDialogFactory() {
    if (Platform.isAndroid) {
      return AndroidDialogFactory();
    } else if (Platform.isIOS) {
      return IOSDialogFactory();
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}

class AndroidDialogFactory extends DialogFactory {
  @override
  Widget build({
    required String title,
    required String content,
    String cancelText = "cancel",
    String confirmText = "confirm",
    Function()? onCancel,
    Function()? onConfirm,
  }) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: onCancel,
          child: Text(cancelText),
        ),
        TextButton(
          onPressed: onConfirm,
          child: Text(confirmText),
        ),
      ],
    );
  }
}

class IOSDialogFactory extends DialogFactory {
  @override
  Widget build({
    required String title,
    required String content,
    String cancelText = "cancel",
    String confirmText = "confirm",
    Function()? onCancel,
    Function()? onConfirm,
  }) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        CupertinoActionSheetAction(
          onPressed: () => onCancel,
          child: Text(cancelText),
        ),
        CupertinoActionSheetAction(
          onPressed: () => onConfirm,
          child: Text(confirmText),
        ),
      ],
    );
  }
}
