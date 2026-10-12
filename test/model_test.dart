import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/models/app_data_model.dart';
import 'package:app/services/storage_service.dart';

void main() {
  test('AppDataModel serialization and defaults', () {
    final model = AppDataModel.defaults();
    expect(model.studentName, '张妍硕');
    expect(model.studentId, '2026109250019');
    expect(model.gender, '女');
    expect(model.college, '文化产业学院');
    expect(model.major, '播音与主持');
    expect(model.className, '2026级播音1班');
    expect(model.phone, '13271551508');
    expect(model.leaveType, '事假');
    expect(model.leaveDestination, '离校不离市');
    expect(model.detailAddress, '四川省眉山市仁寿县天府新区信息职业学院');
    expect(model.startTime, '2026-10-12 11:00');
    expect(model.endTime, '2026-10-12 12:00');
    expect(model.duration, '1小时');
    expect(model.emergencyContact, '张妍硕');
    expect(model.emergencyPhone, '13271551508');
    expect(model.leaveReason, '老师，我的快递滞留了三天，我要去取快递');
    expect(model.counselorName, '吴思雨');
    expect(model.appTime1, '2026-10-11 21:42:44');

    // Test toJson and fromJson
    final jsonStr = model.toJson();
    final restored = AppDataModel.fromJson(jsonStr);
    expect(restored.studentName, model.studentName);
    expect(restored.counselorName, model.counselorName);
    expect(restored.appTime1, model.appTime1);
  });

  test('StorageService save and persistence', () async {
    SharedPreferences.setMockInitialValues({});
    final storage = StorageService();
    await storage.init();

    final modified = storage.data.copyWith(
      studentName: '李同学',
      counselorName: '陈老师',
      appTime1: '2026-10-15 09:30:00',
    );
    await storage.save(modified);

    expect(storage.data.studentName, '李同学');
    expect(storage.data.counselorName, '陈老师');
    expect(storage.data.appTime1, '2026-10-15 09:30:00');

    // Verify resetToDefaults
    await storage.resetToDefaults();
    expect(storage.data.studentName, '张妍硕');
    expect(storage.data.counselorName, '吴思雨');
  });
}
