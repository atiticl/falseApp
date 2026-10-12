import 'package:flutter/material.dart';

class BrowserBottomBar extends StatelessWidget {
  final VoidCallback? onBack;
  final VoidCallback? onForward;

  const BrowserBottomBar({
    super.key,
    this.onBack,
    this.onForward,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: const BoxDecoration(
        color: Color(0xFFF7F8FA),
        border: Border(
          top: BorderSide(color: Color(0xFFE5E6EB), width: 0.5),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onBack ??
                  () {
                    if (Navigator.of(context).canPop()) {
                      Navigator.of(context).pop();
                    }
                  },
              child: const SizedBox(
                width: 90,
                height: 48,
                child: Center(
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    size: 20,
                    color: Color(0xFF4E5969),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 60),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onForward,
              child: const SizedBox(
                width: 90,
                height: 48,
                child: Center(
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                    color: Color(0xFFC9CDD4),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
