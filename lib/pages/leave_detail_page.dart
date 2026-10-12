import 'package:flutter/material.dart';
import '../models/app_data_model.dart';
import '../services/storage_service.dart';
import '../widgets/browser_header.dart';
import '../widgets/browser_bottom_bar.dart';
import 'admin_settings_page.dart';

class LeaveDetailPage extends StatefulWidget {
  const LeaveDetailPage({super.key});

  @override
  State<LeaveDetailPage> createState() => _LeaveDetailPageState();
}

class _LeaveDetailPageState extends State<LeaveDetailPage> {
  final StorageService _storageService = StorageService();

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
      backgroundColor: Colors.white,
      appBar: BrowserHeader(
        title: '流程申请',
        showBreadcrumb: true,
        breadcrumbCurrent: null,
        breadcrumbParentTitle: '我的事务',
        onClose: () => Navigator.of(context).pop(),
        onBreadcrumbHome: () => Navigator.of(context).popUntil((r) => r.isFirst),
        onBreadcrumbParent: () => Navigator.of(context).pop(),
        onMore: () {
          _showActionMenu(context);
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Center Avatar
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 26, bottom: 20),
                      child: Image.asset(
                        'assets/images/avatar.png',
                        width: 90,
                        height: 98,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.account_circle,
                            size: 90,
                            color: Color(0xFFD6E4FF),
                          );
                        },
                      ),
                    ),
                  ),

                  // Section 1: 学生基本信息
                  _buildSectionHeader('学生基本信息'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        _buildStudentInfoRow('姓名：', data.studentName),
                        _buildStudentInfoRow('学号：', data.studentId),
                        _buildStudentInfoRow('性别：', data.gender),
                        _buildStudentInfoRow('学院：', data.college),
                        _buildStudentInfoRow('专业：', data.major),
                        _buildStudentInfoRow('班级：', data.className),
                        _buildStudentInfoRow('手机号码：', data.phone),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),

                  // Divider strip
                  Container(
                    height: 10,
                    color: const Color(0xFFF7F8FA),
                  ),

                  // Section 2: 请假信息（新）
                  _buildSectionHeader('请假信息（新）'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLeaveInfoRow('请假类型：', data.leaveType),
                        _buildLeaveInfoRow('请假去向：', data.leaveDestination),
                        _buildLeaveInfoRow('详细地址：', data.detailAddress),
                        _buildLeaveInfoRow('请假开始时间：', data.startTime),
                        _buildLeaveInfoRow('请假结束时间：', data.endTime),
                        _buildLeaveInfoRow('请假时长天：', data.duration),
                        _buildLeaveInfoRow('紧急联系人：', data.emergencyContact),
                        _buildLeaveInfoRow('紧急联系人电话：', data.emergencyPhone),
                        _buildLeaveInfoRow('请假理由：', data.leaveReason),
                        _buildLeaveInfoRow('附件：', data.attachment),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),

                  // Divider strip
                  Container(
                    height: 10,
                    color: const Color(0xFFF7F8FA),
                  ),

                  // Section 3: 办理进度
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 3.5,
                              height: 16,
                              decoration: BoxDecoration(
                                color: const Color(0xFF3370FF),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              '办理进度',
                              style: TextStyle(
                                fontSize: 16.5,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1F2329),
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('已是最新流程节点'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          },
                          child: const Text(
                            '查看流程图',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF3370FF),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Stepper Progress
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Column(
                      children: [
                        // Step 1: 申请
                        _buildTimelineNode(
                          isFirst: true,
                          isLast: false,
                          title: '申请',
                          time: data.timelineApplyTime,
                          subtitleLeft: data.studentName,
                          subtitleRight: data.timelineApplyAction,
                          isCompleted: true,
                        ),

                        // Step 2: 辅导员审核
                        _buildTimelineNode(
                          isFirst: false,
                          isLast: false,
                          title: '辅导员审核',
                          time: data.timelineAuditTime,
                          subtitleLeft: data.counselorName,
                          subtitleRight: data.timelineAuditDecision,
                          isCompleted: true,
                        ),

                        // Step 3: 结束
                        _buildTimelineNode(
                          isFirst: false,
                          isLast: true,
                          title: '结束',
                          time: '',
                          subtitleLeft: '',
                          subtitleRight: '',
                          isCompleted: true,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),

          // Bottom Browser Bar
          const BrowserBottomBar(),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      child: Row(
        children: [
          Container(
            width: 3.5,
            height: 16,
            decoration: BoxDecoration(
              color: const Color(0xFF3370FF),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16.5,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2329),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFF646A73),
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFF1F2329),
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeaveInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9.5),
      child: SizedBox(
        width: double.infinity,
        child: RichText(
          text: TextSpan(
            style: const TextStyle(
              fontSize: 15,
              height: 1.38,
            ),
            children: [
              TextSpan(
                text: label.endsWith(' ') ? label : '$label ',
                style: const TextStyle(
                  color: Color(0xFF646A73),
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextSpan(
                text: value,
                style: const TextStyle(
                  color: Color(0xFF1F2329),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimelineNode({
    required bool isFirst,
    required bool isLast,
    required String title,
    required String time,
    required String subtitleLeft,
    required String subtitleRight,
    required bool isCompleted,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left indicator circle & line
          SizedBox(
            width: 24,
            child: Column(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF3370FF),
                      width: 1.5,
                    ),
                    color: Colors.white,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.check,
                      size: 13,
                      color: Color(0xFF3370FF),
                    ),
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 1.5,
                      color: const Color(0xFF3370FF),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),

          // Right content
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF1F2329),
                        ),
                      ),
                      if (time.isNotEmpty)
                        Text(
                          time,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF8F959E),
                          ),
                        ),
                    ],
                  ),
                  if (subtitleLeft.isNotEmpty || subtitleRight.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          subtitleLeft,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF8F959E),
                          ),
                        ),
                        Text(
                          subtitleRight,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF3370FF),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
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
                title: const Text('进入后台修改此申请数据'),
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
