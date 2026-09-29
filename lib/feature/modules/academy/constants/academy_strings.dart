/// 아카데미 기능의 사용자 노출 문자열과 표시 형식.
abstract final class AcademyStrings {
  // 메뉴
  static const menuTitle = '아카데미 메뉴';
  static const menuWriteLessonRecord = '수업 기록';
  static const menuReadLessonRecord = '수업 기록 조회';
  static const menuTeacherManagement = '교사 관리';
  static const menuReadTeacherStatus = '교사 조회';
  static const menuStudentManagement = '학생 관리';
  static const menuReadStudentStatus = '학생 조회';

  // 상태 이름
  static const enrolled = '재적';
  static const graduated = '졸업';
  static const expelled = '퇴학';
  static const withdrawn = '자퇴';
  static const retired = '퇴직';
  static const retirement = '은퇴';
  static const disciplinary = '징계';

  // 공통
  static const all = '전체';
  static const allAcademies = '전체 아카데미';
  static const allClasses = '전체 분반';
  static const academy = '아카데미';
  static const academyName = '아카데미 이름';
  static const academyRequired = '아카데미 *';
  static const academyClass = '분반';
  static const classRequired = '분반 *';
  static const subject = '과목';
  static const subjects = '교과목';
  static const date = '날짜';
  static const time = '시간';
  static const morning = '오전';
  static const afternoon = '오후';
  static const cancel = '취소';
  static const delete = '삭제';
  static const reset = '초기화';
  static const search = '조회';
  static const save = '저장하기';
  static const saveShort = '저장';
  static const saving = '저장 중...';
  static const process = '처리하기';
  static const processing = '처리 중...';
  static const requiredMark = ' *';
  static const emptyValue = '-';
  static const emptyTime = '--:--';
  static const timeRangeSeparator = '~';
  static const checkRequiredFields = '필수 항목을 확인해주세요.';
  static const selectAcademy = '아카데미를 선택하세요';
  static const selectClass = '분반을 선택하세요';
  static const selectSubject = '과목을 선택하세요';
  static const selectDate = '날짜를 선택하세요';
  static const loadFailed = '정보를 불러오거나 처리하지 못했습니다. 잠시 후 다시 시도해주세요.';
  static const retry = '다시 시도';

  // 수업 기록 작성
  static const lessonManagement = '수업 관리';
  static const writeLessonRecordTitle = '수업 내용 기록';
  static const writeLessonRecordDescription =
      '수업의 기본 정보를 입력하고 함께한 교사와 멤버를 선택해주세요.';
  static const basicInfo = '기본 정보';
  static const educationDate = '교육 일시';
  static const educationTime = '교육 시간';
  static const teacherInfo = '교사 정보';
  static const mainTeacher = '담당 교사 (나)';
  static const selectMainTeacher = '담당 교사를 선택하세요';
  static const coTeacher = '함께 가르친 교사';
  static const selectTeacherName = '교사 이름을 선택하세요';
  static const participants = '참여 학생';
  static const selectAll = '전체 선택';
  static const searchMemberHint = '멤버 이름을 검색하세요';
  static const lessonDescription = '수업 설명';
  static const lessonDescriptionHint = '수업 내용, 목표, 진행 내용 등을 자유롭게 작성해주세요.';
  static const lessonRecordSaved = '수업 기록이 저장되었습니다.';

  // 수업 기록 조회
  static const readLessonRecordTitle = '수업 내용 조회';
  static const readLessonRecordDescription = '기록한 수업 내용을 조회할 수 있습니다.';
  static const noLessonRecords = '조회된 수업 기록이 없습니다.';
  static const noLessonDescription = '작성된 수업 내용이 없습니다.';
  static const editLessonRecord = '수업 기록 수정';
  static const deleteLessonRecord = '수업 기록 삭제';
  static const deleteLessonRecordConfirm =
      '이 수업 기록을 삭제할까요? 삭제한 기록은 복구할 수 없습니다.';
  static const lessonDate = '수업 날짜';
  static const startTime = '시작 시간';
  static const endTime = '종료 시간';
  static const lessonContent = '수업 내용';
  static const invalidLessonUpdate = '과목과 올바른 수업 시간 범위를 입력해주세요.';
  static const lessonRecordUpdated = '수업 기록을 수정했습니다.';
  static const lessonRecordUpdateFailed = '수업 기록 수정에 실패했습니다.';
  static const lessonRecordDeleted = '수업 기록을 삭제했습니다.';
  static const lessonRecordDeleteFailed = '수업 기록 삭제에 실패했습니다.';

