import 'dart:convert';

class AppDataModel {
  // 申请列表时间
  String appTime1;
  String appTime2;
  String appTime3;
  String appTime4;

  // 学生基本信息
  String studentName;
  String studentId;
  String gender;
  String college;
  String major;
  String className;
  String phone;

  // 请假信息（新）
  String leaveType;
  String leaveDestination;
  String detailAddress;
  String startTime;
  String endTime;
  String duration;
  String emergencyContact;
  String emergencyPhone;
  String leaveReason;
  String attachment;

  // 办理进度及辅导员审核
  String counselorName;
  String timelineApplyTime;
  String timelineApplyAction;
  String timelineAuditTime;
  String timelineAuditDecision;
  String statusCard1; // '已通过' or '辅导员审核'

  AppDataModel({
    required this.appTime1,
    required this.appTime2,
    required this.appTime3,
    required this.appTime4,
    required this.studentName,
    required this.studentId,
    required this.gender,
    required this.college,
    required this.major,
    required this.className,
    required this.phone,
    required this.leaveType,
    required this.leaveDestination,
    required this.detailAddress,
    required this.startTime,
    required this.endTime,
    required this.duration,
    required this.emergencyContact,
    required this.emergencyPhone,
    required this.leaveReason,
    required this.attachment,
    required this.counselorName,
    required this.timelineApplyTime,
    required this.timelineApplyAction,
    required this.timelineAuditTime,
    required this.timelineAuditDecision,
    required this.statusCard1,
  });

  factory AppDataModel.defaults() {
    return AppDataModel(
      appTime1: '2026-10-11 21:42:44',
      appTime2: '2026-09-26 15:58:27',
      appTime3: '2026-09-24 18:28:47',
      appTime4: '2026-09-16 14:29:53',
      studentName: '张妍硕',
      studentId: '2026109250019',
      gender: '女',
      college: '文化产业学院',
      major: '播音与主持',
      className: '2026级播音1班',
      phone: '13271551508',
      leaveType: '事假',
      leaveDestination: '离校不离市',
      detailAddress: '四川省眉山市仁寿县天府新区信息职业学院',
      startTime: '2026-10-12 11:00',
      endTime: '2026-10-12 12:00',
      duration: '1小时',
      emergencyContact: '张妍硕',
      emergencyPhone: '13271551508',
      leaveReason: '老师，我的快递滞留了三天，我要去取快递',
      attachment: '',
      counselorName: '吴思雨',
      timelineApplyTime: '2026-10-11 21:43',
      timelineApplyAction: '取快递',
      timelineAuditTime: '2026-10-11 23:36',
      timelineAuditDecision: '同意',
      statusCard1: '已通过',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'appTime1': appTime1,
      'appTime2': appTime2,
      'appTime3': appTime3,
      'appTime4': appTime4,
      'studentName': studentName,
      'studentId': studentId,
      'gender': gender,
      'college': college,
      'major': major,
      'className': className,
      'phone': phone,
      'leaveType': leaveType,
      'leaveDestination': leaveDestination,
      'detailAddress': detailAddress,
      'startTime': startTime,
      'endTime': endTime,
      'duration': duration,
      'emergencyContact': emergencyContact,
      'emergencyPhone': emergencyPhone,
      'leaveReason': leaveReason,
      'attachment': attachment,
      'counselorName': counselorName,
      'timelineApplyTime': timelineApplyTime,
      'timelineApplyAction': timelineApplyAction,
      'timelineAuditTime': timelineAuditTime,
      'timelineAuditDecision': timelineAuditDecision,
      'statusCard1': statusCard1,
    };
  }

  factory AppDataModel.fromMap(Map<String, dynamic> map) {
    final def = AppDataModel.defaults();
    return AppDataModel(
      appTime1: map['appTime1'] ?? def.appTime1,
      appTime2: map['appTime2'] ?? def.appTime2,
      appTime3: map['appTime3'] ?? def.appTime3,
      appTime4: map['appTime4'] ?? def.appTime4,
      studentName: map['studentName'] ?? def.studentName,
      studentId: map['studentId'] ?? def.studentId,
      gender: map['gender'] ?? def.gender,
      college: map['college'] ?? def.college,
      major: map['major'] ?? def.major,
      className: map['className'] ?? def.className,
      phone: map['phone'] ?? def.phone,
      leaveType: map['leaveType'] ?? def.leaveType,
      leaveDestination: map['leaveDestination'] ?? def.leaveDestination,
      detailAddress: map['detailAddress'] ?? def.detailAddress,
      startTime: map['startTime'] ?? def.startTime,
      endTime: map['endTime'] ?? def.endTime,
      duration: map['duration'] ?? def.duration,
      emergencyContact: map['emergencyContact'] ?? def.emergencyContact,
      emergencyPhone: map['emergencyPhone'] ?? def.emergencyPhone,
      leaveReason: map['leaveReason'] ?? def.leaveReason,
      attachment: map['attachment'] ?? def.attachment,
      counselorName: map['counselorName'] ?? def.counselorName,
      timelineApplyTime: map['timelineApplyTime'] ?? def.timelineApplyTime,
      timelineApplyAction: map['timelineApplyAction'] ?? def.timelineApplyAction,
      timelineAuditTime: map['timelineAuditTime'] ?? def.timelineAuditTime,
      timelineAuditDecision: map['timelineAuditDecision'] ?? def.timelineAuditDecision,
      statusCard1: map['statusCard1'] ?? def.statusCard1,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppDataModel.fromJson(String source) =>
      AppDataModel.fromMap(json.decode(source));

  AppDataModel copyWith({
    String? appTime1,
    String? appTime2,
    String? appTime3,
    String? appTime4,
    String? studentName,
    String? studentId,
    String? gender,
    String? college,
    String? major,
    String? className,
    String? phone,
    String? leaveType,
    String? leaveDestination,
    String? detailAddress,
    String? startTime,
    String? endTime,
    String? duration,
    String? emergencyContact,
    String? emergencyPhone,
    String? leaveReason,
    String? attachment,
    String? counselorName,
    String? timelineApplyTime,
    String? timelineApplyAction,
    String? timelineAuditTime,
    String? timelineAuditDecision,
    String? statusCard1,
  }) {
    return AppDataModel(
      appTime1: appTime1 ?? this.appTime1,
      appTime2: appTime2 ?? this.appTime2,
      appTime3: appTime3 ?? this.appTime3,
      appTime4: appTime4 ?? this.appTime4,
      studentName: studentName ?? this.studentName,
      studentId: studentId ?? this.studentId,
      gender: gender ?? this.gender,
      college: college ?? this.college,
      major: major ?? this.major,
      className: className ?? this.className,
      phone: phone ?? this.phone,
      leaveType: leaveType ?? this.leaveType,
      leaveDestination: leaveDestination ?? this.leaveDestination,
      detailAddress: detailAddress ?? this.detailAddress,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      duration: duration ?? this.duration,
      emergencyContact: emergencyContact ?? this.emergencyContact,
      emergencyPhone: emergencyPhone ?? this.emergencyPhone,
      leaveReason: leaveReason ?? this.leaveReason,
      attachment: attachment ?? this.attachment,
      counselorName: counselorName ?? this.counselorName,
      timelineApplyTime: timelineApplyTime ?? this.timelineApplyTime,
      timelineApplyAction: timelineApplyAction ?? this.timelineApplyAction,
      timelineAuditTime: timelineAuditTime ?? this.timelineAuditTime,
      timelineAuditDecision: timelineAuditDecision ?? this.timelineAuditDecision,
      statusCard1: statusCard1 ?? this.statusCard1,
    );
  }
}
