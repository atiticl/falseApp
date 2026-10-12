import 'package:flutter/material.dart';
import '../models/app_data_model.dart';
import '../services/storage_service.dart';
import '../widgets/browser_header.dart';
import '../widgets/browser_bottom_bar.dart';
import 'leave_detail_page.dart';
import 'admin_settings_page.dart';

class MyApplicationsPage extends StatefulWidget {
  const MyApplicationsPage({super.key});

  @override
  State<MyApplicationsPage> createState() => _MyApplicationsPageState();
}

class _MyApplicationsPageState extends State<MyApplicationsPage> {
  final StorageService _storageService = StorageService();
  int _selectedTabIndex = 1; // 1 is '我的申请'

  final List<String> _tabs = ['我的待办', '我的申请', '我的参与', '我的待阅'];

  @override
  void initState() {
    super.initState();
    _storageService.addListener(_onDataChanged);
  }

  @override
  void dispose() {
    _storageService.removeListener(_onDataChanged);
    super.dispose();
  }

  void _onDataChanged() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final data = _storageService.data;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: BrowserHeader(
        title: '我的事务',
        showBreadcrumb: true,
        breadcrumbCurrent: '我的事务',
        onClose: () => Navigator.of(context).pop(),
        onBreadcrumbHome: () => Navigator.of(context).pop(),
        onMore: () {
          _showActionMenu(context);
        },
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
            child: Container(
              height: 38,
              decoration: BoxDecoration(
                color: const Color(0xFFF2F3F5),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search,
                    size: 19,
                    color: Color(0xFF8F959E),
                  ),
                  SizedBox(width: 4),
                  Text(
                    '搜索',
                    style: TextStyle(
                      fontSize: 14.5,
                      color: Color(0xFF8F959E),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Tabs Row
          Container(
            color: Colors.white,
            height: 44,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xFFEEEEEE), width: 0.5),
              ),
            ),
            child: Row(
              children: List.generate(_tabs.length, (index) {
                final isSelected = _selectedTabIndex == index;
                return Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      setState(() {
                        _selectedTabIndex = index;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _tabs[index],
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                            color: isSelected
                                ? const Color(0xFF3370FF)
                                : const Color(0xFF1F2329),
                          ),
                        ),
                        const SizedBox(height: 4),
                        if (isSelected)
                          Container(
                            height: 2.5,
                            width: 38,
                            decoration: BoxDecoration(
                              color: const Color(0xFF3370FF),
                              borderRadius: BorderRadius.circular(1.5),
                            ),
                          )
                        else
                          const SizedBox(height: 2.5),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),

          // Content List
          Expanded(
            child: _selectedTabIndex == 1
                ? _buildApplicationsList(data)
                : _buildEmptyTabContent(),
          ),

          // Bottom Browser Bar
          const BrowserBottomBar(),
        ],
      ),
    );
  }

  Widget _buildEmptyTabContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 12),
          Text(
            '暂无${_tabs[_selectedTabIndex]}数据',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildApplicationsList(AppDataModel data) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      children: [
        // Card 1 (Main leave record with editable details)
        _buildApplicationCard(
          title: '请假流程(新)',
          applyTime: data.appTime1,
          isPassed: data.statusCard1 == '已通过',
          currentNode: data.statusCard1 == '已通过' ? null : '辅导员审核',
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const LeaveDetailPage()),
            );
          },
        ),

        const SizedBox(height: 12),

        // Card 2
        _buildApplicationCard(
          title: '请假流程(新)',
          applyTime: data.appTime2,
          isPassed: true,
          currentNode: null,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const LeaveDetailPage()),
            );
          },
        ),

        const SizedBox(height: 12),

        // Card 3
        _buildApplicationCard(
          title: '请假流程(新)',
          applyTime: data.appTime3,
          isPassed: false,
          currentNode: '辅导员审核',
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const LeaveDetailPage()),
            );
          },
        ),

        const SizedBox(height: 12),

        // Card 4
        _buildApplicationCard(
          title: '请假流程(新)',
          applyTime: data.appTime4,
          isPassed: false,
          currentNode: '辅导员审核',
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const LeaveDetailPage()),
            );
          },
        ),

        const SizedBox(height: 36),

        // Footer: 到底了...
        const Center(
          child: Text(
            '到底了...',
            style: TextStyle(
              fontSize: 13.5,
              color: Color(0xFF8F959E),
              letterSpacing: 0.5,
            ),
          ),
        ),

        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildApplicationCard({
    required String title,
    required String applyTime,
    required bool isPassed,
    String? currentNode,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onTap,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F2329),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '申请时间： $applyTime',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF646A73),
                      ),
                    ),
                    if (currentNode != null) ...[
                      const SizedBox(height: 6),
                      RichText(
                        text: TextSpan(
                          text: '当前节点：',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF646A73),
                          ),
                          children: [
                            TextSpan(
                              text: currentNode,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF3370FF),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              // Stamp '已通过'
              if (isPassed)
                Positioned(
                  right: 14,
                  top: 10,
                  child: Image.asset(
                    'assets/images/stamp_passed.png',
                    width: 76,
                    height: 76,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFF52C41A), width: 1.5),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          '已通过',
                          style: TextStyle(
                            color: Color(0xFF52C41A),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showActionMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.settings, color: Color(0xFF3370FF)),
                title: const Text('进入后台修改申请记录数据'),
                onTap: () {
                  Navigator.of(ctx).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const AdminSettingsPage(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.refresh, color: Color(0xFF646A73)),
                title: const Text('刷新页面'),
                onTap: () {
                  Navigator.of(ctx).pop();
                  setState(() {});
                },
              ),
              ListTile(
                leading: const Icon(Icons.close, color: Color(0xFF8F959E)),
                title: const Text('取消'),
                onTap: () => Navigator.of(ctx).pop(),
              ),
            ],
          ),
        );
      },
    );
  }
}
