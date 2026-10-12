import 'package:flutter/material.dart';
import '../widgets/browser_header.dart';
import '../widgets/browser_bottom_bar.dart';
import 'my_applications_page.dart';
import 'admin_settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      body: Column(
        children: [
          Expanded(
            child: IndexedStack(
              index: _currentTabIndex,
              children: [
                _buildHomeTab(),
                _buildAppsTab(),
                _buildContactsTab(),
                const AdminSettingsPage(isTabMode: true),
              ],
            ),
          ),

          // Custom Bottom Navigation Bar matching prototype
          _buildBottomNavBar(),

          // Browser bottom navigation bar (< >)
          const BrowserBottomBar(),
        ],
      ),
    );
  }

  Widget _buildHomeTab() {
    return Column(
      children: [
        // Browser top header
        BrowserHeader(
          title: '首页',
          showBreadcrumb: false,
          onClose: () {},
          onMore: () {
            _showHomeMoreMenu(context);
          },
        ),

        // Scrollable content
        Expanded(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Blue Header Banner
                Stack(
                  children: [
                    Image.asset(
                      'assets/images/header_banner.png',
                      width: double.infinity,
                      height: 128,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 128,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF3370FF), Color(0xFF4C88FF)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: const Text(
                            '天府新区信息职业学院 | 智慧学工',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),

                // 2. Overlapping Card 1: 暂无消息通知 & 暂无收藏应用
                Transform.translate(
                  offset: const Offset(0, -22),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x0C000000),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Notification row
                        InkWell(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('暂无新通知'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          },
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.notifications_none_rounded,
                                  color: Color(0xFFF79A38),
                                  size: 21,
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  '暂无消息通知',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color(0xFF1F2329),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const Spacer(),
                                const Icon(
                                  Icons.chevron_right,
                                  size: 20,
                                  color: Color(0xFF8F959E),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Illustration of empty collection
                        Image.asset(
                          'assets/images/empty_illustration.png',
                          width: 175,
                          height: 125,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.dashboard_customize_outlined,
                              size: 80,
                              color: Color(0xFFC9CDD4),
                            );
                          },
                        ),

                        const SizedBox(height: 8),

                        const Text(
                          '暂无收藏应用',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF646A73),
                          ),
                        ),

                        const SizedBox(height: 4),

                        Padding(
                          padding: const EdgeInsets.only(bottom: 24),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _currentTabIndex = 1; // switch to Apps tab
                              });
                            },
                            child: RichText(
                              text: const TextSpan(
                                text: '请前往',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF8F959E),
                                ),
                                children: [
                                  TextSpan(
                                    text: '应用',
                                    style: TextStyle(
                                      color: Color(0xFF3370FF),
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  TextSpan(text: '收藏起来吧!'),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // 3. Card 2: 我的待办 / 我的申请 Quick Actions
                Transform.translate(
                  offset: const Offset(0, -10),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEEF4FF),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x06000000),
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Top row with 2 large action buttons
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                          child: Row(
                            children: [
                              // 我的待办
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => const MyApplicationsPage(),
                                      ),
                                    );
                                  },
                                  borderRadius: BorderRadius.circular(8),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/icon_daiban.png',
                                        width: 38,
                                        height: 38,
                                        fit: BoxFit.contain,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Container(
                                            width: 38,
                                            height: 38,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF3370FF),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: const Icon(Icons.assignment, color: Colors.white, size: 22),
                                          );
                                        },
                                      ),
                                      const SizedBox(width: 10),
                                      const Text(
                                        '我的待办',
                                        style: TextStyle(
                                          fontSize: 16.5,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF1F2329),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // 我的申请 (Primary target from user instructions)
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => const MyApplicationsPage(),
                                      ),
                                    );
                                  },
                                  borderRadius: BorderRadius.circular(8),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/icon_shenqing.png',
                                        width: 38,
                                        height: 38,
                                        fit: BoxFit.contain,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Container(
                                            width: 38,
                                            height: 38,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFFA8C16),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: const Icon(Icons.description, color: Colors.white, size: 22),
                                          );
                                        },
                                      ),
                                      const SizedBox(width: 10),
                                      const Text(
                                        '我的申请',
                                        style: TextStyle(
                                          fontSize: 16.5,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF1F2329),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Submenu row: 草稿 | 待阅 | 已阅 | 已办 | 参与
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
                          ),
                          child: Row(
                            children: [
                              _buildSubmenuItem('草稿'),
                              _buildSubmenuDivider(),
                              _buildSubmenuItem('待阅'),
                              _buildSubmenuDivider(),
                              _buildSubmenuItem('已阅'),
                              _buildSubmenuDivider(),
                              _buildSubmenuItem('已办'),
                              _buildSubmenuDivider(),
                              _buildSubmenuItem('参与'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // 4. Section: 通知公告
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '通知公告',
                        style: TextStyle(
                          fontSize: 17.5,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F2329),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('已加载全部最新公告'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        },
                        child: const Text(
                          '查看更多',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF3370FF),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Notice Card illustration
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x06000000),
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/images/notice_card.png',
                      width: double.infinity,
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 100,
                          color: Colors.white,
                          alignment: Alignment.center,
                          child: const Text(
                            '暂无最新公告内容',
                            style: TextStyle(color: Color(0xFF8F959E), fontSize: 13),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmenuItem(String title) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const MyApplicationsPage(),
            ),
          );
        },
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF4E5969),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSubmenuDivider() {
    return Container(
      width: 0.8,
      height: 14,
      color: const Color(0xFFE5E6EB),
    );
  }

  Widget _buildAppsTab() {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: BrowserHeader(
        title: '应用中心',
        showBreadcrumb: false,
        onClose: () => setState(() => _currentTabIndex = 0),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '学工常用应用',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2329),
                  ),
                ),
                const SizedBox(height: 16),
                GridView.count(
                  crossAxisCount: 4,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 12,
                  children: [
                    _buildGridAppItem('请假申请', Icons.directions_walk, const Color(0xFF3370FF), () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const MyApplicationsPage()),
                      );
                    }),
                    _buildGridAppItem('我的事务', Icons.assignment, const Color(0xFFFA8C16), () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const MyApplicationsPage()),
                      );
                    }),
                    _buildGridAppItem('宿舍管理', Icons.apartment, const Color(0xFF52C41A), null),
                    _buildGridAppItem('成绩查询', Icons.school, const Color(0xFF722ED1), null),
                    _buildGridAppItem('校园卡', Icons.credit_card, const Color(0xFF13C2C2), null),
                    _buildGridAppItem('评优评先', Icons.emoji_events, const Color(0xFFFADB14), null),
                    _buildGridAppItem('勤工助学', Icons.work, const Color(0xFFEB2F96), null),
                    _buildGridAppItem('后台管理', Icons.settings, const Color(0xFF1D39C4), () {
                      setState(() => _currentTabIndex = 3);
                    }),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridAppItem(String title, IconData icon, Color color, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap ??
          () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('正在打开 $title...'), duration: const Duration(seconds: 1)),
            );
          },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(fontSize: 12, color: Color(0xFF4E5969)),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildContactsTab() {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: BrowserHeader(
        title: '通讯录',
        showBreadcrumb: false,
        onClose: () => setState(() => _currentTabIndex = 0),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '部门联系人',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2329),
                  ),
                ),
                const SizedBox(height: 12),
                Material(
                  color: Colors.transparent,
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Color(0xFF3370FF),
                      child: Text('吴', style: TextStyle(color: Colors.white)),
                    ),
                    title: const Text('吴思雨 (辅导员)'),
                    subtitle: const Text('文化产业学院 2026级播音1班'),
                    trailing: const Icon(Icons.phone, color: Color(0xFF3370FF)),
                    onTap: () {},
                  ),
                ),
                const Divider(),
                Material(
                  color: Colors.transparent,
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Color(0xFF52C41A),
                      child: Text('学', style: TextStyle(color: Colors.white)),
                    ),
                    title: const Text('学生工作处'),
                    subtitle: const Text('办公电话：028-XXXXXXXX'),
                    trailing: const Icon(Icons.phone, color: Color(0xFF52C41A)),
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      height: 52,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color(0xFFEEEEEE), width: 0.5),
        ),
      ),
      child: Row(
        children: [
          _buildNavItem(0, '首页', Icons.home_rounded, Icons.home_outlined),
          _buildNavItem(1, '应用', Icons.assignment_rounded, Icons.assignment_outlined),
          _buildNavItem(2, '通讯录', Icons.contact_phone_rounded, Icons.contact_phone_outlined),
          _buildNavItem(3, '我的', Icons.person_rounded, Icons.person_outline_rounded),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, String label, IconData activeIcon, IconData inactiveIcon) {
    final isSelected = _currentTabIndex == index;
    final color = isSelected ? const Color(0xFF3370FF) : const Color(0xFF646A73);

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          setState(() {
            _currentTabIndex = index;
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSelected ? activeIcon : inactiveIcon,
              size: 22,
              color: color,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showHomeMoreMenu(BuildContext context) {
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
                leading: const Icon(Icons.admin_panel_settings, color: Color(0xFF3370FF)),
                title: const Text('进入后台管理中心 (修改所有字段)'),
                onTap: () {
                  Navigator.of(ctx).pop();
                  setState(() => _currentTabIndex = 3);
                },
              ),
              ListTile(
                leading: const Icon(Icons.assignment, color: Color(0xFFFA8C16)),
                title: const Text('查看我的申请列表'),
                onTap: () {
                  Navigator.of(ctx).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const MyApplicationsPage(),
                    ),
                  );
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
