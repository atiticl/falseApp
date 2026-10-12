import 'package:flutter/material.dart';
import '../models/app_data_model.dart';
import '../services/storage_service.dart';
import 'my_applications_page.dart';
import 'leave_detail_page.dart';

class AdminSettingsPage extends StatefulWidget {
  final bool isTabMode;

  const AdminSettingsPage({
    super.key,
    this.isTabMode = false,
  });

  @override
  State<AdminSettingsPage> createState() => _AdminSettingsPageState();
}

class _AdminSettingsPageState extends State<AdminSettingsPage> {
  final StorageService _storageService = StorageService();

  // Form controllers
  // 申请列表时间
  late TextEditingController _appTime1Ctrl;
  late TextEditingController _appTime2Ctrl;
  late TextEditingController _appTime3Ctrl;
  late TextEditingController _appTime4Ctrl;

  // 学生基本信息
  late TextEditingController _studentNameCtrl;
  late TextEditingController _studentIdCtrl;
  late TextEditingController _genderCtrl;
  late TextEditingController _collegeCtrl;
  late TextEditingController _majorCtrl;
  late TextEditingController _classNameCtrl;
  late TextEditingController _phoneCtrl;

  // 请假信息
  late TextEditingController _leaveTypeCtrl;
  late TextEditingController _leaveDestinationCtrl;
  late TextEditingController _detailAddressCtrl;
  late TextEditingController _startTimeCtrl;
  late TextEditingController _endTimeCtrl;
  late TextEditingController _durationCtrl;
  late TextEditingController _emergencyContactCtrl;
  late TextEditingController _emergencyPhoneCtrl;
  late TextEditingController _leaveReasonCtrl;
  late TextEditingController _attachmentCtrl;

  // 办理进度及辅导员审核
  late TextEditingController _counselorNameCtrl;
  late TextEditingController _timelineApplyTimeCtrl;
  late TextEditingController _timelineApplyActionCtrl;
  late TextEditingController _timelineAuditTimeCtrl;
  late TextEditingController _timelineAuditDecisionCtrl;

  String _statusCard1 = '已通过';

  @override
  void initState() {
    super.initState();
    _loadControllersFromData(_storageService.data);
  }

  void _loadControllersFromData(AppDataModel data) {
    _appTime1Ctrl = TextEditingController(text: data.appTime1);
    _appTime2Ctrl = TextEditingController(text: data.appTime2);
    _appTime3Ctrl = TextEditingController(text: data.appTime3);
    _appTime4Ctrl = TextEditingController(text: data.appTime4);

    _studentNameCtrl = TextEditingController(text: data.studentName);
    _studentIdCtrl = TextEditingController(text: data.studentId);
    _genderCtrl = TextEditingController(text: data.gender);
    _collegeCtrl = TextEditingController(text: data.college);
    _majorCtrl = TextEditingController(text: data.major);
    _classNameCtrl = TextEditingController(text: data.className);
    _phoneCtrl = TextEditingController(text: data.phone);

    _leaveTypeCtrl = TextEditingController(text: data.leaveType);
    _leaveDestinationCtrl = TextEditingController(text: data.leaveDestination);
    _detailAddressCtrl = TextEditingController(text: data.detailAddress);
    _startTimeCtrl = TextEditingController(text: data.startTime);
    _endTimeCtrl = TextEditingController(text: data.endTime);
    _durationCtrl = TextEditingController(text: data.duration);
    _emergencyContactCtrl = TextEditingController(text: data.emergencyContact);
    _emergencyPhoneCtrl = TextEditingController(text: data.emergencyPhone);
    _leaveReasonCtrl = TextEditingController(text: data.leaveReason);
    _attachmentCtrl = TextEditingController(text: data.attachment);

    _counselorNameCtrl = TextEditingController(text: data.counselorName);
    _timelineApplyTimeCtrl = TextEditingController(text: data.timelineApplyTime);
    _timelineApplyActionCtrl = TextEditingController(text: data.timelineApplyAction);
    _timelineAuditTimeCtrl = TextEditingController(text: data.timelineAuditTime);
    _timelineAuditDecisionCtrl = TextEditingController(text: data.timelineAuditDecision);

    _statusCard1 = data.statusCard1;
  }

