import '../domain/academy.dart';
import '../domain/teacher.dart';
import '../domain/member.dart';
import '../domain/lesson_record.dart';

class AcademyApi {
  Future<List<Academy>> getAcademies() async {
    await Future.delayed(const Duration(milliseconds: 300));

    return const [
      Academy(
        id: 'academy-1',
        name: 'Constellation Academy',
      ),
      Academy(
        id: 'academy-2',
        name: 'Star Academy',
      ),
    ];
  }

  Future<List<String>> getClasses(String academyId) async {
    await Future.delayed(const Duration(milliseconds: 200));

    return const [
      '1반',
      '2반',
      '3반',
    ];
  }

  Future<List<String>> getSubjects(String academyId) async {
    await Future.delayed(const Duration(milliseconds: 200));

    return const [
      '데이터 분석',
      'Python',
      '웹 개발',
      'AI / 머신러닝',
    ];
  }

  /// TODO:
  /// 백엔드에서 해당 아카데미의 교사 목록을 가져오는 API
  Future<List<AcademyTeacher>> getTeachers(
      String academyId,
      ) async {
    await Future.delayed(const Duration(milliseconds: 300));

    return const [
      AcademyTeacher(
        id: 'teacher-1',
        name: '최준영',
      ),
      AcademyTeacher(
        id: 'teacher-2',
        name: '김민수',
      ),
      AcademyTeacher(
        id: 'teacher-3',
        name: '이지훈',
      ),
      AcademyTeacher(
        id: 'teacher-4',
        name: '박서연',
      ),
    ];
  }

  /// TODO:
  /// 백엔드에서 채팅방 멤버 목록을 가져오는 API
  Future<List<ChatMember>> getChatMembers(
      String academyId,
      String className,
      ) async {
    await Future.delayed(const Duration(milliseconds: 300));

    return const [
      ChatMember(
        id: 'member-1',
        name: '김민지',
      ),
      ChatMember(
        id: 'member-2',
        name: '이지원',
      ),
      ChatMember(
        id: 'member-3',
        name: '박서준',
      ),
      ChatMember(
        id: 'member-4',
        name: '최유나',
      ),
      ChatMember(
        id: 'member-5',
        name: '홍길동',
      ),
    ];
  }

  /// TODO:
  /// 실제 구현에서는 POST /academy/lesson-record
  Future<void> createLessonRecord(
      LessonRecord record,
      ) async {
    await Future.delayed(const Duration(milliseconds: 500));

    print('===== Lesson Record =====');
    print('academyId: ${record.academyId}');
    print('className: ${record.className}');
    print('subject: ${record.subject}');
    print('mainTeacherId: ${record.mainTeacherId}');
    print('coTeacherIds: ${record.coTeacherIds}');
    print('memberIds: ${record.memberIds}');
    print('description: ${record.description}');
  }
}