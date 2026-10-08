import 'package:flutter_test/flutter_test.dart';

import 'package:constellation_cafe/feature/modules/academy/domain/model/academy.dart';
import 'package:constellation_cafe/feature/modules/academy/domain/model/academy_class.dart';
import 'package:constellation_cafe/feature/modules/academy/domain/model/lesson_record/lesson_record_selection.dart';
import 'package:constellation_cafe/feature/modules/academy/domain/model/lesson_record/lesson_record_update.dart';
import 'package:constellation_cafe/feature/modules/academy/domain/model/lesson_record/lesson_time_range.dart';
import 'package:constellation_cafe/feature/modules/academy/domain/model/subject.dart';
import 'package:constellation_cafe/feature/modules/academy/domain/model/teacher.dart';

DateTime at(int hour, int minute) => DateTime(2026, 10, 1, hour, minute);

void main() {
  group('LessonTimeRange', () {
    test('같은 날 수업은 종료와 시작의 차이를 수업 시간으로 본다', () {
      expect(LessonTimeRange.duration(at(19, 0), at(20, 30)).inMinutes, 90);
      expect(LessonTimeRange.endsNextDay(at(19, 0), at(20, 30)), isFalse);
      expect(LessonTimeRange.isValid(at(19, 0), at(20, 30)), isTrue);
    });

    test('종료가 시작보다 이르면 자정을 넘겨 다음 날 끝난 수업으로 본다', () {
      expect(LessonTimeRange.duration(at(22, 30), at(2, 0)).inMinutes, 210);
      expect(LessonTimeRange.endsNextDay(at(22, 30), at(2, 0)), isTrue);
      expect(LessonTimeRange.isValid(at(22, 30), at(2, 0)), isTrue);
    });

    test('자정에 끝나는 수업도 다음 날 종료로 계산한다', () {
      expect(LessonTimeRange.duration(at(22, 0), at(0, 0)).inMinutes, 120);
    });

    test('시작과 종료가 같으면 0분이므로 유효하지 않다', () {
      expect(LessonTimeRange.duration(at(10, 0), at(10, 0)), Duration.zero);
      expect(LessonTimeRange.isValid(at(10, 0), at(10, 0)), isFalse);
      expect(LessonTimeRange.isValidMinutes(600, 600), isFalse);
    });

    test('날짜 부분은 무시하고 시:분만 비교한다', () {
      final start = DateTime(2026, 10, 1, 22, 30);
      final end = DateTime(2026, 9, 1, 23, 0);
      expect(LessonTimeRange.duration(start, end).inMinutes, 30);
    });
  });

  group('LessonRecordSelection.isValid', () {
    LessonRecordSelection filled({
      required DateTime startTime,
      required DateTime endTime,
    }) {
      return LessonRecordSelection(
        selectedAcademy: const Academy(id: 1, name: '별빛 아카데미'),
        selectedAcademyClass: const AcademyClass(
          id: 1,
          classNumber: '1',
          state: AcademyClass.operatingState,
        ),
        selectedSubject: const Subject(id: 1, name: '덱 빌딩'),
        mainTeacher: const Teacher(
          sk: 't1',
          discordID: 'd1',
          name: '박해',
          state: '재적',
        ),
        educationDate: DateTime(2026, 10, 1),
        startTime: startTime,
        endTime: endTime,
      );
    }

    test('자정을 넘기는 수업(22:30 ~ 02:00)도 필수 항목을 채우면 유효하다', () {
      final selection = filled(startTime: at(22, 30), endTime: at(2, 0));
      expect(selection.isValid, isTrue);
    });

    test('시작과 종료가 같으면 유효하지 않다', () {
      final selection = filled(startTime: at(10, 0), endTime: at(10, 0));
      expect(selection.isValid, isFalse);
    });
  });

  test('수업 기록 수정은 자정을 넘긴 수업 길이를 양수 분으로 보낸다', () {
    final update = LessonRecordUpdate(
      subject: '덱 빌딩',
      educationDate: DateTime(2026, 10, 1),
      startTime: at(22, 30),
      endTime: at(2, 0),
      description: '',
    );

    final body = update.toJson();
    expect(body['educationDuration'], 210);
    expect(body['startTime'], '22:30:00');
    expect(body['endTime'], '02:00:00');
  });
}
