import 'package:flutter/cupertino.dart';

class KeyboardListenerCheck extends WidgetsBindingObserver {
  final VoidCallback onKeyboardOpened;
  final VoidCallback onKeyboardClosed;
  final BuildContext context;

  KeyboardListenerCheck({required this.onKeyboardOpened, required this.onKeyboardClosed, required this.context});

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
      if (keyboardOpen) {
        onKeyboardOpened();
      } else {
        onKeyboardClosed();
      }
    });
  }
}