  @override
  void dispose() {
    _appTime1Ctrl.dispose();
    _appTime2Ctrl.dispose();
    _appTime3Ctrl.dispose();
    _appTime4Ctrl.dispose();

    _studentNameCtrl.dispose();
    _studentIdCtrl.dispose();
    _genderCtrl.dispose();
    _collegeCtrl.dispose();
    _majorCtrl.dispose();
    _classNameCtrl.dispose();
    _phoneCtrl.dispose();

    _leaveTypeCtrl.dispose();
    _leaveDestinationCtrl.dispose();
    _detailAddressCtrl.dispose();
    _startTimeCtrl.dispose();
    _endTimeCtrl.dispose();
    _durationCtrl.dispose();
    _emergencyContactCtrl.dispose();
    _emergencyPhoneCtrl.dispose();
    _leaveReasonCtrl.dispose();
    _attachmentCtrl.dispose();

    _counselorNameCtrl.dispose();
    _timelineApplyTimeCtrl.dispose();
    _timelineApplyActionCtrl.dispose();
    _timelineAuditTimeCtrl.dispose();
    _timelineAuditDecisionCtrl.dispose();

    super.dispose();
  }

  Future<void> _saveData() async {
    final newData = AppDataModel(
      appTime1: _appTime1Ctrl.text.trim(),
      appTime2: _appTime2Ctrl.text.trim(),
      appTime3: _appTime3Ctrl.text.trim(),
      appTime4: _appTime4Ctrl.text.trim(),
      studentName: _studentNameCtrl.text.trim(),
      studentId: _studentIdCtrl.text.trim(),
      gender: _genderCtrl.text.trim(),
      college: _collegeCtrl.text.trim(),
      major: _majorCtrl.text.trim(),
      className: _classNameCtrl.text.trim(),
      phone: _phoneCtrl.text.trim(),
      leaveType: _leaveTypeCtrl.text.trim(),
      leaveDestination: _leaveDestinationCtrl.text.trim(),
      detailAddress: _detailAddressCtrl.text.trim(),
      startTime: _startTimeCtrl.text.trim(),
      endTime: _endTimeCtrl.text.trim(),
      duration: _durationCtrl.text.trim(),
      emergencyContact: _emergencyContactCtrl.text.trim(),
      emergencyPhone: _emergencyPhoneCtrl.text.trim(),
      leaveReason: _leaveReasonCtrl.text.trim(),
      attachment: _attachmentCtrl.text.trim(),
      counselorName: _counselorNameCtrl.text.trim(),
      timelineApplyTime: _timelineApplyTimeCtrl.text.trim(),
      timelineApplyAction: _timelineApplyActionCtrl.text.trim(),
      timelineAuditTime: _timelineAuditTimeCtrl.text.trim(),
      timelineAuditDecision: _timelineAuditDecisionCtrl.text.trim(),
      statusCard1: _statusCard1,
    );

    await _storageService.save(newData);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✅ 数据修改成功并已持久化保存！'),
          backgroundColor: Color(0xFF52C41A),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _resetToDefaults() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('恢复默认设置'),
        content: const Text('确定将所有页面数据恢复为原型图初始默认值吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('取消'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFF53F3F)),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('确定恢复', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await _storageService.resetToDefaults();
      setState(() {
        _loadControllersFromData(_storageService.data);
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('已恢复原型图初始数据！'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        title: const Text(
          '后台数据管理 (我的)',
          style: TextStyle(
            fontSize: 17.5,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F2329),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        leading: widget.isTabMode
            ? null
            : IconButton(
                icon: const Icon(Icons.arrow_back, color: Color(0xFF1F2329)),
                onPressed: () => Navigator.of(context).pop(),
              ),
        actions: [
          TextButton.icon(
            onPressed: _resetToDefaults,
            icon: const Icon(Icons.restore, size: 18, color: Color(0xFFF53F3F)),
            label: const Text(
              '重置默认',
              style: TextStyle(color: Color(0xFFF53F3F), fontSize: 13),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3370FF),
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              ),
              onPressed: _saveData,
              icon: const Icon(Icons.save, size: 16),
              label: const Text('保存', style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              children: [
                // Banner / Persistence Status Card
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF2B5CE6), Color(0xFF4C84FF)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x332B5CE6),
                        blurRadius: 8,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.verified_user,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            '假APP 数据后台控制中心',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '在此修改的所有数据均实时持久化保存至手机存储。在原型界面中将完完全全对应展示修改后的最新内容。',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12.5,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: const Color(0xFF2B5CE6),
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              onPressed: () {
                                _saveData();
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => const MyApplicationsPage(),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.list_alt, size: 16),
                              label: const Text('预览我的事务', style: TextStyle(fontSize: 12.5)),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white.withOpacity(0.2),
                                foregroundColor: Colors.white,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              onPressed: () {
                                _saveData();
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => const LeaveDetailPage(),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.description, size: 16),
                              label: const Text('预览详情界面', style: TextStyle(fontSize: 12.5)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 14),

                // Group 1: 我的申请列表时间设置
                _buildCardGroup(
                  title: '⏱️ 我的申请列表时间设置',
                  children: [
                    _buildTextField(
                      controller: _appTime1Ctrl,
                      label: '申请1时间 (最新申请，带详情)',
                      hint: '例如：2026-10-11 21:42:44',
                    ),
                    const SizedBox(height: 10),
                    _buildStatusSelector(),
                    const SizedBox(height: 10),
                    _buildTextField(
                      controller: _appTime2Ctrl,
                      label: '申请2时间 (已通过)',
                      hint: '例如：2026-09-26 15:58:27',
                    ),
                    const SizedBox(height: 10),
                    _buildTextField(
                      controller: _appTime3Ctrl,
                      label: '申请3时间 (辅导员审核)',
                      hint: '例如：2026-09-24 18:28:47',
                    ),
                    const SizedBox(height: 10),
                    _buildTextField(
                      controller: _appTime4Ctrl,
                      label: '申请4时间 (辅导员审核)',
                      hint: '例如：2026-09-16 14:29:53',
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                // Group 2: 学生基本信息
                _buildCardGroup(
                  title: '🎓 学生基本信息设置',
                  children: [
                    _buildTextField(
                      controller: _studentNameCtrl,
                      label: '姓名',
                      hint: '例如：张妍硕',
                    ),
                    const SizedBox(height: 10),
                    _buildTextField(
                      controller: _studentIdCtrl,
                      label: '学号',
                      hint: '例如：2026109250019',
                    ),
                    const SizedBox(height: 10),
                    _buildTextField(
                      controller: _genderCtrl,
                      label: '性别',
                      hint: '例如：女 / 男',
                    ),
                    const SizedBox(height: 10),
                    _buildTextField(
                      controller: _collegeCtrl,
                      label: '学院',
                      hint: '例如：文化产业学院',
                    ),
                    const SizedBox(height: 10),
                    _buildTextField(
                      controller: _majorCtrl,
                      label: '专业',
                      hint: '例如：播音与主持',
                    ),
                    const SizedBox(height: 10),
                    _buildTextField(
                      controller: _classNameCtrl,
                      label: '班级',
                      hint: '例如：2026级播音1班',
                    ),
                    const SizedBox(height: 10),
                    _buildTextField(
                      controller: _phoneCtrl,
                      label: '手机号码',
                      hint: '例如：13271551508',
                      keyboardType: TextInputType.phone,
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                // Group 3: 请假信息（新）
                _buildCardGroup(
                  title: '📝 请假详情信息设置',
                  children: [
                    _buildTextField(
                      controller: _leaveTypeCtrl,
                      label: '请假类型',
                      hint: '例如：事假 / 病假',
                    ),
                    const SizedBox(height: 10),
                    _buildTextField(
                      controller: _leaveDestinationCtrl,
                      label: '请假去向',
                      hint: '例如：离校不离市 / 离市',
                    ),
                    const SizedBox(height: 10),
                    _buildTextField(
                      controller: _detailAddressCtrl,
                      label: '详细地址',
                      hint: '例如：四川省眉山市仁寿县天府新区信息职业学院',
                      maxLines: 2,
                    ),
                    const SizedBox(height: 10),
                    _buildTextField(
                      controller: _startTimeCtrl,
                      label: '请假开始时间',
                      hint: '例如：2026-10-12 11:00',
                    ),
                    const SizedBox(height: 10),
                    _buildTextField(
                      controller: _endTimeCtrl,
                      label: '请假结束时间',
                      hint: '例如：2026-10-12 12:00',
                    ),
                    const SizedBox(height: 10),
                    _buildTextField(
                      controller: _durationCtrl,
                      label: '请假时长天',
                      hint: '例如：1小时 / 1天',
                    ),
                    const SizedBox(height: 10),
                    _buildTextField(
                      controller: _emergencyContactCtrl,
                      label: '紧急联系人',
                      hint: '例如：张妍硕',
                    ),
                    const SizedBox(height: 10),
                    _buildTextField(
                      controller: _emergencyPhoneCtrl,
                      label: '紧急联系人电话号码',
                      hint: '例如：13271551508',
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 10),
                    _buildTextField(
                      controller: _leaveReasonCtrl,
                      label: '请假理由',
                      hint: '例如：老师，我的快递滞留了三天，我要去取快递',
                      maxLines: 3,
                    ),
                    const SizedBox(height: 10),
                    _buildTextField(
                      controller: _attachmentCtrl,
                      label: '附件 (留空即无附件)',
                      hint: '留空即可',
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                // Group 4: 办理进度与辅导员审核
                _buildCardGroup(
                  title: '👨‍🏫 办理进度与辅导员审核设置',
                  children: [
                    _buildTextField(
                      controller: _counselorNameCtrl,
                      label: '辅导员审核的名称',
                      hint: '例如：吴思雨',
                    ),
                    const SizedBox(height: 10),
                    _buildTextField(
                      controller: _timelineAuditDecisionCtrl,
                      label: '辅导员审核意见/动作',
                      hint: '例如：同意',
                    ),
                    const SizedBox(height: 10),
                    _buildTextField(
                      controller: _timelineAuditTimeCtrl,
                      label: '辅导员审核时间',
                      hint: '例如：2026-10-11 23:36',
                    ),
                    const SizedBox(height: 10),
                    _buildTextField(
                      controller: _timelineApplyTimeCtrl,
                      label: '流程申请节点时间',
                      hint: '例如：2026-10-11 21:43',
                    ),
                    const SizedBox(height: 10),
                    _buildTextField(
                      controller: _timelineApplyActionCtrl,
                      label: '流程申请节点事由',
                      hint: '例如：取快递',
                    ),
                  ],
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),

          // Bottom Fixed Save Button
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Color(0xFFEEEEEE), width: 0.5),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0x0A000000),
                  blurRadius: 6,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                height: 46,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3370FF),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 1,
                  ),
                  onPressed: _saveData,
                  icon: const Icon(Icons.check_circle_outline, size: 20),
                  label: const Text(
                    '保存并持久化数据',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardGroup({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15.5,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2329),
            ),
          ),
          const Divider(height: 20, color: Color(0xFFF2F3F5)),
          ...children,
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.w500,
            color: Color(0xFF646A73),
          ),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          style: const TextStyle(
            fontSize: 14.5,
            color: Color(0xFF1F2329),
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xFFB0B4BA), fontSize: 13.5),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            filled: true,
            fillColor: const Color(0xFFF9FAFB),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Color(0xFFDFE1E6)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Color(0xFFE5E6EB)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Color(0xFF3370FF), width: 1.5),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '申请1状态 (列表盖章显示)',
          style: TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.w500,
            color: Color(0xFF646A73),
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _statusCard1 = '已通过'),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: _statusCard1 == '已通过'
                        ? const Color(0xFFE8FFEA)
                        : const Color(0xFFF9FAFB),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: _statusCard1 == '已通过'
                          ? const Color(0xFF52C41A)
                          : const Color(0xFFDFE1E6),
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.verified,
                        size: 16,
                        color: _statusCard1 == '已通过'
                            ? const Color(0xFF52C41A)
                            : const Color(0xFF8F959E),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '已通过 (绿印章)',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: _statusCard1 == '已通过'
                              ? const Color(0xFF52C41A)
                              : const Color(0xFF646A73),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _statusCard1 = '辅导员审核'),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: _statusCard1 == '辅导员审核'
                        ? const Color(0xFFE8F3FF)
                        : const Color(0xFFF9FAFB),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: _statusCard1 == '辅导员审核'
                          ? const Color(0xFF3370FF)
                          : const Color(0xFFDFE1E6),
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.pending_actions,
                        size: 16,
                        color: _statusCard1 == '辅导员审核'
                            ? const Color(0xFF3370FF)
                            : const Color(0xFF8F959E),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '当前节点: 辅导员审核',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: _statusCard1 == '辅导员审核'
                              ? const Color(0xFF3370FF)
                              : const Color(0xFF646A73),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
