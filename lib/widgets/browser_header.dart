import 'package:flutter/material.dart';

class BrowserHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onClose;
  final VoidCallback? onMore;
  final bool showBreadcrumb;
  final String? breadcrumbCurrent;
  final VoidCallback? onBreadcrumbHome;
  final VoidCallback? onBreadcrumbParent;
  final String? breadcrumbParentTitle;

  const BrowserHeader({
    super.key,
    required this.title,
    this.onClose,
    this.onMore,
    this.showBreadcrumb = false,
    this.breadcrumbCurrent,
    this.onBreadcrumbHome,
    this.onBreadcrumbParent,
    this.breadcrumbParentTitle,
  });

  @override
  Size get preferredSize => Size.fromHeight(showBreadcrumb ? 92 : 54);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        bottom: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Browser top navigation bar
            Container(
              height: 52,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color(0xFFEEEEEE), width: 0.5),
                ),
              ),
              child: Row(
                children: [
                  // Close button
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: onClose ?? () => Navigator.of(context).maybePop(),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      child: const Icon(
                        Icons.close,
                        size: 22,
                        color: Color(0xFF222222),
                      ),
                    ),
                  ),
                  // Title & URL
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1F2329),
                            letterSpacing: 0.2,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 1),
                        const Text(
                          'cas.tficedu.com',
                          style: TextStyle(
                            fontSize: 10.5,
                            color: Color(0xFF8F959E),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // More menu
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: onMore,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      child: const Icon(
                        Icons.more_horiz,
                        size: 24,
                        color: Color(0xFF222222),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Breadcrumbs if enabled
            if (showBreadcrumb)
              Container(
                height: 38,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                color: const Color(0xFFF7F8FA),
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 15,
                      color: Color(0xFF3370FF),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: onBreadcrumbHome ??
                          () {
                            Navigator.of(context).popUntil((r) => r.isFirst);
                          },
                      child: const Text(
                        '首页',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF3370FF),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    if (breadcrumbParentTitle != null) ...[
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: Icon(
                          Icons.chevron_right,
                          size: 16,
                          color: Color(0xFF8F959E),
                        ),
                      ),
                      GestureDetector(
                        onTap: onBreadcrumbParent ??
                            () {
                              Navigator.of(context).maybePop();
                            },
                        child: Text(
                          breadcrumbParentTitle!,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF1F2329),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                    if (breadcrumbCurrent != null) ...[
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: Icon(
                          Icons.chevron_right,
                          size: 16,
                          color: Color(0xFF8F959E),
                        ),
                      ),
                      Text(
                        breadcrumbCurrent!,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF1F2329),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