  // 학생·교사 상태
  static const student = '학생';
  static const teacher = '교사';
  static const studentManagement = '학생 관리';
  static const teacherManagement = '교사 관리';
  static const studentInfo = '학생 정보';
  static const studentStatus = '학생 상태';
  static const teacherStatus = '교사 상태';
  static const studentSummary = '학생 현황';
  static const teacherSummary = '교사 현황';
  static const studentRoster = '학생 명단';
  static const teacherRoster = '교사 명단';
  static const studentName = '학생명';
  static const teacherName = '교사명';
  static const noStudents = '조회된 학생이 없습니다.';
  static const noTeachers = '조회된 교사가 없습니다.';
  static const editStudentStatusTitle = '학생 상태 처리';
  static const editTeacherStatusTitle = '교사 상태 처리';
  static const editStudentStatusDescription = '학생의 졸업, 퇴학, 자퇴 처리를 진행합니다.';
  static const editTeacherStatusDescription = '교사의 은퇴, 징계 처리를 진행합니다.';
  static const readStudentStatusTitle = '학생 상태 조회';
  static const readTeacherStatusTitle = '교사 상태 조회';
  static const readStudentStatusDescription = '학생의 재적, 졸업, 퇴학, 자퇴 명단을 조회합니다.';
  static const readTeacherStatusDescription = '교사의 재적, 은퇴, 징계 명단을 조회합니다.';
  static const processInfo = '처리 정보';
  static const processTypeRequired = '처리 유형 *';
  static const processReason = '처리 사유';
  static const processReasonHint = '처리 사유를 입력하세요';
  static const graduationSubjects = '졸업 교과목';
  static const subjectOptionalHelper = '교과목은 선택하지 않아도 됩니다.';
  static const noSelectableSubjects = '선택 가능한 교과목이 없습니다.';
  static const studentStatusProcessed = '학생 상태 처리가 완료되었습니다.';
  static const teacherStatusProcessed = '교사 상태 처리가 완료되었습니다.';
  static const queryConditions = '조회 조건';
  static const number = '번호';
  static const status = '상태';
  static const changedAt = '변경일';
  static const changeReason = '변경 사유';

  static String classNumber(String classNumber) => '$classNumber분반';
  static String academyAndClass(String academyName, String classNumber) =>
      '$academyName · $classNumber분반';
  static String mainTeacherInfo(String name) => '담당 교사: $name';
  static String lessonTimeInfo(String timeRange, int minutes) =>
      '수업 시간: $timeRange · $minutes분';
  static String memberCountInfo(int count) => '수강자: $count명';
  static String selectedCount(int count) => '총 $count명 선택됨';
  static String peopleCount(int count) => '$count명';
  static String memberInfo(String memberLabel) => '$memberLabel 정보';
  static String requiredLabel(String label) => '$label *';
  static String selectMember(String memberLabel) => '$memberLabel(을/를) 선택하세요';
  static String allOf(String label) => '전체 $label';
  static String timeRange(String start, String end) => '$start ~ $end';

  /// 입력 필드에 표시하는 날짜. 예: 2026. 09. 29
  static String formatDate(DateTime date) =>
      '${date.year}. ${_twoDigits(date.month)}. ${_twoDigits(date.day)}';

  /// 목록에 표시하는 날짜. 예: 2026.09.29
  static String formatCompactDate(DateTime date) =>
      '${date.year}.${_twoDigits(date.month)}.${_twoDigits(date.day)}';

  /// 24시간 형식 시각. 예: 09:05
  static String formatTime(DateTime time) =>
      '${_twoDigits(time.hour)}:${_twoDigits(time.minute)}';

  static String _twoDigits(int value) => value.toString().padLeft(2, '0');
}
